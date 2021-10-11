public with sharing class WeatherRecords {
    public static void Create() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Weather_Setting__c setting = [SELECT city_name__c,
                language__c
            FROM Weather_Setting__c
            LIMIT 1];
        request.setEndpoint('https://api.openweathermap.org/data/2.5/weather?q=' +
            setting.city_name__c+
            '&lang=' + setting.language__c
            +'&appid=b4b4fb6fbf9dd544defc76fa249df123');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if(response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Map<String, Object> coord = (Map<String, Object>)results.get('coord');
            Double parse_lon = Double.valueOf(coord.get('lon'));
            Double parse_lat = Double.valueOf(coord.get('lat'));
            List<Object> weatherlist = (List<Object>)results.get('weather');
            Map<String, Object> weather = (Map<String, Object>)weatherlist[0];
            String parse_description = String.valueOf(weather.get('description'));
            Map<String, Object> main = (Map<String, Object>)results.get('main');
            Double parse_temperature = Double.valueOf(main.get('temp')) - 273.15;
            Double parse_temp_feels_like = Double.valueOf(main.get('feels_like')) - 273.15;
            Double parse_pressure = Double.valueOf(main.get('pressure'));
            Double parse_humidity = Double.valueOf(main.get('humidity'));
            Map<String, Object> wind = (Map<String, Object>)results.get('wind');
            Double parse_wind_speed =  Double.valueOf(wind.get('speed'));
            Date dat = Date.valueOf(System.now());
            
            Weather__c weatherToInsert = new Weather__c(
                Name = setting.city_name__c + String.valueOf(dat),
                city_name__c = setting.city_name__c,
                weather_description__c = parse_description,
                temperature__c = parse_temperature,
                temp_feels_like__c = parse_temp_feels_like,
                pressure__c = parse_pressure,
                humidity__c = parse_humidity,
                wind_speed__c = parse_wind_speed,
                coordinate__Latitude__s = parse_lat,
                coordinate__Longitude__s = parse_lon,
                date__c = dat
            );
            insert weatherToInsert;
        }
    }
}
