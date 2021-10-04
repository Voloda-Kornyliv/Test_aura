public with sharing class SendEmailAboutAccountAndOpportunityes {
    public static void SendEmail(List<Account> deletedAccount) {
        List<Messaging.SingleEmailMessage> mails = 
             new List<Messaging.SingleEmailMessage>();
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where name = 'Delete Account'];
        List<Opportunity> lstOpportunity = [SELECT Name, Id,AccountId FROM Opportunity WHERE AccountId IN :deletedAccount];
        Map<String, List<Opportunity>> mapAccountWiseOpportunity = new Map<String,List<Opportunity>>();
        for(Opportunity Opps : lstOpportunity){
            if(!mapAccountWiseOpportunity.containsKey(Opps.accountId)){
                mapAccountWiseOpportunity.put(Opps.accountId, new List<Opportunity>());
            }
            mapAccountWiseOpportunity.get(Opps.accountId).add(opps);
        }
        //all deleted account
        for (Id key : mapAccountWiseOpportunity.keySet()) {
            Messaging.SingleEmailMessage email = Messaging.renderStoredEmailTemplate(emailTemplate.Id, UserInfo.getUserId(), key);
            String emailSubject = email.getSubject();
            String emailTextBody = email.getPlainTextBody();
            email.setTargetObjectId(UserInfo.getUserId());
            email.setSubject(emailSubject);
            email.setPlainTextBody(emailTextBody);
            email.saveAsActivity = false;   
            String plainText = email.getPlainTextBody();
            String OppsText = '<br>';
            Integer i = 1;
            //void
            for (Opportunity opp : mapAccountWiseOpportunity.get(key)) {
                OppsText += i + '. ' + opp.id + ', ' + opp.Name + '.<br>';
                i++;
            }
            plainText += OppsText;
            email.setHtmlBody(plainText);
            mails.add(email);
        }
        delete lstOpportunity;
        Messaging.sendEmail(mails);
    }
}
