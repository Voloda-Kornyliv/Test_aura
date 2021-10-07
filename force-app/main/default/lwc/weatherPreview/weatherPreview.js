import { LightningElement, track, wire } from 'lwc';
import getAllWeather from "@salesforce/apex/WeatherApp.getAllWeather";
const COLUMNS = [
    { label: 'Weather Name', fieldName: 'recordLink',  type: 'url', typeAttributes:{label:{fieldName: 'Name', target: '_blank'}} },
    { label: 'City name', fieldName: 'city_name__c', type: 'text' },
    { label: 'Tempatarure', fieldName: 'temperature__c', type: 'number' },
    { label: 'Date', fieldName: 'date__c', type: 'text' }
];
export default class WeatherPreview extends LightningElement {
    columns = COLUMNS;
    @track dataWeather;
    @wire(getAllWeather)
    getWeathers({ error, data }){
        if (data){
            var tempweather = []; 
            for (var i = 0; i < data.length; i++) {
                let tempRecord = Object.assign({}, data[i]);
                tempRecord.recordLink = '/lightning/r/Weather__c/' + tempRecord.Id + '/view';
                tempweather.push(tempRecord); 
            }
            this.dataWeather = tempweather; 
        }
        else if(error){
            console.log(error);
        }
     }
}