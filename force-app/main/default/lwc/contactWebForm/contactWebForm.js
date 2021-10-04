import { LightningElement, api } from 'lwc';

export default class ContactWebForm extends LightningElement {
    @api recordId;
    @api objectApiName;
}