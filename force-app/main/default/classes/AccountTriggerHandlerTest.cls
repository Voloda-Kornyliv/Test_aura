@isTest
public class AccountTriggerHandlerTest {
    @isTest
    public static void TestMail(){
        Account TestAccount = new Account(Name = 'TestName');
        insert TestAccount;
        List<Opportunity> ListOpp = new List<Opportunity>();
        for (Integer i=0; i<10; i++) {
            ListOpp.add(new Opportunity(Name = 'Test' + i,
             CloseDate = Date.today(), StageName = 'Closed Won', AccountId = TestAccount.Id));
        }
        insert ListOpp;  
        Test.startTest();
        delete TestAccount;
        Test.stopTest();
        Integer count = [SELECT COUNT() FROM Opportunity WHERE AccountId = :TestAccount.Id];
        System.assertEquals(count, 0);
    }
}
