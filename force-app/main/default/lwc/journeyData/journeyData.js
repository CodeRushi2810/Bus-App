import { LightningElement , api } from 'lwc';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class JourneyData extends LightningElement {

    @api record;
 
    handleFeedbackReceived() {
        const event = new ShowToastEvent({
            title: 'Success!',
            message: 'Thanks for your feedback!',
            variant: 'success',
        });
        this.dispatchEvent(event);
    }
    
    handleFeedbackInsertionFailed() {
        const event = new ShowToastEvent({
            title: 'Sorry!',
            message: 'We are facing some technical issues! Feedback not submitted!',
            variant: 'danger',
        });
        this.dispatchEvent(event);
    }
    handlefillAllTheDetails() {
        const event = new ShowToastEvent({
            title: 'Alert!',
            message: 'Please fill all the detils!',
            variant: 'danger',
        });
        this.dispatchEvent(event);
    }
}