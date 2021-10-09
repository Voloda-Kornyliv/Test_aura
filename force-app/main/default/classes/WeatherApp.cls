public with sharing class WeatherApp {
    @AuraEnabled(cacheable=true)
    public static List<Weather__c> getAllWeather() {
        return [SELECT Name, city_name__c,
            temperature__c,date__c
        FROM Weather__c
        ORDER BY date__c DESC];
    }
    @AuraEnabled(cacheable=true)
    public static Weather_Setting__c getWeatherSetting() {
        return [SELECT Name, id, city_name__c, language__c
        FROM Weather_Setting__c
        LIMIT 1];
    }
}
