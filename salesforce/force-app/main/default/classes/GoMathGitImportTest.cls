@IsTest
private class GoMathGitImportTest {

    private static final String TREE_JSON =
        '{"truncated":false,"tree":['
      + '{"type":"blob","path":"scripts/apex/import-zeleny-testA-cast1.apex"},'
      + '{"type":"blob","path":"scripts/apex/cermat/import-cermat-M5A-2026-cast1.apex"},'
      + '{"type":"blob","path":"scripts/apex/README.md"},'
      + '{"type":"tree","path":"scripts/apex/cermat"}'
      + ']}';

    private static final String SOAP_OK =
        '<soapenv:Envelope><result><compiled>true</compiled><success>true</success></result></soapenv:Envelope>';

    /** Konfigurovatelný mock: GitHub odpovídá vždy, chování SOAPu se řídí parametry. */
    private class Mock implements HttpCalloutMock {
        public String soapBody = SOAP_OK;
        public Integer contentsStatus = 200;
        public Integer soapStatus = 200;
        public String fileBody = 'System.debug(\'ahoj\');';
        public Integer soapCalls = 0;

        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            String ep = req.getEndpoint();
            if (ep.contains('/git/ref/heads/')) {
                res.setStatusCode(200);
                res.setBody('{"object":{"sha":"deadbeef"}}');
            } else if (ep.contains('/git/trees/')) {
                res.setStatusCode(200);
                res.setBody(TREE_JSON);
            } else if (ep.contains('/contents/')) {
                res.setStatusCode(contentsStatus);
                res.setBody(contentsStatus == 200 ? fileBody : '{"message":"Not Found"}');
            } else {
                soapCalls++;
                res.setStatusCode(soapStatus);
                res.setBody(soapBody);
            }
            return res;
        }
    }

    @IsTest
    static void startVyfiltrujePouzeApexSoubory() {
        Test.setMock(HttpCalloutMock.class, new Mock());
        GoMathGitImport b = new GoMathGitImport();

        Test.startTest();
        List<String> paths = (List<String>) b.start(null);
        Test.stopTest();

        System.assertEquals(2, paths.size(), 'README.md ani uzly typu tree se nemají brát: ' + paths);
        System.assertEquals(2, b.filesTotal, 'filesTotal se má naplnit ve start()');
        for (String p : paths) {
            System.assert(p.endsWith('.apex'), 'Neapexový soubor prošel: ' + p);
        }
    }

    @IsTest
    static void fileFilterOmeziRozsah() {
        Test.setMock(HttpCalloutMock.class, new Mock());
        GoMathGitImport b = new GoMathGitImport('cermat/');

        Test.startTest();
        List<String> paths = (List<String>) b.start(null);
        Test.stopTest();

        System.assertEquals(1, paths.size(), 'Filtr má propustit jediný soubor: ' + paths);
        System.assert(paths[0].contains('cermat'), 'Propuštěn špatný soubor: ' + paths[0]);
    }

    @IsTest
    static void uspesnyBehSpustiAnonymniApex() {
        Mock mock = new Mock();
        Test.setMock(HttpCalloutMock.class, mock);
        GoMathGitImport b = new GoMathGitImport();

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/apex/import-zeleny-testA-cast1.apex' });
        Test.stopTest();

        System.assertEquals(1, b.filesOk, 'Soubor měl projít');
        System.assertEquals(0, b.filesFailed, 'Neočekávaná chyba: ' + b.failures);
        System.assertEquals(1, mock.soapCalls, 'Měl proběhnout právě jeden executeAnonymous');
    }

    @IsTest
    static void dryRunNespoustiAnonymniApex() {
        Mock mock = new Mock();
        Test.setMock(HttpCalloutMock.class, mock);
        GoMathGitImport b = new GoMathGitImport();
        b.dryRunOnly = true;

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/apex/import-zeleny-testA-cast1.apex' });
        Test.stopTest();

        System.assertEquals(1, b.filesOk, 'Dry-run má soubor započítat jako OK');
        System.assertEquals(0, mock.soapCalls, 'Dry-run nesmí volat executeAnonymous');
    }

    @IsTest
    static void chybaKompilaceSeZachytiDoFailures() {
        Mock mock = new Mock();
        mock.soapBody = '<soapenv:Envelope><result><compiled>false</compiled><line>7</line>'
            + '<compileProblem>Unexpected token</compileProblem><success>false</success>'
            + '</result></soapenv:Envelope>';
        Test.setMock(HttpCalloutMock.class, mock);
        GoMathGitImport b = new GoMathGitImport();

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/apex/rozbity.apex' });
        Test.stopTest();

        System.assertEquals(0, b.filesOk, 'Rozbitý soubor nesmí být OK');
        System.assertEquals(1, b.filesFailed, 'Chyba se měla započítat');
        System.assertEquals(1, b.failures.size(), 'Chybí záznam v failures');
        System.assert(b.failures[0].contains('Unexpected token'),
            'Chybí text problému: ' + b.failures[0]);
    }

    @IsTest
    static void behovaChybaSeZachytiDoFailures() {
        Mock mock = new Mock();
        mock.soapBody = '<soapenv:Envelope><result><compiled>true</compiled><success>false</success>'
            + '<exceptionMessage>System.LimitException: Too many SOQL queries</exceptionMessage>'
            + '<exceptionStackTrace>Class.C.add: line 1</exceptionStackTrace>'
            + '</result></soapenv:Envelope>';
        Test.setMock(HttpCalloutMock.class, mock);
        GoMathGitImport b = new GoMathGitImport();

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/apex/limit.apex' });
        Test.stopTest();

        System.assertEquals(1, b.filesFailed, 'Běhová chyba se měla započítat');
        System.assert(b.failures[0].contains('LimitException'),
            'Chybí text výjimky: ' + b.failures[0]);
    }

    @IsTest
    static void nedostupnySouborSeZachyti() {
        Mock mock = new Mock();
        mock.contentsStatus = 404;
        Test.setMock(HttpCalloutMock.class, mock);
        GoMathGitImport b = new GoMathGitImport();

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/apex/neexistuje.apex' });
        Test.stopTest();

        System.assertEquals(1, b.filesFailed, 'HTTP 404 se měl započítat jako chyba');
        System.assert(b.failures[0].contains('404'), 'Chybí HTTP kód: ' + b.failures[0]);
        System.assertEquals(0, mock.soapCalls, 'Při chybě stažení se nemá nic spouštět');
    }

    @IsTest
    static void prazdnySouborJeChyba() {
        Mock mock = new Mock();
        mock.fileBody = '';
        Test.setMock(HttpCalloutMock.class, mock);
        GoMathGitImport b = new GoMathGitImport();

        Test.startTest();
        b.execute(null, new List<String>{ 'scripts/apex/prazdny.apex' });
        Test.stopTest();

        System.assertEquals(1, b.filesFailed, 'Prázdný soubor má být chyba');
        System.assertEquals(0, mock.soapCalls, 'Prázdný soubor se nemá spouštět');
    }

    @IsTest
    static void finishNespadneAOdesleSouhrn() {
        GoMathGitImport b = new GoMathGitImport();
        b.filesTotal = 2;
        b.filesOk = 1;
        b.filesFailed = 1;
        b.failures.add('scripts/apex/x.apex → chyba');
        b.notifyEmail = 'ales.jenik@example.com';

        Test.startTest();
        b.finish(null);
        Test.stopTest();

        System.assertEquals(1, b.filesOk, 'finish() nemá měnit stav');
    }

    @IsTest
    static void celyBatchDobehne() {
        Test.setMock(HttpCalloutMock.class, new Mock());

        Test.startTest();
        Id jobId = GoMathGitImport.run();
        Test.stopTest();

        AsyncApexJob job = [SELECT Status, NumberOfErrors FROM AsyncApexJob WHERE Id = :jobId];
        System.assertEquals('Completed', job.Status, 'Job měl doběhnout');
        System.assertEquals(0, job.NumberOfErrors, 'Job neměl skončit s chybou');
    }

    @IsTest
    static void pomocneFunkce() {
        System.assertEquals('a&amp;b&lt;c&gt;d', GoMathGitImport.xmlEscape('a&b<c>d'));
        System.assertEquals('scripts/apex/a%20b.apex', GoMathGitImport.encodePath('scripts/apex/a b.apex'));
        System.assertEquals('true', GoMathGitImport.firstTag('<x><compiled>true</compiled></x>', 'compiled', '?'));
        System.assertEquals('?', GoMathGitImport.firstTag('<x/>', 'compiled', '?'));
        System.assertEquals('?', GoMathGitImport.firstTag(null, 'compiled', '?'));
        System.assertEquals('?', GoMathGitImport.firstTag('<compiled>bez konce', 'compiled', '?'));
    }
}
