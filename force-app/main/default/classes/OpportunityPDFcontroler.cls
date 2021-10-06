public with sharing class OpportunityPDFcontroler {
    Opportunity opportunity;
    public Opportunity getOpportunity() {
        if (opportunity == null){                      
            opportunity = [SELECT Amount FROM Opportunity WHERE 
            id = :ApexPages.currentPage().getParameters().get('id')];
        }
        return opportunity;
    }
}
