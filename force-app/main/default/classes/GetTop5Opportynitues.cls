public with sharing class GetTop5Opportynitues {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunity(Id recordIdAccount){
        return [SELECT Id,Name,StageName,CloseDate,Amount 
            FROM Opportunity 
            WHERE AccountId = :recordIdAccount 
                AND StageName != 'Closed Lost' AND StageName !='Closed Won'
            WITH SECURITY_ENFORCED
            ORDER BY Amount DESC
            LIMIT 5];
    }
}
