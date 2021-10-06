@isTest(SeeAllData=false)
public with sharing class OpportunityPDFcontrolerTest {
    @isTest
    static void Test(){
        PageReference pageRef = Page.ContractPDFOpportunity;
        Test.setCurrentPage(pageRef);
        OpportunityPDFcontroler oppPDF = new OpportunityPDFcontroler();
        Opportunity opp = new Opportunity(Name = 'Test Opp',
        CloseDate = System.today(),
        StageName = 'Prospecting');
        insert opp;
        ApexPages.currentPage().getParameters().put('id',opp.id);
        oppPDF.getOpportunity();
        oppPDF.getrandomText();
        oppPDF.getOppportunityLineItem();
    }
}
