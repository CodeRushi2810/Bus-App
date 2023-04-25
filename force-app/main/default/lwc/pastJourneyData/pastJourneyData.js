import { LightningElement , api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import { NavigationMixin } from 'lightning/navigation';

export default class PastJourneyData extends NavigationMixin(LightningElement) {
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


    handleRateJourney(event){
                const journeyId = event.target.value;
                this[NavigationMixin.Navigate]({
                    type: 'comm__namedPage',
                    attributes: {
                        name: 'Feedback_Form__c'
                    },
                    state:{
                        Id:journeyId,
                    }
                })
            }
}