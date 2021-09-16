trigger CustomReportTrigger on Customer_Report__c (before insert, before update, after insert, after update) {
    new CustomReportTriggerHandler().run();
}