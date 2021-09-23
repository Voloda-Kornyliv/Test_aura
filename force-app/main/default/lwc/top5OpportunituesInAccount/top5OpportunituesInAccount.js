import { LightningElement, api,wire,track  } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import STAGENAME_FIELD from '@salesforce/schema/Opportunity.StageName';
import CLOSEDATE_FIELD from '@salesforce/schema/Opportunity.CloseDate';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';
import getOpportunity from "@salesforce/apex/GetTop5Opportynitues.getOpportunity";
const COLUMNS = [
    { label: 'Opportynitu Name', fieldName: NAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Stage name', fieldName: STAGENAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Close date', fieldName: CLOSEDATE_FIELD.fieldApiName, type: 'text' },
    { label: 'Amount', fieldName: AMOUNT_FIELD.fieldApiName, type: 'currency' }
];
export default class Top5OpportunituesInAccount extends LightningElement {
    columns = COLUMNS;
    @api recordId;
    @wire(getOpportunity, {recordIdAccount: '$recordId'}) Opportynitues;
    
}