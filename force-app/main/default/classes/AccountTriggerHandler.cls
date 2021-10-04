public class AccountTriggerHandler extends TriggerHandler {
    // private List<Account> list_account = new List<Account>();
    public AccountTriggerHandler() {
        this.setMaxLoopCount(1);
    }
    //while delete account cend email about delete and related opportunityes
    public override void beforeDelete(){
        SendEmailAboutAccountAndOpportunityes.SendEmail((List<Account>)Trigger.old);
    }
}