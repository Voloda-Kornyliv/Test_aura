public class AccountTriggerHandler extends TriggerHandler {
    private List<Account> list_account = new List<Account>();
    public AccountTriggerHandler() {
        this.setMaxLoopCount(1);
    }
    //while delete account cend email about delete and related opportunityes
    public override void beforeDelete(){
        List<Messaging.SingleEmailMessage> mails = 
             new List<Messaging.SingleEmailMessage>();
        List<Opportunity> list_opp_all = new List<Opportunity>();
        //user email
        String userName = UserInfo.getUserName();
        User activeUser = [Select Email, Name From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where Address = 'st2883942@gmail.com'];
        //all deleted account
        for (Account acc : (List<Account>)Trigger.old) {
            String AccName = (String)(acc.get('Name'));
            List<Opportunity> list_opp = [SELECT Name, Id FROM Opportunity WHERE AccountId = :acc.id];
            list_opp_all.addAll(list_opp);
            Messaging.SingleEmailMessage mail = 
                new Messaging.SingleEmailMessage();
            if ( owea != null ) {
                mail.setOrgWideEmailAddressId(owea.Id);
            }
            List<String> sendTo = new List<String>();
            sendTo.add(userEmail);
            mail.setToAddresses(sendTo);
            mail.setSubject('Account was deleted');
            String body = 'Hi ' + UserName + ', <br>';
            body += 'Due to deletion of Account ' + AccName + ' all next related Opportunities were deleted as well:<br>';
            Integer i = 1;
            for (Opportunity opp : list_opp) {
                body += i + '. ' + opp.id + ', ' + opp.Name + '.<br>';
                i++;
            }
            mail.setHtmlBody(body);
            mails.add(mail);
        }
        delete list_opp_all;
        Messaging.sendEmail(mails);
    }
}