public class DeleteAllColdLeadsController {
    @AuraEnabled(cacheable = true)
    public static void DeleteRecords(){
        Database.executeBatch(new DeleteAllColdLeads());
    }
}
