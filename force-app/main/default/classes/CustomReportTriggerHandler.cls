public class CustomReportTriggerHandler extends TriggerHandler {
    public CustomReportTriggerHandler() {
        this.setMaxLoopCount(5);
    }
    public override void beforeInsert(){
        ChangeAccountSiteIfFrequencyCountainD(); 
    }
    public override void beforeUpdate(){
        ChangeAccountSiteIfFrequencyCountainD();
    } 
    public override void afterInsert(){
        ChangeNoteToAccountNameAndOwnerCompanyName();
    } 
    public override void afterUpdate(){
        ChangeNoteToAccountNameAndOwnerCompanyName();
    } 
    public void ChangeNoteToAccountNameAndOwnerCompanyName(){
        if (TriggerHandler.isBypassed('TriggerHandler')){
            return;
        }
        List<Customer_Report__c> CustRep = [SELECT Id, Account__r.Name, createdby.CompanyName FROM Customer_Report__c WHERE Id IN :Trigger.newMap.keySet()];
        for (Customer_Report__c cr : CustRep) {
            cr.Note__c = cr.Account__r.Name + cr.createdby.CompanyName;
        }
        TriggerHandler.bypass('TriggerHandler');
        update CustRep;
        TriggerHandler.clearAllBypasses();
    }
    public void ChangeAccountSiteIfFrequencyCountainD(){
        if (TriggerHandler.isBypassed('TriggerHandler')){
            return;
        }
        List<Id> listIs = new List<Id>();
        for(Customer_Report__c CustRep : (List<Customer_Report__c>) Trigger.new) {
            if(CustRep.Frequency__c != null ){
                if(CustRep.Frequency__c.contains('D')){
                    listIs.add(CustRep.Account__c);
                }
            }
          }
        if(!listIs.isEmpty()){
          List<Account> AccList = [SELECT Id, Site FROM Account WHERE Id IN :listIs];
            for (Account acc : AccList) {
                acc.Site = 'https://www.ContainD.com/';
            } 
            update AccList;
        }
    }
}
