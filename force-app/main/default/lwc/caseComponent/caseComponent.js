import { LightningElement,track, wire } from 'lwc';
import {updateRecord} from 'lightning/uiRecordApi';
import GetCaseByDateCreate from '@salesforce/apex/CaseComponent.GetCaseByDateCreate';
import UpdateStatusToWorking from '@salesforce/apex/CaseComponent.UpdateStatusToWorking';

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
    @track listCase;
    columns = COLUMNS;
    @track recordId;
    @wire(GetCaseByDateCreate)
    getCase({ error, data }){
        if (data){
            this.listCase = data; 
            this.recordId = data[0].Id;
        }
        else if(error){
            console.log(error);
        }
    }
    // reoladView(){
    //     GetCaseByDateCreate().then(result =>{
    //         this.data = result;
    //     }).catch(error => {
    //         console.log(error);
    //     })
    // }
    changeRecordId(event){
        let fields = {
            Id: event.detail.row.Id,
            Status: 'Working'
        }
        const recordInput = { fields };
        updateRecord(recordInput).then(result => {
            // reoladView();
        }).catch(error =>{
            console.log(error);
        });
    }


}