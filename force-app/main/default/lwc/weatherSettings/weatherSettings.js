import { LightningElement, wire, track } from 'lwc';
import getWeatherSetting from "@salesforce/apex/WeatherApp.getWeatherSetting";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class WeatherSettings extends LightningElement {
    @track recordId;
    @wire(getWeatherSetting)
    getWeathers({ error, data }){
        if (data){
            this.recordId = data.Id;
        }
        else if(error){
            console.log(error);
        }
    }
    handleSuccess() {
        const event = new ShowToastEvent({
            title: 'Success',
            message: 'Setting saved',
            variant: 'success',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
}