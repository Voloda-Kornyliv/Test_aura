public class DeleteAllColdLeads implements Database.Batchable<sObject>, Database.stateful {
    public Integer totalAmtOfRecords = 0; 
    public Database.querylocator start(Database.BatchableContext BC){
        String query = 'SELECT Id, Rating FROM Lead WHERE Rating = \'Cold\'';
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext BC, List<sObject> scope){
        totalAmtOfRecords += scope.size();
        delete scope;
    }
    public void finish(Database.BatchableContext BC){
        AsyncApexJob a = [SELECT Id, Status,ExtendedStatus,NumberOfErrors, JobItemsProcessed,TotalJobItems, CreatedBy.Email    FROM AsyncApexJob WHERE Id =:BC.getJobId()];
        EmailTemplate emailTemplate = [SELECT Id,Subject,Description,HtmlValue,DeveloperName,Body FROM EmailTemplate WHERE DeveloperName = 'Lead_Delete'];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();  
        mail.setTemplateId(emailTemplate.id);
        mail.setToAddresses(new String[] {a.CreatedBy.Email});        
        mail.setSaveAsActivity(false);
        mail.setPlainTextBody(emailTemplate.Body.replace('COUNT', String.valueOf(totalAmtOfRecords)));    
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}
