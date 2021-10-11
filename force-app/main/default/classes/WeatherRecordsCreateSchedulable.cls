global with sharing class WeatherRecordsCreateSchedulable implements Schedulable {
    //Class runs every day at 1 AM
    public static String CRON_EXP = '0 0 1 * * ?';
    global void execute(SchedulableContext ctx){
         WeatherRecords.createFromOpenweathermap();
    }
}
