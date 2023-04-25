import { LightningElement, wire , track} from 'lwc';
import confirmImage from '@salesforce/resourceUrl/BookingConfirmation';
import USER_NAME_EMAIL from '@salesforce/schema/User.Email';
import { NavigationMixin } from 'lightning/navigation';
import { getRecord } from 'lightning/uiRecordApi';

import USER_ID from '@salesforce/user/Id';


export default class ConfirmBookingPage extends NavigationMixin(LightningElement) {
    confirmImage = confirmImage;

    @track userEmail;

    @wire(getRecord, { recordId: USER_ID, fields: [USER_NAME_EMAIL] })
    wiredUserEmail({ error, data }) {
        if (data) {
            console.log('User Email...............');
            console.log(data);
            this.userEmail = data.fields.Email.value;
        } else if (error) {
            console.error(error);
        }
    }

    handleNavigateToHome(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            },
        })
    }
}