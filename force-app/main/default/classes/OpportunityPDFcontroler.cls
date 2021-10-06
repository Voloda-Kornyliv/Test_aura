public with sharing class OpportunityPDFcontroler {
    Opportunity opportunity;
    String randomText = '';
    List<OpportunityLineItem> oppportunityLineItem;
    public Opportunity getOpportunity() {
        if (opportunity == null){                      
            opportunity = [SELECT Account.Name, MainCompetitors__c 
            FROM Opportunity WHERE 
            id = :ApexPages.currentPage().getParameters().get('id')];
        }
        return opportunity;
    }
    public String getrandomText(){
        if (randomText == ''){ 
            for (Integer i=1; i<=6; i++) {
                randomText += i;
                randomText += '. ';
                for (Integer j=0; j<=44; j++){
                    randomText += 'Random text. ';
                }
                randomText += '\n';
            }
        }
        return randomText;
    }
    public List<OpportunityLineItem> getOppportunityLineItem(){
        if (oppportunityLineItem == null){  
            oppportunityLineItem = [SELECT 
                Name, Quantity, UnitPrice, TotalPrice 
                FROM OpportunityLineItem
                WHERE OpportunityId = :ApexPages.currentPage().getParameters().get('id')];
        }
        return oppportunityLineItem;
    }
}
