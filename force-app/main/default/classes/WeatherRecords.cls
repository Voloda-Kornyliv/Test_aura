public with sharing class WeatherRecords{
    public static void createFromOpenweathermap() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        Weather_Setting__c setting = [SELECT city_name__c,
                language__c
            FROM Weather_Setting__c
            LIMIT 1];
        WeatherApp__mdt WeatherApp = WeatherApp__mdt.getInstance('API_key');
        request.setEndpoint('https://api.openweathermap.org/data/2.5/weather?q=' +
            setting.city_name__c+
            '&lang=' + setting.language__c
            +'&appid=' + WeatherApp.Key__c);
        request.setMethod('GET');
        HttpResponse response;
        if(Test.isRunningTest()){
            response = new HttpResponse();
            response.setBody('{"coord":{"lon":24.0232,"lat":49.8383},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":283.39,"feels_like":281.7,"temp_min":283.18,"temp_max":283.44,"pressure":1020,"humidity":47},"visibility":10000,"wind":{"speed":4,"deg":130},"clouds":{"all":0},"dt":1633945739,"sys":{"type":1,"id":8909,"country":"UA","sunrise":1633927142,"sunset":1633966915},"timezone":10800,"id":702550,"name":"Lviv","cod":200}');
            response.setStatusCode(200);
        }else {
            response = http.send(request);
        }

        if(response.getStatusCode() == 200) {    
            insert parseJSON(response, setting.city_name__c);
        }
        else {
            System.debug('an error occurred during parsing');
        }
    }
    private static Weather__c parseJSON(HttpResponse response,String city){
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
            Name = city + String.valueOf(dat),
            city_name__c = city,
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
        return weatherToInsert;
    }
}
