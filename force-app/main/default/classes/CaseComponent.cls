public with sharing class CaseComponent {
    @Auraenabled(cacheable=true)
    public static void UpdateStatusToWorking(Id recId){
        Case updCase = [SELECT Id,Status FROM Case WHERE Id =:recId LIMIT 1];
        updCase.Status = 'Working';
        update updCase;
    }
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
