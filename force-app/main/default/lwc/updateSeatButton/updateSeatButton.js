import { LightningElement } from 'lwc';
import updateSeatButtonForAdmin from '@salesforce/apex/updateSeatButtonForAdmin.myButton';

export default class UpdateSeatButton extends LightningElement {
    handleUpdateStatus(){
        updateSeatButtonForAdmin()
        .then(response => {
            console.log(response);
        })
        .catch(error => {
            console.log(error);
        })
    }
}