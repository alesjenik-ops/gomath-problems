/**
 * Test pro CermatImportBatch. GitHub callout je nahrazen mockem, který vrátí
 * jeden minimální záznam ve schématu data/*.json, takže se pokryje i importní
 * větev (vytvoření Math_Problem__c + Problem_Version__c) bez skutečného volání.
 *
 * Pozn.: importní řádky používají stejnou sadu polí jako ověřené ...-castN.apex
 * skripty. Pokud by v orgu měly objekty další povinná pole nebo validační
 * pravidla, uprav testovací data zde.
 */
@isTest
private class CermatImportBatchTest {

    private class GitHubMock implements HttpCalloutMock {
        private String body;
        private GitHubMock(String b) { this.body = b; }
        public HttpResponse respond(HttpRequest req) {
            HttpResponse res = new HttpResponse();
            res.setStatusCode(200);
            res.setHeader('Content-Type', 'application/json');
            res.setBody(body);
            return res;
        }
    }

    @isTest
    static void importsFromMockedGitHub() {
        String rec =
            '[{'
          +   '"name":"TEST CERMAT uloha 999",'
          +   '"src":"TEST","ccode":"TESTCODE","year":2099,'
          +   '"points":1,"minutes":2,"difficulty":"3",'
          +   '"answerJson":"{\\"type\\":\\"Text\\",\\"value\\":\\"42\\"}",'
          +   '"contentJson":"{\\"schemaVersion\\":1,\\"blocks\\":[{\\"type\\":\\"paragraph\\",\\"text\\":\\"Kolik je sest krat sedm?\\"}]}",'
          +   '"solutionJson":"{\\"schemaVersion\\":1,\\"blocks\\":[{\\"type\\":\\"paragraph\\",\\"text\\":\\"42\\"}]}",'
          +   '"taxonCodes":[],'
          +   '"figure":null'
          + '}]';

        Test.setMock(HttpCalloutMock.class, new GitHubMock(rec));
        Test.startTest();
        Database.executeBatch(new CermatImportBatch(), 1);
        Test.stopTest();

        System.assertEquals(1,
            [SELECT COUNT() FROM Math_Problem__c WHERE Name = 'TEST CERMAT uloha 999'],
            'Testovací úloha se měla založit právě jednou (idempotence).');
    }
}
