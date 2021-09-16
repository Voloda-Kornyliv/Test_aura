public class CustomReportTriggerHandler extends TriggerHandler {
    public CustomReportTriggerHandler() {
        this.setMaxLoopCount(3);
    }

    public override void beforeInsert(){
        UpdateOrInsert();
          
    }
    public override void beforeUpdate(){
        UpdateOrInsert();
    } 

    public void UpdateOrInsert(){
        List<Id> listIs = new List<Id>();

        for(Customer_Report__c CustRep : (List<Customer_Report__c>) Trigger.new) {
            if(CustRep.Frequency__c.contains('D')){
                listIs.add(CustRep.Account__c);
            }
          }
          List<Account> AccList = [SELECT Id, Site FROM Account WHERE Id IN :listIs];
          for (Account acc : AccList) {
              acc.Site = 'https://www.ContainD.com/';
          }
          update AccList;
    }
}
