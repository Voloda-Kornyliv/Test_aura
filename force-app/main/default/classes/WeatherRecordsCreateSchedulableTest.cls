@istest
public with sharing class WeatherRecordsCreateSchedulableTest {
    @TestSetup
    static void makeData(){
        Weather_Setting__c setting = new Weather_Setting__c(Name = 'test',
        city_name__c = 'Lviv', 
        language__c = 'English');
        insert setting;
    }
    @isTest
    static void TestCreateRecord(){
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('WeatherRecordsCreateSchedulable',
            WeatherRecordsCreateSchedulable.CRON_EXP,
            new WeatherRecordsCreateSchedulable());
        // Verify the scheduled job has not run yet.
        List<Weather__c> lt = [SELECT Id
            FROM Weather__c];
        System.assertEquals(0, lt.size());
        Test.stopTest();
        System.assertEquals(0, lt.size());
    }
}
