@isTest
public with sharing class GetTop5OpportynituesTest {
    @isTest
    public static void TestGetRecords() {
        Account acc = new Account(Name = 'TestGet');
        insert acc;
        List<Opportunity> listOpp = new List<Opportunity>();
        listOpp.add(new Opportunity(Name = 'Test 1', CloseDate = Date.today(), StageName = 'Closed Won', AccountId = acc.Id));
        listOpp.add(new Opportunity(Name = 'Test 2', CloseDate = Date.today(), StageName = 'Needs Analysis', AccountId = acc.Id));
        listOpp.add(new Opportunity(Name = 'Test 3', CloseDate = Date.today(), StageName = 'Value Proposition', AccountId = acc.Id));
        listOpp.add(new Opportunity(Name = 'Test 4', CloseDate = Date.today(), StageName = 'Closed Won', AccountId = acc.Id));
        listOpp.add(new Opportunity(Name = 'Test 5', CloseDate = Date.today(), StageName = 'Value Proposition', AccountId = acc.Id));
        insert listOpp;
        Test.startTest();
        List<Opportunity> res =  GetTop5Opportynitues.getOpportunity(acc.Id);
        Test.stopTest();
        System.assertEquals(4, res.size());
    }
    
}
