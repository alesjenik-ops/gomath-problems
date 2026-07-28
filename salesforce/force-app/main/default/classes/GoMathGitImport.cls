/**
 * Dávkový import GoMath úloh přímo z GitHub repozitáře.
 *
 * Načte vygenerované anonymní Apex skripty (`scripts/apex/**.apex`) z gitu
 * a spustí je v orgu přes Apex SOAP API (executeAnonymous).
 *
 * Proč executeAnonymous: skripty jsou anonymní Apex (limit ~9 KB / kus) a každý
 * běží ve VLASTNÍ transakci, takže se governor limity nesčítají napříč soubory.
 *
 * Idempotence: skripty samy přeskočí úlohy, které už v orgu existují
 * (podle Math_Problem__c.Name), takže opakované spuštění nic nezduplikuje.
 *
 * Spuštění (Developer Console → Execute Anonymous):
 *     GoMathGitImport.run();                       // vše (Zelený + CERMAT)
 *     GoMathGitImport.run('cermat/import-cermat-M5A-2026');  // jen podmnožina
 *     GoMathGitImport.dryRun();                    // jen stáhne a spočítá, nic nespustí
 */
public with sharing class GoMathGitImport implements Database.Batchable<String>, Database.AllowsCallouts, Database.Stateful {

    public class ImportException extends Exception {}

    // ---------------------------------------------------------------- konfigurace
    //
    // POZOR: konfigurace jsou INSTANČNÍ pole, ne statická. Batch běží asynchronně
    // v nové transakci, kde by se statika znovu inicializovala na výchozí hodnotu —
    // instanční pole se serializují s jobem, takže nastavení před executeBatch platí.

    /** Základ GitHub API. Výchozí je přímá URL (veřejný repozitář + Remote Site Setting
     *  GitHub_API). Pro privátní repo nastav 'callout:GoMath_GitHub' (Named Credential s tokenem). */
    public String githubBase = 'https://api.github.com';

    /** Named Credential mířící na vlastní org (My Domain URL), Named Principal + OAuth 2.0. */
    public String selfBase = 'callout:GoMath_Self';

    /** Verze API pro SOAP endpoint. */
    public String apiVersion = '62.0';

    public String repoOwner  = 'alesjenik-ops';
    public String repoName   = 'gomath-problems';
    public String branch     = 'claude/prepare-task-imports-sejoir';
    public String pathPrefix = 'scripts/apex/';

    /** Volitelný filtr — zpracují se jen cesty obsahující tento řetězec. */
    public String fileFilter;

    /** true = soubory se jen stáhnou a zvaliduje se dostupnost, nic se nespustí. */
    public Boolean dryRunOnly = false;

    /** Komu poslat souhrn na konci (prázdné = neposílat). */
    public String notifyEmail;

    // ---------------------------------------------------------------- stav (Stateful)

    public Integer filesTotal = 0;
    public Integer filesOk = 0;
    public Integer filesFailed = 0;
    public List<String> failures = new List<String>();

    // ---------------------------------------------------------------- vstupní body

    public GoMathGitImport() {}

    public GoMathGitImport(String fileFilter) {
        this.fileFilter = fileFilter;
    }

    /** Spustí import všech skriptů. Scope MUSÍ být 1 — každý soubor = vlastní transakce a 2 callouty. */
    public static Id run() {
        return Database.executeBatch(new GoMathGitImport(), 1);
    }

    /** Spustí import jen pro cesty obsahující `fileFilter`. */
    public static Id run(String fileFilter) {
        return Database.executeBatch(new GoMathGitImport(fileFilter), 1);
    }

    /** Nasucho: ověří dostupnost repozitáře a stáhne soubory, ale nic v orgu nevytvoří. */
    public static Id dryRun() {
        GoMathGitImport b = new GoMathGitImport();
        b.dryRunOnly = true;
        return Database.executeBatch(b, 1);
    }

    // ---------------------------------------------------------------- Batchable

    public Iterable<String> start(Database.BatchableContext bc) {
        List<String> paths = listApexFiles();
        filesTotal = paths.size();
        System.debug(LoggingLevel.INFO, 'GoMathGitImport: k importu ' + filesTotal + ' souborů');
        return paths;
    }

    public void execute(Database.BatchableContext bc, List<String> scope) {
        for (String path : scope) {
            try {
                String code = fetchFile(path);
                if (String.isBlank(code)) {
                    throw new ImportException('prázdný soubor');
                }
                if (!dryRunOnly) {
                    runAnonymous(code);
                }
                filesOk++;
            } catch (Exception e) {
                filesFailed++;
                if (failures.size() < 200) {
                    failures.add(path + ' → ' + e.getMessage());
                }
                System.debug(LoggingLevel.ERROR, 'GoMathGitImport CHYBA ' + path + ': ' + e.getMessage());
            }
        }
    }

    public void finish(Database.BatchableContext bc) {
        String summary = 'GoMathGitImport hotovo: ' + filesOk + ' OK, ' + filesFailed
            + ' chyb (z ' + filesTotal + ' souborů).';
        if (!failures.isEmpty()) {
            summary += '\n\nChyby:\n' + String.join(failures, '\n');
        }
        System.debug(LoggingLevel.INFO, summary);

        if (String.isNotBlank(notifyEmail)) {
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setToAddresses(new List<String>{ notifyEmail });
            m.setSubject('GoMath import z GitHubu: ' + filesOk + ' OK / ' + filesFailed + ' chyb');
            m.setPlainTextBody(summary);
            try {
                Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ m });
            } catch (Exception e) {
                System.debug(LoggingLevel.WARN, 'E-mail se nepodařilo odeslat: ' + e.getMessage());
            }
        }
    }

    // ---------------------------------------------------------------- GitHub

    /** Vylistuje všechny `.apex` soubory pod `pathPrefix` na dané větvi. */
    @TestVisible
    private List<String> listApexFiles() {
        // 1) větev → SHA commitu (dvoukrokově, protože název větve obsahuje lomítka)
        Map<String, Object> ref = (Map<String, Object>) JSON.deserializeUntyped(
            gitHubGet('/git/ref/heads/' + branch, 'application/vnd.github+json')
        );
        Object obj = ref.get('object');
        if (!(obj instanceof Map<String, Object>)) {
            throw new ImportException('Větev "' + branch + '" nenalezena v ' + repoOwner + '/' + repoName);
        }
        String sha = (String) ((Map<String, Object>) obj).get('sha');

        // 2) rekurzivní výpis stromu
        Map<String, Object> tree = (Map<String, Object>) JSON.deserializeUntyped(
            gitHubGet('/git/trees/' + sha + '?recursive=1', 'application/vnd.github+json')
        );
        Boolean truncated = (Boolean) tree.get('truncated');
        if (truncated == true) {
            throw new ImportException('Výpis stromu je zkrácený (repozitář je příliš velký) — '
                + 'zúžit rozsah přes fileFilter nebo pathPrefix.');
        }

        List<String> paths = new List<String>();
        for (Object node : (List<Object>) tree.get('tree')) {
            Map<String, Object> n = (Map<String, Object>) node;
            if (!'blob'.equals(n.get('type'))) {
                continue;
            }
            String p = (String) n.get('path');
            if (p == null || !p.startsWith(pathPrefix) || !p.endsWith('.apex')) {
                continue;
            }
            if (String.isNotBlank(fileFilter) && !p.contains(fileFilter)) {
                continue;
            }
            paths.add(p);
        }
        paths.sort();
        return paths;
    }

    /** Stáhne obsah souboru (funguje i pro privátní repo, pokud Named Credential nese token). */
    @TestVisible
    private String fetchFile(String path) {
        return gitHubGet(
            '/contents/' + encodePath(path) + '?ref=' + EncodingUtil.urlEncode(branch, 'UTF-8'),
            'application/vnd.github.raw'
        );
    }

    private String gitHubGet(String relativePath, String accept) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(githubBase + '/repos/' + repoOwner + '/' + repoName + relativePath);
        req.setMethod('GET');
        req.setHeader('Accept', accept);
        req.setHeader('User-Agent', 'GoMathGitImport');
        req.setHeader('X-GitHub-Api-Version', '2022-11-28');
        req.setTimeout(120000);

        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() != 200) {
            throw new ImportException('GitHub HTTP ' + res.getStatusCode() + ' ('
                + relativePath + '): ' + abbrev(res.getBody(), 300));
        }
        return res.getBody();
    }

    /** URL-enkóduje jednotlivé segmenty cesty, lomítka ponechá. */
    @TestVisible
    private static String encodePath(String path) {
        List<String> parts = new List<String>();
        for (String seg : path.split('/')) {
            parts.add(EncodingUtil.urlEncode(seg, 'UTF-8').replace('+', '%20'));
        }
        return String.join(parts, '/');
    }

    // ---------------------------------------------------------------- executeAnonymous

    /**
     * Spustí anonymní Apex přes SOAP Apex API.
     * SOAP (ne Tooling REST) proto, že skripty mají až ~9 KB — v REST variantě
     * se kód předává v URL a po enkódování by překročil limit délky URI.
     *
     * `{!$Credential.OAuthToken}` doplní Salesforce z Named Credentialu; vyžaduje
     * zapnuté "Allow Merge Fields in HTTP Body".
     */
    @TestVisible
    private void runAnonymous(String code) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(selfBase + '/services/Soap/s/' + apiVersion);
        req.setMethod('POST');
        req.setHeader('Content-Type', 'text/xml; charset=UTF-8');
        req.setHeader('SOAPAction', '""');
        req.setTimeout(120000);
        req.setBody(
            '<?xml version="1.0" encoding="utf-8"?>'
          + '<env:Envelope xmlns:env="http://schemas.xmlsoap.org/soap/envelope/"'
          + ' xmlns:apex="http://soap.sforce.com/2006/08/apex">'
          + '<env:Header><apex:SessionHeader>'
          + '<apex:sessionId>{!$Credential.OAuthToken}</apex:sessionId>'
          + '</apex:SessionHeader></env:Header>'
          + '<env:Body><apex:executeAnonymous><apex:String>'
          + xmlEscape(code)
          + '</apex:String></apex:executeAnonymous></env:Body>'
          + '</env:Envelope>'
        );

        HttpResponse res = new Http().send(req);
        String body = res.getBody();

        if (res.getStatusCode() != 200) {
            throw new ImportException('executeAnonymous HTTP ' + res.getStatusCode()
                + ': ' + abbrev(firstTag(body, 'faultstring', body), 400));
        }
        if (!'true'.equals(firstTag(body, 'compiled', ''))) {
            throw new ImportException('nezkompilováno (řádek '
                + firstTag(body, 'line', '?') + '): '
                + abbrev(firstTag(body, 'compileProblem', '?'), 400));
        }
        if (!'true'.equals(firstTag(body, 'success', ''))) {
            throw new ImportException('běhová chyba: '
                + abbrev(firstTag(body, 'exceptionMessage', '?'), 400)
                + ' | ' + abbrev(firstTag(body, 'exceptionStackTrace', ''), 300));
        }
    }

    // ---------------------------------------------------------------- pomocné

    @TestVisible
    private static String xmlEscape(String s) {
        return s.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;');
    }

    /** Vytáhne text prvního výskytu <tag>…</tag> (SOAP odpověď má tato pole plochá). */
    @TestVisible
    private static String firstTag(String body, String tagName, String fallback) {
        if (String.isBlank(body)) {
            return fallback;
        }
        Integer openIdx = body.indexOf('<' + tagName + '>');
        if (openIdx < 0) {
            return fallback;
        }
        Integer closeIdx = body.indexOf('</' + tagName + '>', openIdx);
        if (closeIdx < 0) {
            return fallback;
        }
        return body.substring(openIdx + tagName.length() + 2, closeIdx);
    }

    private static String abbrev(String s, Integer max) {
        if (s == null) {
            return '';
        }
        return s.length() <= max ? s : s.substring(0, max) + '…';
    }
}
