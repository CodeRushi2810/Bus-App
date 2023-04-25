/* eslint-disable radix */
/* eslint-disable no-useless-escape */
/* eslint-disable no-unused-vars */
/* eslint-disable @lwc/lwc/no-async-operation */
/* eslint-disable no-restricted-globals */
/* eslint-disable no-shadow */
// import { LightningElement ,wire, track} from 'lwc';
// import GetCurrentUserAccountId from '@salesforce/apex/GetCurrentUserAccountId.getUserId';
// import getWalletAmount from '@salesforce/apex/getWalletAmount.walletBalance';
// import UpdateUserBalanceController from '@salesforce/apex/UpdateUserBalanceController.updateBalance';
// import InsertPassengerJourney from '@salesforce/apex/InsertPassengerJourney.passengerJourney';
// import ShowSelectedSeatsController from '@salesforce/apex/ShowSelectedSeatsController.displaySelectedSeats';
// import CheckSeatStatus from '@salesforce/apex/CheckSeatStatus.checkStatus';
// import UpdateSeatStatusController from '@salesforce/apex/UpdateSeatStatusController.updateSeatStatus';
// import { getRecord } from 'lightning/uiRecordApi';
// import USER_ID from '@salesforce/user/Id';
// import USER_NAME_FIELD from '@salesforce/schema/User.Name';
// import SendConfirmationEmail from '@salesforce/apex/SendConfirmationEmail.sendEmail';
// import fetchBusData from '@salesforce/apex/fetchBusData.busName';

// import { NavigationMixin } from 'lightning/navigation';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// import { CurrentPageReference } from 'lightning/navigation';

// export default class Payment extends NavigationMixin(LightningElement) {

//     fare;
//     accountId;
//     busId;
//     sourceCity;
//     destinationCity;

//     @track journey = [];
//     @track selectedSeats = [];
//     @track seatIdsToPass = [];
//     @track busName = '';
//     @wire(CurrentPageReference)
//     getPageReferenceParameters(currentPageReference) {
//         this.fare = currentPageReference.state.fare;
//         this.accountId = currentPageReference.state.accountId;
//         this.busId = currentPageReference.state.busId;
//         this.sourceCity = currentPageReference.state.sc;
//         this.destinationCity = currentPageReference.state.ds;
//     }
//     @track userWalletBalance;
//     currentDate;
//     connectedCallback(){

//         fetchBusData({busId: this.busId})
//         .then(response => {
//             this.busName = response;
//         })
//         .catch(error => {
//             console.log(error);
//         })

//         const dateOptions = { 
//             year: 'numeric', 
//             month: 'long', 
//             day: 'numeric' 
//         };
//         this.currentDate = new Date().toLocaleDateString('en-US', dateOptions);

//         const mySeats = JSON.parse(localStorage.getItem('selectedSeats'));

//         localStorage.removeItem('selectedSeats');

//         GetCurrentUserAccountId()
//             .then(response => {
//                 this.accountId = response;
//             })
//             .catch(error => {
//                 console.log(error);
//             })
//         setTimeout( () => {
//             getWalletAmount({userId : this.accountId})
//             .then(response => {
//                 this.userWalletBalance = response;
//             })
//             .catch(error => {
//                 console.log(error);
//             })

//             ShowSelectedSeatsController({seatId : mySeats})
//             .then(response => {
//                 this.selectedSeats = response;
//                 console.log('Selected Seats : ');
//                 console.log(this.selectedSeats);
//                 const selectedSeatsId = this.selectedSeats.map(record => record.Id);
//                 this.seatIdsToPass = selectedSeatsId;
//                 console.log(this.seatIdsToPass);
//             })
//             .catch(error => {
//                 console.log(error);
//             })
//         }, 500)
        
//     }

//     handleBookedSuccessfully() {
//         const event = new ShowToastEvent({
//             title: 'Success!',
//             message: 'Booked Successfully',
//             variant: 'success',
//         });
//         this.dispatchEvent(event);
//     }
//     handleInsufficientBalance() {
//         const event = new ShowToastEvent({
//             title: 'Failed!',
//             message: 'Insufficient Balance',
//             variant: 'error',
//         });
//         this.dispatchEvent(event);
//     }
//     handleTransactionFailed() {
//         const event = new ShowToastEvent({
//             title: 'Failed!',
//             message: 'Insufficient Balance',
//             variant: 'error',
//         });
//         this.dispatchEvent(event);
//     }
//     handleAlreadyBooked() {
//         const event = new ShowToastEvent({
//             title: 'Failed!',
//             message: 'Sorry! Someone else booked the ticket!',
//             variant: 'danger',
//         });
//         this.dispatchEvent(event);
//     }

//     @track displayReceipt = false;

//     userName;

//     @wire(getRecord, { recordId: USER_ID, fields: [USER_NAME_FIELD] })
//     wiredUser({ error, data }) {
//         if (data) {
//             this.userName = data.fields.Name.value;
//         } else if (error) {
//             console.error(error);
//         }
//     }
    // handlePayment(){

    //     if(this.fare <= this.userWalletBalance){

    //         CheckSeatStatus({seatId : this.seatIdsToPass})
    //         .then(response => {
    //             if (response === null) {
    //                 this.handleAlreadyBooked();
    //             }else if(response.length >= 1){
    //                 UpdateUserBalanceController({userId : this.accountId , fare : this.fare})
    //                 .then(response => {
    //                     if (response === 'Transaction Successfull') {

    //                         const bodyTemplate = 'Hello ' + this.userName+'! Your ticket has been booked successfully. Bus Name : '+ this.busName+' | Journey Date : '+ this.currentDate +' | Pick Up Point : '+this.sourceCity+' | Drop Point : '+this.destinationCity+'. Thank you for choosing Unicorn Bus. Have a Safe and Happy Journey'


    //                         SendConfirmationEmail({subject: 'Ticket Confirmation',body: bodyTemplate})
    //                         .then(response => {
    //                             console.log(response);
    //                         })
    //                         .catch(error => {
    //                             console.log(error);
    //                         })
    //                         this.handleBookedSuccessfully();
    //                         this.displayReceipt = true;
    //                         UpdateSeatStatusController({seatId : this.seatIdsToPass})
    //                         .then(response => { 
    //                             console.log(response);
    //                         })
    //                         .catch(error => { 
    //                             console.log(error); 
    //                         })
    //                         const mySeatId = this.seatIdsToPass[0];
    //                         console.log('My Seat Id : '+mySeatId); 
    //                         const bookingDate = new Date();
    //                         InsertPassengerJourney({busId:this.busId , fare: this.fare, sourceCity: this.sourceCity, destinationCity: this.destinationCity, bookingDate: bookingDate, seatId : mySeatId})
    //                         .then(response => {
    //                             if(response === 'Data inserted successfully'){
    //                                 console.log('Data Inserted Successfully');
    //                             }else if(response === 'Data insertion failed'){
    //                                 console.log('Data Insertion Failed');
    //                             }
    //                         }).catch(error => {
    //                             console.log(error);
    //                         })
    //                         setTimeout( () => {
    //                             this[NavigationMixin.Navigate]({
    //                                 type: 'comm__namedPage',
    //                                 attributes: {
    //                                     name: 'Home'
    //                                 },
    //                             })
    //                         },5000);

    //                     }else if(response === 'Transaction Failed'){
    //                         console.log('Transaction Failed');
    //                         this.handleTransactionFailed();
    //                         setTimeout( () => {
    //                             this[NavigationMixin.Navigate]({
    //                                 type: 'comm__namedPage',
    //                                 attributes: {
    //                                     name: 'Home'
    //                                 },
    //                             })
    //                         },5000);
    //                     }
    //                 })
    //                 .catch(error => {
    //                     console.log(error);
    //                 })
    //             }
    //         }) 
    //         .catch(error => {
    //             console.log(error);
    //         })
    //     }
    //     else{
    //         this.handleInsufficientBalance();
    //         console.log('Insufficient Balance');
    //         setTimeout( () => {
    //             this[NavigationMixin.Navigate]({
    //                 type: 'comm__namedPage',
    //                 attributes: {
    //                     name: 'Home'
    //                 },
    //             })
    //         },5000);
    //     }
    // }
// }


// New Beginning............................................

import { LightningElement, track, wire} from 'lwc';
import GetCityNames from '@salesforce/apex/GetCityNames.cityNames';
import TotalFareCalculator from '@salesforce/apex/TotalFareCalculator.calculateTotalFare';
import SittingSeatFareCalculator from '@salesforce/apex/SittingSeatFareCalculator.calculateSittingFare';
import SleeperSeatFareCalculator from '@salesforce/apex/SleeperSeatFareCalculator.calculateSleeperFare';
import ReturnTotalSelectedSeatType from '@salesforce/apex/ReturnTotalSelectedSeatType.returnSeatTypeCount';
import DisplayBusDataAfterSeatSelection from '@salesforce/apex/DisplayBusDataAfterSeatSelection.busData';
import GetTravelerDetails from '@salesforce/apex/GetTravelerDetails.showTravelerData';
import getWalletAmount from '@salesforce/apex/getWalletAmount.walletBalance';
import SendOTPForPaymentVerification from '@salesforce/apex/SendOTPForPaymentVerification.sendOTP';
import TestPDFClass from "@salesforce/apex/TestPDFClass.sendPdf";

import UpdateUserBalanceController from '@salesforce/apex/UpdateUserBalanceController.updateBalance';
import UpdateSeatStatusController from '@salesforce/apex/UpdateSeatStatusController.updateSeatStatus';
import UpdateTravellerStatusController from '@salesforce/apex/UpdateTravellerStatusController.updateStatus';
import InsertPassengerJourney from '@salesforce/apex/InsertPassengerJourney.passengerJourney';
import SelectPickupPointController from '@salesforce/apex/SelectPickupPointController.pickupPoint';
import SelectDropPointController from '@salesforce/apex/SelectDropPointController.dropPoint';

import { getRecord } from 'lightning/uiRecordApi';
import USER_ID from '@salesforce/user/Id';
import USER_NAME_FIELD from '@salesforce/schema/User.Name';
import USER_NAME_EMAIL from '@salesforce/schema/User.Email';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class Payment extends NavigationMixin(LightningElement) {


    @track selectedStep = 'Step2';
    @track isOTPSent = false;
    selectStep1() {
        this.selectedStep = 'Step1';
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Bus_Information__c'
            }
        })
    }
 
    selectStep2() {
        this.selectedStep = 'Step2';
        if(this.showEnterOtpPopUp === true){
            this.showEnterOtpPopUp = false;
        }
    }

    selectStep3() {
        if(this.isOTPSent === true){
            this.selectedStep = 'Step3';
            if(this.showEnterOtpPopUp === false){
                this.showEnterOtpPopUp = true;
            }
        }
    }

    selectStep4() {
        if(this.isOTPSent === true){
            this.selectedStep = 'Step4';
            if(this.showEnterOtpPopUp === false){
                this.showEnterOtpPopUp = true;
            }
        }
    }

    handleOTPSent() {
    const event = new ShowToastEvent({
        message: 'An OTP has been sent to your registered email',
        variant: 'success',
    });
    this.dispatchEvent(event);
    }
    handleIncorrectOTP() {
    const event = new ShowToastEvent({
        message: 'Incorrect OTP',
        variant: 'danger',
    });
    this.dispatchEvent(event);
    }
    handleCorrectOTP() {
    const event = new ShowToastEvent({
        message: 'Verified Successfully',
        variant: 'success',
    });
    this.dispatchEvent(event);
    }

    handleBookedSuccessfully() {
    const event = new ShowToastEvent({
        title: 'Success!',
        message: 'Booked Successfully',
        variant: 'success',
    });
    this.dispatchEvent(event);
    }

    handleTicketInvoiceMailedSuccessfully() {
    const event = new ShowToastEvent({
        title: 'Success!',
        message: 'The invoice of the ticket has been sent to your registered email Id',
        variant: 'success',
    });
    this.dispatchEvent(event);
    }

    handleTicketInvoiceMailFailed() {
    const event = new ShowToastEvent({
        message: 'Failed to send ticket invoice to the registered Email Id!',
        variant: 'error',
    });
    this.dispatchEvent(event);
    }

    handleInsufficientBalance() {
        const event = new ShowToastEvent({
            title: 'Failed!',
            message: 'Insufficient Balance',
            variant: 'error',
        });
        this.dispatchEvent(event);
    }
    handleTransactionFailed() {
        const event = new ShowToastEvent({
            title: 'Failed!',
            message: 'Insufficient Balance',
            variant: 'error',
        });
        this.dispatchEvent(event);
    }
    handleAlreadyBooked() {
        const event = new ShowToastEvent({
            title: 'Failed!',
            message: 'Sorry! Someone else booked the ticket!',
            variant: 'danger',
        });
        this.dispatchEvent(event);
    }


    @track isFirstRender = true;
    @track sourceCity;
    @track destinationCity;
    @track totalFare;
    @track sittingFare;
    @track sleeperFare;
    @track sittingSeatsCount;
    @track sleeperSeatsCount;
    @track busId;
    @track busName;
    @track busType;
    @track travelerDetails = [];
    @track travelerIdsForStatusUpdation = [];
    @track seatIds = [];
    @track userAccountId;

    @track pickupPointAddress = [];
    @track pickupPointCity = [];
    @track dropPointAddress = [];
    @track dropPointCity = [];

    @track pickupDateTime;
    @track pickupTime;
    @track pickupDate;

    @track dropDateTime;
    @track dropTime;
    @track dropDate;
    @track journeyDuration; 

    @track busItineraryId;
    @track pickupPointId;
    @track dropPointId
    
    accountId;
    @track userWalletBalance;

    isSittingSeatFareVisible = false;
    isSleeperSeatFareVisible = false;

    renderedCallback(){
        if(this.isFirstRender){
            
            console.log('On Render');

            const storedPickupPoint = localStorage.getItem('pickupPointId');
            const storedDropPoint = localStorage.getItem('dropPointId');

            this.busItineraryId = JSON.parse(localStorage.getItem('busItineraryId'));
            console.log('Bus Itinerary Id : '+this.busItineraryId);

            const mySeats = JSON.parse(localStorage.getItem('selectedSeats'));
            console.log(mySeats);
            this.seatIds = mySeats;
            console.log('Seat Ids : '+this.seatIds);
            const accountId = JSON.parse(localStorage.getItem('accountId'));
            this.userAccountId = accountId;
            const localStorageTravellerIds = localStorage.getItem('travellerIds');
            console.log('Local Storage : '+localStorageTravellerIds);
            const travelerIds = JSON.parse(localStorageTravellerIds);
            this.travelerIdsForStatusUpdation = travelerIds;
            console.log('Parsed Id : '+travelerIds);   

            const pickupTime = localStorage.getItem('pickupTime');
            this.pickupDateTime = pickupTime.replace(/[\"']/g, '');
            [this.pickupDate, this.pickupTime] = this.pickupDateTime.split(", ");
            

            const dropTime = localStorage.getItem('dropTime');
            this.dropDateTime = dropTime.replace(/[\"']/g, '');
            [this.dropDate, this.dropTime] = this.dropDateTime.split(", ");

            this.journeyDuration = localStorage.getItem('journeyDuration');
            this.journeyDuration = this.journeyDuration.replace(/[\"']/g, '');

            SelectPickupPointController({pickupPointId : storedPickupPoint})
            .then(response => {
                console.log(response);
                this.pickupPointAddress = response.Address__c;
                this.pickupPointCity = response.City__r.Name;
                this.pickupPointId = response.Id;
            })
            .catch(error => {
                console.log(error);
            })

            SelectDropPointController({dropPointId : storedDropPoint})
            .then(response => {
                console.log(response);
                this.dropPointAddress = response.Address__c;
                this.dropPointCity = response.City__r.Name;
                this.dropPointId = response.Id;
            })
            .catch(error => {
                console.log(error);
            })

            GetTravelerDetails({travelerIds : travelerIds})
            .then(response => {
                console.log(response);
                this.travelerDetails = response;
            })
            .catch(error => {
                console.log(error);
            })


            GetCityNames({selectedSeatsItineraryIds : mySeats})
            .then(response => {
                //console.log(response);
                this.sourceCity =  response[0].Source__r.Name;
                this.destinationCity =  response[0].Destination__r.Name;
            })
            .catch(error => {
                console.log(error);
            })

            TotalFareCalculator({seatIds : mySeats})
            .then(response => {
                this.totalFare = response;
                console.log(response);
            })
            .catch(error => {
                console.log(error);
            })

            SittingSeatFareCalculator({seatIds : mySeats})
            .then(response => {
                this.sittingFare = response;
                console.log(response);
            })
            .catch(error => {
                console.log(error);
            })

            SleeperSeatFareCalculator({seatIds : mySeats})
            .then(response => {
                this.sleeperFare = response;
                console.log(response);
            })
            .catch(error => {
                console.log(error);
            })

            ReturnTotalSelectedSeatType({seatIds : mySeats})
            .then(response => {
                this.sittingSeatsCount = response[0];
                this.sleeperSeatsCount = response[1];
                console.log('Sitting Seat Count : '+this.sittingSeatsCount);
                console.log('Sleeper Seat Count : '+this.sleeperSeatsCount);
                if(this.sittingSeatsCount !== 0){
                    this.isSittingSeatFareVisible = true;
                }
                if(this.sleeperSeatsCount !== 0){
                    this.isSleeperSeatFareVisible = true;
                }
            })
            .catch(error => {
                console.log(error);
            })

            DisplayBusDataAfterSeatSelection({seatId : mySeats[0]})
            .then(response => {
                //console.log(response);
                if (response != null) {
                    this.busId = response[0].Id;
                    this.busName  = response[0].Name;
                    this.busType  = response[0].Type__c;
                }
            })
            .catch(error => {
                console.log(error);
            })

            getWalletAmount({userId : accountId})
            .then(response => {
                this.userWalletBalance = response;
                console.log('User Wallet Amount : '+this.userWalletBalance);
            })
            .catch(error => {
                console.log(error);
            })
            this.isFirstRender = false;
        }
    }

    userName;
    userEmail;

    @wire(getRecord, { recordId: USER_ID, fields: [USER_NAME_FIELD] })
    wiredUserName({ error, data }) {
        if (data) {
            console.log('User Name : ');
            console.log(data);
            this.userName = data.fields.Name.value;
        } else if (error) {
            console.error(error);
        }
    }
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


    @track OTP;
    @track showEnterOtpPopUp = false;

    handleSendOTP(){

        this.handleOTPSent();
         // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
         this.selectedStep = 'Step3';
         this.isOTPSent = true;
         // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

        if(this.showEnterOtpPopUp === false){
            this.showEnterOtpPopUp = true;
        }else{
            this.showEnterOtpPopUp = false;
        }

        SendOTPForPaymentVerification()
        .then(response => {
            this.OTP = response;
            if(this.OTP !== null){
                this.handleOTPSent();
                this.showEnterOtpPopUp = true;
            }else{
                this.showEnterOtpPopUp = false;
            }
            console.log(this.OTP);
        })
        .catch(error => {
            console.log(error);
        })
    }
    
    handleResendOTP(){
        this.handleOTPSent();
        SendOTPForPaymentVerification()
        .then(response => {
            this.OTP = response;
            if(this.OTP !== null){
                this.handleOTPSent();
                this.showEnterOtpPopUp = true;
            }else{
                this.showEnterOtpPopUp = false;
            }
            console.log(this.OTP);
        })
        .catch(error => {
            console.log(error);
        })
    }

    @track digit1 = '';
    @track digit2 = '';
    @track digit3 = '';
    @track digit4 = '';
    @track otpValue = '';

    handleKeyUp(event) {
        let inputElement = event.target;
        let maxLength = parseInt(inputElement.maxLength);
        let inputValue = inputElement.value;

        if (inputValue.length >= maxLength) {
            let nextElement = inputElement.nextElementSibling;
            if (nextElement != null) {
                nextElement.focus();
            }
        }
    }

    handleChange1(event) {
        this.digit1 = event.target.value;
        console.log(this.digit1);
    }
    handleChange2(event) {
        this.digit2 = event.target.value;
        console.log(this.digit2);
    }
    handleChange3(event) {
        this.digit3 = event.target.value;
        console.log(this.digit3);
    }
    handleChange4(event) {
        this.digit4 = event.target.value;
        console.log(this.digit4);
    }

    @track journeyId;
    @track areAllStepsCompleted = false;
    handleSubmitOTP(){
        let otpString = this.digit1+this.digit2+this.digit3+this.digit4;
        let otpNumber = parseInt(otpString);
        console.log(otpNumber + ' | '+typeof(otpNumber));

        if(this.OTP === otpNumber){
            console.log('Correct OTP');
            this.handleCorrectOTP();
            setTimeout( () => {

                this.selectedStep = 'Step4';
                if(this.totalFare <= this.userWalletBalance){
                    console.log('Account Id : '+this.userAccountId);
                    console.log('Wallet Balance : '+this.userWalletBalance);
                    console.log('Total Fare : '+this.totalFare);
        
                    UpdateUserBalanceController({userId : this.userAccountId , fare : this.totalFare})
                    .then(response => {
                        if (response === 'Transaction Successfull') {

                            UpdateSeatStatusController({seatId : this.seatIds})
                            .then(response => { 
                                console.log(response);
                            })
                            .catch(error => { 
                                console.log(error); 
                            })
                            this[NavigationMixin.Navigate]({
                                type: 'comm__namedPage',
                                attributes: {
                                    name: 'booking_confirmed__c'
                                },
                            })
        
                            const bookingDate = new Date();
                            InsertPassengerJourney({busId:this.busId , fare: this.totalFare, sourceCity: this.sourceCity, destinationCity: this.destinationCity, bookingDate: bookingDate, seatIds : this.seatIds, busItineraryId : this.busItineraryId , pickupPointId : this.pickupPointId , dropPointId : this.dropPointId})
                                    .then(response => {
                                        this.handleBookedSuccessfully();
                                        console.log('Passenger Journey Inserted Successfully | Journey Id : '+response);
                                        this.journeyId = response;
                                    }).catch(error => {
                                        console.log(error);
                                    })
                            setTimeout( () => {

                                UpdateTravellerStatusController({travellerIds : this.travelerIdsForStatusUpdation , Operation: 'Confirm Booking', journeyId : this.journeyId})
                                .then(response => {
                                    console.log(response);
                                })
                                .catch(error => {
                                    console.log(error);
                                })

                                TestPDFClass({journeyId : this.journeyId})
                                .then(response=>{
                                    console.log(response);
                                    this.handleTicketInvoiceMailedSuccessfully();
                                })
                                .catch(error=>{
                                    this.handleTicketInvoiceMailFailed();
                                    console.log(error);
                                })
                                this[NavigationMixin.Navigate]({
                                    type: 'comm__namedPage',
                                    attributes: {
                                        name: 'booking_confirmed__c'
                                    },
                                })
                            },3000);
        
                        }else if(response === 'Transaction Failed'){
                            console.log('Transaction Failed');
                            this.handleTransactionFailed();
                            setTimeout( () => {
                                this[NavigationMixin.Navigate]({
                                    type: 'comm__namedPage',
                                    attributes: {
                                        name: 'Home'
                                    },
                                })
                            },5000);
                        }
                    })
                    .catch(error => {
                        console.log(error);
                    })   
                }
                else{
                    this.handleInsufficientBalance();
                    console.log('Insufficient Balance');
                    setTimeout( () => {
                        this[NavigationMixin.Navigate]({
                            type: 'comm__namedPage',
                            attributes: {
                                name: 'Home'
                            },
                        })
                    },5000);
                }
            },1000)
        }else{
            console.log('Incorrect OTP');
            this.handleIncorrectOTP();
        }
    }    
}