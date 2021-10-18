public with sharing class CaseComponent {
    @Auraenabled(cacheable=true)
    public static List<Case> GetCaseByDateCreate(){
        return [SELECT 
            CaseNumber,
            Status,
            CreatedDate
        FROM Case
        WHERE Show_User__c = TRUE
        ORDER BY CreatedDate DESC];
    }
}
