public class CustomReportTriggerHandler extends TriggerHandler {
    public CustomReportTriggerHandler() {
        this.setMaxLoopCount(15);
    }

    public override void beforeInsert(){
        UpdateOrInsert();
          
    }
    public override void beforeUpdate(){
        UpdateOrInsert();
    } 
    public override void afterInsert(){
        UpdateOrInsert_after();
    } 
    public override void afterUpdate(){
        UpdateOrInsert_after();
    } 
    public void UpdateOrInsert_after(){
        List<Customer_Report__c> CustRep = [SELECT Id, Account__r.Name, createdby.CompanyName FROM Customer_Report__c WHERE Id IN :Trigger.newMap.keySet()];
        for (Customer_Report__c cr : CustRep) {
            cr.Note__c = cr.Account__r.Name + cr.createdby.CompanyName;
        }

        update CustRep;

    }

    public void UpdateOrInsert(){

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
