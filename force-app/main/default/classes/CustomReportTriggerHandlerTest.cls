@isTest
public class CustomReportTriggerHandlerTest {
    @isTest
    public static void TestInsert() {       
         //create data for insert
        Account testAcct = new Account(Name = 'TestAcct');
        insert testAcct;
        Customer_Report__c Cust = new Customer_Report__c(Account__c = testAcct.Id, Name = '1324', Frequency__c = 'D');
        Test.startTest();
        Database.SaveResult result = Database.insert(Cust, false);
        Test.stopTest();
        Account TrigeredAcc = [SELECT Site,  Name FROM Account WHERE id =: Cust.Account__c][0];
		Customer_Report__c UpadatedReport = [SELECT Note__c,CreatedBy.CompanyName, Id  FROM Customer_Report__c WHERE Id = :Cust.Id][0];
		System.assertEquals(TrigeredAcc.Name + UpadatedReport.CreatedBy.CompanyName,UpadatedReport.Note__c);
		System.assertEquals('https://www.ContainD.com/', TrigeredAcc.Site);
    }
}
