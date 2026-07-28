/**
 * Dávkový import GoMath úloh z GitHubu — BEZ Named Credentialů.
 *
 * Na rozdíl od GoMathGitImport nespouští anonymní Apex (kvůli kterému byl potřeba
 * Named Credential na vlastní org), ale stáhne data v JSON (`scripts/json/*.json`)
 * a záznamy vloží přímo DML. Jediný callout jde na api.github.com (veřejný
 * repozitář), který pokrývá Remote Site Setting GitHub_API z tohoto balíku.
 *
 * Jeden JSON soubor = jeden test (max ~22 úloh), jeden execute() = jeden soubor
 * (scope = 1), takže DML limity bezpečně stačí (~5 DML na úlohu, limit 150).
 *
 * Idempotence: úlohy, které už v orgu existují (Math_Problem__c.Name), se přeskočí.
 * Chyba jednoho souboru job nezhavaruje — soubor se odroluje (savepoint) a chyba
 * se vypíše v finish().
 *
 * Spuštění (Developer Console → Execute Anonymous):
 *     GoMathJsonImport.dryRun();                  // jen stáhne a spočítá, nic nevloží
 *     GoMathJsonImport.run('cermat-M5A_2026');    // jen jeden test
 *     GoMathJsonImport.run();                     // všechno (Zelený + CERMAT)
 */
public with sharing class GoMathJsonImport implements Database.Batchable<String>, Database.AllowsCallouts, Database.Stateful {

    public class ImportException extends Exception {}

    // ---------------------------------------------------------------- konfigurace
    // Instanční pole (ne statická) — serializují se s jobem, takže nastavení
    // před Database.executeBatch platí i v asynchronním kontextu.

    /** Základ GitHub API; pro privátní repo přepnout na 'callout:GoMath_GitHub'. */
    public String githubBase = 'https://api.github.com';

    public String repoOwner = 'alesjenik-ops';
    public String repoName  = 'gomath-problems';
    public String branch    = 'claude/prepare-task-imports-sejoir';

    /** Index se seznamem všech JSON souborů (generuje scripts/generator/export_json.py). */
    public String indexPath = 'scripts/json/index.json';

    /** Volitelný filtr — zpracují se jen cesty obsahující tento řetězec. */
    public String fileFilter;

    /** true = soubory se jen stáhnou a rozparsují, žádné DML. */
    public Boolean dryRunOnly = false;

    /** Komu poslat souhrn na konci (prázdné = neposílat). */
    public String notifyEmail;

    // ---------------------------------------------------------------- stav (Stateful)

    public Integer filesTotal = 0;
    public Integer filesOk = 0;
    public Integer filesFailed = 0;
    public Integer problemsCreated = 0;
    public Integer problemsSkipped = 0;
    public List<String> failures = new List<String>();

    // ---------------------------------------------------------------- vstupní body

    /** Import všeho. Scope MUSÍ být 1 (jeden soubor = jedna transakce). */
    public static Id run() {
        return Database.executeBatch(new GoMathJsonImport(), 1);
    }

    /** Import jen souborů, jejichž cesta obsahuje `fileFilter`. */
    public static Id run(String fileFilter) {
        GoMathJsonImport b = new GoMathJsonImport();
        b.fileFilter = fileFilter;
        return Database.executeBatch(b, 1);
    }

    /** Nanečisto: stáhne a rozparsuje, ale nic nevloží. */
    public static Id dryRun() {
        GoMathJsonImport b = new GoMathJsonImport();
        b.dryRunOnly = true;
        return Database.executeBatch(b, 1);
    }

    // ---------------------------------------------------------------- Batchable

    public Iterable<String> start(Database.BatchableContext bc) {
        Map<String, Object> idx = (Map<String, Object>) JSON.deserializeUntyped(fetchFile(indexPath));
        List<String> paths = new List<String>();
        for (Object o : (List<Object>) idx.get('files')) {
            String p = (String) o;
            if (String.isBlank(fileFilter) || p.contains(fileFilter)) {
                paths.add(p);
            }
        }
        paths.sort();
        filesTotal = paths.size();
        System.debug(LoggingLevel.INFO, 'GoMathJsonImport: k importu ' + filesTotal + ' souborů');
        return paths;
    }

    public void execute(Database.BatchableContext bc, List<String> scope) {
        for (String path : scope) {
            // callout PŘED savepointem i DML (po nich už by callout nebyl povolen)
            Map<String, Object> doc;
            try {
                doc = (Map<String, Object>) JSON.deserializeUntyped(fetchFile(path));
            } catch (Exception e) {
                recordFailure(path, e.getMessage());
                continue;
            }

            if (dryRunOnly) {
                List<Object> probs = (List<Object>) doc.get('problems');
                problemsSkipped += (probs == null) ? 0 : probs.size();
                filesOk++;
                continue;
            }

            Savepoint sp = Database.setSavepoint();
            try {
                importDoc(doc);
                filesOk++;
            } catch (Exception e) {
                Database.rollback(sp);
                recordFailure(path, e.getMessage());
            }
        }
    }

    public void finish(Database.BatchableContext bc) {
        String summary = 'GoMathJsonImport hotovo: ' + filesOk + ' souborů OK, ' + filesFailed
            + ' chyb (z ' + filesTotal + '). Vytvořeno úloh: ' + problemsCreated
            + ', přeskočeno (už existovaly' + (dryRunOnly ? ' / dry-run' : '') + '): ' + problemsSkipped + '.';
        if (!failures.isEmpty()) {
            summary += '\n\nChyby:\n' + String.join(failures, '\n');
        }
        System.debug(LoggingLevel.INFO, summary);

        if (String.isNotBlank(notifyEmail)) {
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.setToAddresses(new List<String>{ notifyEmail });
            m.setSubject('GoMath import: ' + problemsCreated + ' úloh vytvořeno, ' + filesFailed + ' chyb');
            m.setPlainTextBody(summary);
            try {
                Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ m });
            } catch (Exception e) {
                System.debug(LoggingLevel.WARN, 'E-mail se nepodařilo odeslat: ' + e.getMessage());
            }
        }
    }

    private void recordFailure(String path, String message) {
        filesFailed++;
        if (failures.size() < 200) {
            failures.add(path + ' → ' + message);
        }
        System.debug(LoggingLevel.ERROR, 'GoMathJsonImport CHYBA ' + path + ': ' + message);
    }

    // ---------------------------------------------------------------- import jednoho testu

    @TestVisible
    private void importDoc(Map<String, Object> doc) {
        String src   = (String) doc.get('source');
        String stype = (String) doc.get('sourceType');
        String ccode = (String) doc.get('cermatCode');
        Decimal year = asDecimal(doc.get('year'));

        List<Object> problems = (List<Object>) doc.get('problems');
        if (problems == null || problems.isEmpty()) {
            throw new ImportException('dokument neobsahuje pole "problems"');
        }

        // idempotence: názvy, které už existují
        Set<String> names = new Set<String>();
        for (Object o : problems) {
            names.add((String) ((Map<String, Object>) o).get('name'));
        }
        Set<String> existing = new Set<String>();
        for (Math_Problem__c mp : [SELECT Name FROM Math_Problem__c WHERE Name IN :names]) {
            existing.add(mp.Name);
        }

        // taxonomie: kód -> Id (neznámé kódy se tiše přeskočí, stejně jako v původních skriptech)
        Map<String, Id> tx = new Map<String, Id>();
        for (Taxon__c t : [SELECT Id, Code__c FROM Taxon__c]) {
            tx.put(t.Code__c, t.Id);
        }

        for (Object o : problems) {
            Map<String, Object> p = (Map<String, Object>) o;
            String name = (String) p.get('name');
            if (existing.contains(name)) {
                problemsSkipped++;
                continue;
            }

            String svg = (String) p.get('svg');
            Id docId = null;
            if (String.isNotBlank(svg)) {
                ContentVersion cv = new ContentVersion(
                    Title = name,
                    PathOnClient = String.isBlank((String) p.get('fn')) ? 'obrazek.svg' : (String) p.get('fn'),
                    VersionData = Blob.valueOf(svg),
                    Origin = 'H');
                insert cv;
                docId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;
            }

            Math_Problem__c mp = new Math_Problem__c(
                Name = name, Status__c = 'Publikováno', Visibility__c = 'Organizace',
                Language__c = 'cs', Current_Version_Number__c = 1);
            insert mp;

            String cj = contentJson(asStrings(p.get('zad')), docId, (String) p.get('alt'),
                                    (String) p.get('cap'), asStrings(p.get('opts')), asInteger(p.get('ln')));
            String sj = solutionJson(asStrings(p.get('sol')));
            String aj = JSON.serialize(new Map<String, Object>{ 'type' => 'Text', 'value' => p.get('ans') });

            Problem_Version__c pub = new Problem_Version__c(
                Problem__c = mp.Id, Version_Number__c = 1, Is_Published__c = true,
                Published_At__c = Datetime.now(), Title__c = name,
                Content_JSON__c = cj, Solution_JSON__c = sj, Answer_JSON__c = aj,
                Answer_Type__c = 'Text',
                Points__c = asDecimal(p.get('pts')), Expected_Time_Min__c = asDecimal(p.get('mins')),
                Difficulty__c = (String) p.get('diff'),
                Source__c = src, Source_Type__c = stype,
                CERMAT_Code__c = ccode, Source_Year__c = year,
                License__c = 'Jiná',
                Search_Text__c = GoMathContent.buildSearchText(name, cj, sj, null));
            insert pub;

            List<Problem_Taxon__c> links = new List<Problem_Taxon__c>();
            List<String> codes = asStrings(p.get('codes'));
            if (codes != null) {
                for (String code : codes) {
                    Id ti = tx.get(code);
                    if (ti != null) {
                        links.add(new Problem_Taxon__c(Problem_Version__c = pub.Id, Taxon__c = ti,
                                                       Unique_Key__c = pub.Id + '_' + ti));
                    }
                }
            }
            if (!links.isEmpty()) {
                insert links;
            }

            if (docId != null) {
                linkDocument(docId, mp.Id);
            }
            problemsCreated++;
        }
    }

    private static void linkDocument(Id docId, Id recordId) {
        try {
            insert new ContentDocumentLink(ContentDocumentId = docId, LinkedEntityId = recordId,
                                           ShareType = 'V', Visibility = 'AllUsers');
        } catch (Exception e) {
            insert new ContentDocumentLink(ContentDocumentId = docId, LinkedEntityId = recordId,
                                           ShareType = 'V', Visibility = 'InternalUsers');
        }
    }

    // ---------------------------------------------------------------- stavba blokového JSONu
    // Stejná struktura, jakou generovaly anonymní skripty (schemaVersion 1).

    @TestVisible
    private static String contentJson(List<String> zad, Id docId, String alt, String cap,
                                      List<String> opts, Integer ln) {
        String s = '{"schemaVersion":1,"blocks":[';
        for (Integer i = 0; i < zad.size(); i++) {
            if (i > 0) s += ',';
            s += para(zad[i]);
        }
        if (docId != null) {
            s += ',{"type":"image","contentDocumentId":"' + docId + '","alt":' + JSON.serialize(alt)
               + ',"caption":' + JSON.serialize(cap) + ',"widthPercent":75,"align":"center"}';
        }
        if (opts != null && !opts.isEmpty()) {
            s += ',{"type":"list","items":[';
            for (Integer i = 0; i < opts.size(); i++) {
                if (i > 0) s += ',';
                s += JSON.serialize(opts[i]);
            }
            s += ']}';
        }
        if (ln != null && ln > 0) {
            s += ',{"type":"answerSpace","lines":' + ln + '}';
        }
        return s + ']}';
    }

    @TestVisible
    private static String solutionJson(List<String> paragraphs) {
        String s = '{"schemaVersion":1,"blocks":[';
        for (Integer i = 0; i < paragraphs.size(); i++) {
            if (i > 0) s += ',';
            s += para(paragraphs[i]);
        }
        return s + ']}';
    }

    private static String para(String t) {
        return '{"type":"paragraph","text":' + JSON.serialize(t) + '}';
    }

    // ---------------------------------------------------------------- GitHub + převody

    @TestVisible
    private String fetchFile(String path) {
        HttpRequest req = new HttpRequest();
        req.setEndpoint(githubBase + '/repos/' + repoOwner + '/' + repoName
            + '/contents/' + encodePath(path) + '?ref=' + EncodingUtil.urlEncode(branch, 'UTF-8'));
        req.setMethod('GET');
        req.setHeader('Accept', 'application/vnd.github.raw');
        req.setHeader('User-Agent', 'GoMathJsonImport');
        req.setHeader('X-GitHub-Api-Version', '2022-11-28');
        req.setTimeout(120000);

        HttpResponse res = new Http().send(req);
        if (res.getStatusCode() != 200) {
            String body = res.getBody();
            throw new ImportException('GitHub HTTP ' + res.getStatusCode() + ' (' + path + '): '
                + (body == null ? '' : body.abbreviate(300)));
        }
        return res.getBody();
    }

    @TestVisible
    private static String encodePath(String path) {
        List<String> parts = new List<String>();
        for (String seg : path.split('/')) {
            parts.add(EncodingUtil.urlEncode(seg, 'UTF-8').replace('+', '%20'));
        }
        return String.join(parts, '/');
    }

    @TestVisible
    private static Decimal asDecimal(Object o) {
        if (o == null) return null;
        if (o instanceof Decimal) return (Decimal) o;
        if (o instanceof Integer) return Decimal.valueOf((Integer) o);
        if (o instanceof Long) return Decimal.valueOf((Long) o);
        if (o instanceof Double) return Decimal.valueOf((Double) o);
        return Decimal.valueOf(String.valueOf(o));
    }

    @TestVisible
    private static Integer asInteger(Object o) {
        Decimal d = asDecimal(o);
        return d == null ? null : d.intValue();
    }

    @TestVisible
    private static List<String> asStrings(Object o) {
        if (o == null) return null;
        List<String> out = new List<String>();
        for (Object x : (List<Object>) o) {
            out.add((String) x);
        }
        return out;
    }
}
