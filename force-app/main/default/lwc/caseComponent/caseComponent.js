import { LightningElement,track, wire } from 'lwc';
import {updateRecord} from 'lightning/uiRecordApi';
import GetCaseByDateCreate from '@salesforce/apex/CaseComponent.GetCaseByDateCreate';
import { refreshApex } from '@salesforce/apex';

const COLUMNS = [
    { label: 'CaseNumber', fieldName: 'CaseNumber', type:'text' },
    { label: 'CreatedDate', fieldName: 'CreatedDate',type: 'date' },
    { label: 'Status', fieldName: 'Status', type:'text' },
    {
        type: "button",
        fixedWidth: 150,
        typeAttributes: {
            label: 'View Details',
            title: 'View Details',
            name: 'viewDetails',
            value: 'id',
            variant: 'brand',
            class: 'scaled-down'
        }
    },
];
export default class CaseComponent extends LightningElement {
    wiredDataResult;
    @track listCase;
    columns = COLUMNS;
    @track recordId;
    @wire(GetCaseByDateCreate)
    getCase(result){
        this.wiredDataResult = result;
        if (result.data){
            this.listCase = result.data; 
            this.recordId = result.data[0].Id;
        }
        else if(result.error){
            console.log(result.data);
        }
    }
    changeRecordId(event){
        // var audio = new Audio('audio_file.mp3');
        // audio.play();
        let fields = {
            Id: event.detail.row.Id,
            Status: 'Working'
        }
        const recordInput = { fields };
        updateRecord(recordInput).then(result => {          
            refreshApex(this.wiredDataResult);
            this.recordId = event.detail.row.Id;
        }).catch(error =>{
            console.log(error);
        });
    }


}