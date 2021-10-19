import { LightningElement, api } from 'lwc';

export default class InputAccountDetalias extends LightningElement {
    @api numrow;
    @api recordData;
    get showPlus(){
        if(this.numrow == 1)
            return true;
        return false;
    }
    addClick(){
        this.dispatchEvent(new CustomEvent('add'));
    }
    removeClick(){
        this.dispatchEvent(new CustomEvent('remove'));
    }
    handleChnage(){
        
        this.dispatchEvent(new CustomEvent('changedata'));
    }
}