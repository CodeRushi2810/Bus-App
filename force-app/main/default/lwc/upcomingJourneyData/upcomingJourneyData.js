/* eslint-disable @lwc/lwc/no-async-operation */
import { LightningElement, api , track } from 'lwc';
import GetSeatsToCancelList from '@salesforce/apex/GetSeatsToCancelList.seatList';
import CancelBooking from '@salesforce/apex/CancelBooking.cancelTicket';

import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UpcomingJourneyData extends NavigationMixin(LightningElement) {

    @api record;
    @track seatList = [];
    @track showExtraDetails = false;
    @track firstFunctionCall = true;


    handleCancelledSuccessfully() {
        const event = new ShowToastEvent({
            message: 'Your booking has been cancelled Successfully',
            variant: 'success',
        });
        this.dispatchEvent(event);
    }
    handleCancellationFailed() {
        const event = new ShowToastEvent({
            message: 'Cancellation Failed',
            variant: 'error',
        });
        this.dispatchEvent(event);
    }


    handleShowMore(event){
        if(this.showExtraDetails === false){
            this.showExtraDetails = true;
        }else if (this.showExtraDetails === true) {
            this.showExtraDetails = false;
        }

        const journeyId = event.target.value;
        if(this.firstFunctionCall === true){
            GetSeatsToCancelList({journeyId : journeyId})
            .then(response => {
                this.seatList = response;
                console.log(this.seatList);
            })
            .catch(error => {
                console.log(error);
            })
            this.firstFunctionCall = false;
        }
    }

    @track showCancelPopupBox = false;
    handleCancelBooking(){
        console.log('Clicked');
        if(this.showCancelPopupBox === false){
            this.showCancelPopupBox = true;
        }else{
            this.showCancelPopupBox = false;
        }
    }

    cancelBooking(){
        console.log('Clicked');
        CancelBooking({PJSIds : this.seatList})
        .then(response => {
            console.log(response);
            if (response === 'Tickets Cancelled Successfully') {
                this.handleCancelledSuccessfully();
                setTimeout( () => {
                    this[NavigationMixin.Navigate]({
                        type: 'comm__namedPage',
                        attributes: {
                            name: 'Home'
                        },
                    })
                },2000);
                
            }else if(response === 'Ticket Cancellation Failed'){
                this.handleCancellationFailed();
                setTimeout( () => {
                    this[NavigationMixin.Navigate]({
                        type: 'comm__namedPage',
                        attributes: {
                            name: 'Home'
                        },
                    })
                },2000);
            }
        })
        .catch(error => {
            console.log(error);
        })
    }

    closePopup(){
        this.showCancelPopupBox = false;
    }
}