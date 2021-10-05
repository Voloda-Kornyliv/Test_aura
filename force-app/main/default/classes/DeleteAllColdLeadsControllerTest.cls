@isTest(SeeAllData=false)
public class DeleteAllColdLeadsControllerTest {
    @testSetup
    static void makeData(){
        List<Lead> listLead = new List<Lead>();
        // String rating_cc = '';
        for (Integer i=0; i<100; i++) {
            // if(i<500){
            //     rating_cc = 'Warm';
            // }
            // else {
            //     rating_cc = 'Cold';
            // }
            listLead.add(new Lead(FirstName = 'Name' + i,
                LastName = 'Last' +i, Company = 'RedTag', LeadSource = 'Web',
                Status = 'Working - Contacted', Phone = '123457846954', Email = 'ffsds@gmail.com',
                Rating = 'Cold'));
        }
        insert listLead;
    }
    @isTest
    public static void Test() {
        Test.startTest();
        DeleteAllColdLeadsController.DeleteRecords();
        Test.stopTest();
        System.assertEquals(0, [SELECT COUNT() FROM Lead WHERE Rating = 'Cold']);
    }
}
