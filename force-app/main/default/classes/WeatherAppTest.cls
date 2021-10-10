@isTest
public with sharing class WeatherAppTest {
    @TestSetup
    static void makeData(){
        List<Weather__c> listW = new List<Weather__c>();
        for (Integer i = 0; i< 10; i++) {
            listW.add(new Weather__c(Name = 'Name'+ 1,
              city_name__c = 'Lviv',
              temperature__c = i ));
        }
        insert listW;
        Weather_Setting__c setting = new Weather_Setting__c(Name = 'test',
            city_name__c = 'Lviv', 
            language__c = 'English');
        insert setting;
    }
    @isTest
    static void TestAll(){
        Weather_Setting__c setting;
        Integer count;
        Test.startTest();
        count = WeatherApp.getAllWeather().size();
        setting = WeatherApp.getWeatherSetting();
        Test.stopTest();
        System.assertEquals(10, count);
        System.assertEquals('Lviv', setting.city_name__c);
        
    }
}
