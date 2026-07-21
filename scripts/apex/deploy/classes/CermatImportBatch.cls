/**
 * CermatImportBatch – naimportuje všechny CERMAT úlohy do GoMathu.
 *
 * Data si stahuje sám z veřejného GitHub repa (raw.githubusercontent.com),
 * po jednom JSON souboru na dávku, takže každá dávka běží ve vlastní transakci
 * a nenaráží na governor limity. Je idempotentní – úloha, jejíž Name už
 * v orgu existuje, se přeskočí (lze spouštět opakovaně).
 *
 * Předpoklad: v orgu je naplněná taxonomie (Taxon__c.Code__c) a existuje třída
 * GoMathContent (stejně jako u ručních ...-castN.apex skriptů).
 *
 * Spuštění (Developer Console → Execute Anonymous):
 *   Database.executeBatch(new CermatImportBatch(), 1);
 * Parametr scope MUSÍ být 1 (jeden soubor = jedna dávka).
 */
public class CermatImportBatch implements Database.Batchable<String>, Database.AllowsCallouts, Database.Stateful {

    // Data připnutá na konkrétní commit (neměnné). Po případném přegenerování
    // dat aktualizuj SHA v této URL.
    private static final String BASE = 'https://raw.githubusercontent.com/alesjenik-ops/gomath-problems/8df2ccb2b1a638848b5cde45c7956ff2a7172ecf/scripts/apex/data/';

    private static final List<String> FILES = new List<String>{
    'import-cermat-M9A-2015.json',
    'import-cermat-M9A-2019.json',
    'import-cermat-M9A-2020.json',
    'import-cermat-M9A-2021.json',
    'import-cermat-M9A-2022.json',
    'import-cermat-M9A-2023.json',
    'import-cermat-M9A-2024.json',
    'import-cermat-M9A-2025.json',
    'import-cermat-M9B-2017.json',
    'import-cermat-M9B-2019.json',
    'import-cermat-M9B-2021.json',
    'import-cermat-M9B-2022.json',
    'import-cermat-M9B-2023.json',
    'import-cermat-M9B-2024.json',
    'import-cermat-M9B-2025.json',
    'import-cermat-M9B-2026.json',
    'import-cermat-M9C-2021.json',
    'import-cermat-M9C-2022.json',
    'import-cermat-M9C-2023.json',
    'import-cermat-M9C-2024.json',
    'import-cermat-M9C-2025.json',
    'import-cermat-M9C-2026.json',
    'import-cermat-M9D-2021.json',
    'import-cermat-M9D-2022.json',
    'import-cermat-M9D-2023.json',
    'import-cermat-M9D-2024.json',
    'import-cermat-M9D-2025.json',
    'import-cermat-M9D-2026.json',
    'import-cermat-M9I-2018.json',
    'import-cermat-M9I-2019.json',
    'import-cermat-M9I-2020.json',
    'import-cermat-M9I-2021.json'
    };

    private Map<String, Id> tx;      // kód taxonu -> Id
    private Set<String> have;        // už existující Name úloh
    public Integer created = 0;
    public Integer skipped = 0;
    public List<String> errors = new List<String>();

    public CermatImportBatch() {
        tx = new Map<String, Id>();
        for (Taxon__c t : [SELECT Id, Code__c FROM Taxon__c]) tx.put(t.Code__c, t.Id);
        have = new Set<String>();
        for (Math_Problem__c p : [SELECT Name FROM Math_Problem__c]) have.add(p.Name);
    }

    public Iterable<String> start(Database.BatchableContext bc) {
        return FILES;
    }

    public void execute(Database.BatchableContext bc, List<String> scope) {
        for (String fname : scope) {
            try {
                HttpRequest req = new HttpRequest();
                req.setEndpoint(BASE + fname);
                req.setMethod('GET');
                req.setTimeout(120000);
                HttpResponse res = new Http().send(req);
                if (res.getStatusCode() != 200) {
                    errors.add(fname + ' HTTP ' + res.getStatusCode());
                    continue;
                }
                List<Object> arr = (List<Object>) JSON.deserializeUntyped(res.getBody());
                for (Object o : arr) importOne((Map<String, Object>) o);
            } catch (Exception e) {
                errors.add(fname + ' : ' + e.getMessage());
            }
        }
    }

    private void importOne(Map<String, Object> p) {
        String name = (String) p.get('name');
        if (have.contains(name)) { skipped++; return; }

        String contentJson = (String) p.get('contentJson');

        // Obrázek (SVG) jako ContentVersion + náhrada placeholderu v Content_JSON.
        Id docId = null;
        Object figO = p.get('figure');
        if (figO != null) {
            Map<String, Object> fig = (Map<String, Object>) figO;
            ContentVersion cv = new ContentVersion(
                Title = name,
                PathOnClient = (String) fig.get('filename'),
                VersionData = Blob.valueOf((String) fig.get('svg')),
                Origin = 'H');
            insert cv;
            docId = [SELECT ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id].ContentDocumentId;
            contentJson = contentJson.replace('__DOCID__', String.valueOf(docId));
        }

        Math_Problem__c mp = new Math_Problem__c(
            Name = name, Status__c = 'Publikováno', Visibility__c = 'Organizace',
            Language__c = 'cs', Current_Version_Number__c = 1);
        insert mp;

        String sj = (String) p.get('solutionJson');
        Problem_Version__c pub = new Problem_Version__c(
            Problem__c = mp.Id, Version_Number__c = 1, Is_Published__c = true,
            Published_At__c = Datetime.now(), Title__c = name,
            Content_JSON__c = contentJson, Solution_JSON__c = sj,
            Answer_JSON__c = (String) p.get('answerJson'), Answer_Type__c = 'Text',
            Points__c = toDec(p.get('points')), Expected_Time_Min__c = toDec(p.get('minutes')),
            Difficulty__c = (String) p.get('difficulty'),
            Source__c = (String) p.get('src'), Source_Type__c = 'CERMAT', License__c = 'Jiná',
            CERMAT_Code__c = (String) p.get('ccode'), Source_Year__c = toInt(p.get('year')),
            Search_Text__c = GoMathContent.buildSearchText(name, contentJson, sj, null));
        insert pub;

        List<Problem_Taxon__c> links = new List<Problem_Taxon__c>();
        for (Object codeO : (List<Object>) p.get('taxonCodes')) {
            Id ti = tx.get((String) codeO);
            if (ti == null) continue;
            links.add(new Problem_Taxon__c(
                Problem_Version__c = pub.Id, Taxon__c = ti, Unique_Key__c = pub.Id + '_' + ti));
        }
        if (!links.isEmpty()) insert links;

        if (docId != null) {
            try {
                insert new ContentDocumentLink(ContentDocumentId = docId,
                    LinkedEntityId = mp.Id, ShareType = 'V', Visibility = 'AllUsers');
            } catch (Exception e) {
                insert new ContentDocumentLink(ContentDocumentId = docId,
                    LinkedEntityId = mp.Id, ShareType = 'V', Visibility = 'InternalUsers');
            }
        }

        have.add(name);
        created++;
    }

    private static Decimal toDec(Object o) { return o == null ? null : Decimal.valueOf(String.valueOf(o)); }
    private static Integer toInt(Object o) { return o == null ? null : Integer.valueOf(String.valueOf(o)); }

    public void finish(Database.BatchableContext bc) {
        System.debug('CERMAT import hotovo. Vytvořeno: ' + created + ', přeskočeno: ' + skipped);
        if (!errors.isEmpty()) System.debug('Chyby: ' + errors);
    }
}
