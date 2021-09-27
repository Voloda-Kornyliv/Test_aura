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
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Delete Account'];
        //map Opportunityes
        Set<Id> stAccId = new Set<Id>();
        for(Account acc : (List<Account>)Trigger.old)
        {
            stAccId.add(acc.id);
        }
        List<Opportunity> lstOpportunity = [SELECT Name, Id,AccountId FROM Opportunity WHERE AccountId IN :stAccId];
        Map<String,List<Opportunity>> mapAccountWiseOpportunity = new Map<String,List<Opportunity>>();
        for(Opportunity Opps : lstOpportunity)
        {
            if(mapAccountWiseOpportunity.containsKey(Opps.accountId))
            {
                List<Opportunity> lstOpp = mapAccountWiseOpportunity.get(Opps.accountId);
                lstOpp.add(Opps);
            }
            else
            {
                List<Opportunity> lstOpp = new List<Opportunity>();
                lstOpp.add(Opps);
                mapAccountWiseOpportunity.put(Opps.accountId,lstOpp);
            }
        }
        //all deleted account
        for (Id key : mapAccountWiseOpportunity.keySet()) {
            List<Opportunity> list_opp = mapAccountWiseOpportunity.get(key);
            list_opp_all.addAll(list_opp);
            Messaging.SingleEmailMessage email = Messaging.renderStoredEmailTemplate(emailTemplate.Id, UserInfo.getUserId(), key);
            String emailSubject = email.getSubject();
            String emailTextBody = email.getPlainTextBody();
            email.setTargetObjectId(UserInfo.getUserId());
            email.setSubject(emailSubject);
            email.setPlainTextBody(emailTextBody);
            email.saveAsActivity = false;   
            String plainText = email.getPlainTextBody();
            System.debug(plainText);
            String OppsText = '<br>';
            Integer i = 1;
            for (Opportunity opp : list_opp) {
                OppsText += i + '. ' + opp.id + ', ' + opp.Name + '.<br>';
                i++;
            }
            plainText += OppsText;
            email.setHtmlBody(plainText);
            mails.add(email);
        }
        delete list_opp_all;
        Messaging.sendEmail(mails);
    }
}