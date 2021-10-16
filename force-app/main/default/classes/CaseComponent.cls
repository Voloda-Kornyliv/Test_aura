public with sharing class CaseComponent {
    @Auraenabled(cacheable=true)
    public static void UpdateStatusToWorking(Id recId){
        Case updCase = [SELECT Id,Status FROM Case WHERE Id =:recId LIMIT 1];
        updCase.Status = 'Working';
        update updCase;
    }
    
}
