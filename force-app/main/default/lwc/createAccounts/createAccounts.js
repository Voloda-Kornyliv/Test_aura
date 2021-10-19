import { LightningElement, track } from 'lwc';

export default class CreateAccounts extends LightningElement {
    @track arr = [1];
    handleadd(){
        this.arr.push(this.arr.length + 1);
    }
    handleremove(){
        if(this.arr.length > 1){
            this.arr.pop();
        }
    }
}