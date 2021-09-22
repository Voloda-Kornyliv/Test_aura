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
        User activeUser = [Select Email, Name, Id From User where Username = : userName limit 1];
        String userEmail = activeUser.Email;
        OrgWideEmailAddress owea = [select Id from OrgWideEmailAddress where Address = 'st2883942@gmail.com'];
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Delete Account'];
        System.debug('emailTemplate'+emailTemplate);
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
            mail.setUseSignature(false);
            mail.setSaveAsActivity(false); 
            mail.setSubject('Account was deleted');
            mail.setTargetObjectId(activeUser.Id);
            mail.setTemplateID(emailTemplate.Id);
            mail.setWhatId(acc.Id); 
            String plainText = emailTemplate.body;
            System.debug(plainText);
            plainText = plainText.replace('{!User.Username}', UserName);
            plainText = plainText.replace('{!Account.Name}', AccName);
            // mail.setPlainTextBody(emailTemplate.body);
            // String body = 'Hi ' + UserName + ', <br>';
            // body += 'Due to deletion of Account ' + AccName + ' all next related Opportunities were deleted as well:<br>';
            Integer i = 1;
            plainText += '<br>';
            for (Opportunity opp : list_opp) {
                plainText += i + '. ' + opp.id + ', ' + opp.Name + '.<br>';
                i++;
            }
            mail.setHtmlBody(plainText);
            System.debug(mail);
            mails.add(mail);
        }
        delete list_opp_all;
        Messaging.sendEmail(mails);
    }
}