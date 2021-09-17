import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
export default class EditRecords extends NavigationMixin(LightningElement) {
    @api recordId;
    handleSuccess(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: 'Customer_Report__c',
                actionName: 'view'
            },
        });
    }
}