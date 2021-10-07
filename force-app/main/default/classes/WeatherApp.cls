public with sharing class WeatherApp {
    @AuraEnabled(cacheable=true)
    public static List<Weather__c> getAllWeather() {
        return [SELECT Name, city_name__c,
            temperature__c,date__c
        FROM Weather__c
        ORDER BY date__c DESC];
    }
}
