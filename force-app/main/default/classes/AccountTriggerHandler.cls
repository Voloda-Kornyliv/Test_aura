public class AccountTriggerHandler extends TriggerHandle {
    public AccountTriggerHandler() {
        this.setMaxLoopCount(1);
    }
    //while delete account cend email about delete and related opportunityes
    public override void afterDelete(){
        List<Messaging.SingleEmailMessage> mails = 
             new List<Messaging.SingleEmailMessage>();
        List<Account> list_account = new List<Account>(Trigger.old);
        List<Opportunity> list_opp_all = new List<Opportunity>();
        //user email
        String userName = UserInfo.getUserName();
        User activeUser = [Select Email, Name From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        //all deleted account
        for (Account acc : list_account) {
            List<Opportunity> list_opp = [SELECT Name, Id FROM Opportunity WHERE AccountId = :acc.id];
            list_opp_all.addAll(list_opp);
            Messaging.SingleEmailMessage mail = 
                new Messaging.SingleEmailMessage();
            mail.setToAddresses(userEmail);
            mail.setReplyTo('info@redtag.com.ua');
            mail.setSenderDisplayName('RedTag Company');
            mail.setSubject('Account was deleted');
            String body = 'Hi ' + UserName + ', <br>';
            body += 'Due to deletion of Account ' + acc.Name + ' all next related Opportunities were deleted as well:<br>';
            Integer i = 1;
            for (Opportunity opp : list_opp) {
                body += i + '. ' + opp.id + ', ' + opp.Name + '.<br>';
                i++;
            }
            mail.setHtmlBody(body);
            mails.add(mail);
        }
        Messaging.sendEmail(mails);
        delete list_opp_all;
    }
}