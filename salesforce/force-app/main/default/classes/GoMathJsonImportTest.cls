@IsTest
private class GoMathJsonImportTest {

    private static final String NAME1 = 'TEST GoMathJsonImport – úloha 1';
    private static final String NAME2 = 'TEST GoMathJsonImport – úloha 2';

    private static String indexJson() {
        return JSON.serialize(new Map<String, Object>{
            'files' => new List<String>{ 'scripts/json/soubor1.json', 'scripts/json/soubor2.json' },
            'totalProblems' => 4
        });
    }

    private static String fileJson() {
        Map<String, Object> p1 = new Map<String, Object>{
            'name' => NAME1,
            'zad'  => new List<String>{ 'Vypočtěte $1+1$.' },
            'opts' => null,
            'ln'   => 2,
            'svg'  => '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 10 10"><rect width="10" height="10"/></svg>',
            'fn'   => 'obr.svg',
            'alt'  => 'testovací obrázek',
            'cap'  => null,
            'sol'  => new List<String>{ 'Součet je $2$.' },
            'ans'  => '$2$',
            'pts'  => 1, 'mins' => 2, 'diff' => '3',
            'codes' => new List<String>{ 'zs1', 'aritmetika' }
        };
        Map<String, Object> p2 = new Map<String, Object>{
            'name' => NAME2,
            'zad'  => new List<String>{ 'Vyberte správnou možnost.' },
            'opts' => new List<String>{ 'A) $1$', 'B) $2$' },
            'ln'   => 0,
            'svg'  => null, 'fn' => null, 'alt' => null, 'cap' => null,
            'sol'  => new List<String>{ 'Správně je B.' },
            'ans'  => 'B) $2$',
            'pts'  => 2, 'mins' => 3, 'diff' => '2',
            'codes' => new List<String>{ 'zs1' }
        };
        return JSON.serialize(new Map<String, Object>{
            'source' => 'Matematika - Zelený', 'sourceType' => 'Jiné',
            'cermatCode' => null, 'year' => null,
            'problems' => new List<Object>{ p1, p2 }
        });
    }

    private class Mock implements HttpCalloutMock {
        public Boolean rozbityJson = false;
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            String ep = req.getEndpoint();
            if (ep.contains('index.json')) {
                res.setBody(indexJson());
            } else if (ep.contains('soubor1.json') || ep.contains('soubor2.json')) {
                res.setBody(rozbityJson ? 'tohle{není]json' : fileJson());
            } else {
                res.setStatusCode(404);
                res.setBody('{"message":"Not Found"}');
            }
            return res;
        }
    }

    private static Map<String, Object> parsedDoc() {
        return (Map<String, Object>) JSON.deserializeUntyped(fileJson());
    }

    @IsTest
    static void startNacteIndexAFiltruje() {
        Test.setMock(HttpCalloutMock.class, new Mock());
        GoMathJsonImport b = new GoMathJsonImport();
        b.fileFilter = 'soubor2';

        Test.startTest();
        List<String> paths = new List<String>();
        for (String p : b.start(null)) {
            paths.add(p);
        }
        Test.stopTest();

        System.assertEquals(1, paths.size(), 'Filtr má propustit jediný soubor: ' + paths);
        System.assert(paths[0].contains('soubor2'), 'Propuštěn špatný soubor: ' + paths[0]);
    }

    @IsTest
    static void importDocVytvoriZaznamy() {
        GoMathJsonImport b = new GoMathJsonImport();

        Test.startTest();
        b.importDoc(parsedDoc());
        Test.stopTest();

        System.assertEquals(2, b.problemsCreated, 'Měly vzniknout 2 úlohy');
        System.assertEquals(0, b.problemsSkipped, 'Nic nemělo být přeskočeno');

        List<Math_Problem__c> mps = [SELECT Id, Name FROM Math_Problem__c WHERE Name LIKE 'TEST GoMathJsonImport%' ORDER BY Name];
        System.assertEquals(2, mps.size(), 'Chybí Math_Problem__c záznamy');

        List<Problem_Version__c> pvs = [SELECT Content_JSON__c, Answer_JSON__c, Source__c, Points__c
                                        FROM Problem_Version__c WHERE Problem__c = :mps[0].Id];
        System.assertEquals(1, pvs.size(), 'Chybí Problem_Version__c');
        System.assert(pvs[0].Content_JSON__c.contains('"schemaVersion":1'), 'Chybí blokové JSON: ' + pvs[0].Content_JSON__c);
        System.assert(pvs[0].Content_JSON__c.contains('"type":"image"'), 'Úloha 1 má mít obrázkový blok');
        System.assert(pvs[0].Answer_JSON__c.contains('Text'), 'Answer_JSON: ' + pvs[0].Answer_JSON__c);
        System.assertEquals('Matematika - Zelený', pvs[0].Source__c);
        System.assertEquals(1, pvs[0].Points__c.intValue());

        System.assertEquals(1, [SELECT COUNT() FROM ContentVersion WHERE Title = :NAME1],
            'SVG úlohy 1 se měl uložit jako ContentVersion');
    }

    @IsTest
    static void existujiciUlohaSePreskoci() {
        insert new Math_Problem__c(Name = NAME1, Status__c = 'Publikováno',
            Visibility__c = 'Organizace', Language__c = 'cs', Current_Version_Number__c = 1);
        GoMathJsonImport b = new GoMathJsonImport();

        Test.startTest();
        b.importDoc(parsedDoc());
        Test.stopTest();

        System.assertEquals(1, b.problemsCreated, 'Vytvořit se měla jen úloha 2');
        System.assertEquals(1, b.problemsSkipped, 'Úloha 1 se měla přeskočit');
        System.assertEquals(1, [SELECT COUNT() FROM Math_Problem__c WHERE Name = :NAME1],
            'Existující úloha se nesmí zduplikovat');
    }

    @IsTest
    static void executeStahneAVlozi() {
        Test.setMock(HttpCalloutMock.class, new Mock());
        GoMathJsonImport b = new GoMathJsonImport();

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/json/soubor1.json' });
        Test.stopTest();

        System.assertEquals(1, b.filesOk, 'Soubor měl projít: ' + b.failures);
        System.assertEquals(2, b.problemsCreated, 'Měly vzniknout 2 úlohy');
    }

    @IsTest
    static void dryRunNevklada() {
        Test.setMock(HttpCalloutMock.class, new Mock());
        GoMathJsonImport b = new GoMathJsonImport();
        b.dryRunOnly = true;

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/json/soubor1.json' });
        Test.stopTest();

        System.assertEquals(1, b.filesOk, 'Dry-run má soubor započítat');
        System.assertEquals(0, b.problemsCreated, 'Dry-run nesmí nic vytvořit');
        System.assertEquals(0, [SELECT COUNT() FROM Math_Problem__c WHERE Name LIKE 'TEST GoMathJsonImport%'],
            'Dry-run nesmí vkládat záznamy');
    }

    @IsTest
    static void rozbityJsonSeZachyti() {
        Mock mock = new Mock();
        mock.rozbityJson = true;
        Test.setMock(HttpCalloutMock.class, mock);
        GoMathJsonImport b = new GoMathJsonImport();

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/json/soubor1.json' });
        Test.stopTest();

        System.assertEquals(1, b.filesFailed, 'Rozbitý JSON se měl započítat jako chyba');
        System.assertEquals(0, b.problemsCreated, 'Nic nemělo vzniknout');
    }

    @IsTest
    static void nedostupnySouborSeZachyti() {
        Test.setMock(HttpCalloutMock.class, new Mock());
        GoMathJsonImport b = new GoMathJsonImport();

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/json/neexistuje.json' });
        Test.stopTest();

        System.assertEquals(1, b.filesFailed, 'HTTP 404 se měl započítat jako chyba');
        System.assert(b.failures[0].contains('404'), 'Chybí HTTP kód: ' + b.failures[0]);
    }

    @IsTest
    static void celyBatchDobehne() {
        Test.setMock(HttpCalloutMock.class, new Mock());

        // Filtr omezí vstup na JEDINÝ soubor: scope = 1, a v testovacím kontextu
        // je povolena jen jedna executeBatch invokace.
        Test.startTest();
        Id jobId = GoMathJsonImport.run('soubor1');
        Test.stopTest();

        AsyncApexJob job = [SELECT Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :jobId];
        System.assertEquals('Completed', job.Status, 'Job měl doběhnout');
        System.assertEquals(0, job.NumberOfErrors, 'Job neměl skončit s chybou');
        System.assertEquals(2, [SELECT COUNT() FROM Math_Problem__c WHERE Name LIKE 'TEST GoMathJsonImport%'],
            'Batch měl vytvořit 2 úlohy');
    }

    @IsTest
    static void pomocneFunkce() {
        System.assertEquals(2.5, GoMathJsonImport.asDecimal(2.5));
        System.assertEquals(2, GoMathJsonImport.asDecimal(2).intValue());
        System.assertEquals(null, GoMathJsonImport.asDecimal(null));
        System.assertEquals(4, GoMathJsonImport.asInteger(4));
        System.assertEquals(null, GoMathJsonImport.asInteger(null));
        System.assertEquals(null, GoMathJsonImport.asStrings(null));
        System.assertEquals(new List<String>{ 'a', 'b' },
            GoMathJsonImport.asStrings(new List<Object>{ 'a', 'b' }));
        System.assertEquals('scripts/json/a%20b.json', GoMathJsonImport.encodePath('scripts/json/a b.json'));

        String cj = GoMathJsonImport.contentJson(new List<String>{ 'text' }, null, null, null,
                                                 new List<String>{ 'A', 'B' }, 3);
        System.assert(cj.contains('"type":"list"'), cj);
        System.assert(cj.contains('"answerSpace"'), cj);
        String sj = GoMathJsonImport.solutionJson(new List<String>{ 'ř1', 'ř2' });
        System.assert(sj.contains('schemaVersion'), sj);
    }
}
