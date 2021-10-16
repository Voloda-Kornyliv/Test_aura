public with sharing class CaseComponent {
    @Auraenabled(cacheable=true)
    public static List<Case> GetCaseByDateCreate(){
        return [SELECT 
            CaseNumber,
            Status,
            CreatedDate
        FROM Case
        ORDER BY CreatedDate DESC];
    }
}
