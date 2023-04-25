/* eslint-disable @lwc/lwc/no-async-operation */
// import { LightningElement , track, wire } from 'lwc';
// import ViewSeatsController from '@salesforce/apex/ViewSeatsController.myMethod';
// import ShowSelectedSeatsController from '@salesforce/apex/ShowSelectedSeatsController.displaySelectedSeats';
// import TotalFareCalculator from '@salesforce/apex/TotalFareCalculator.calculateTotalFare';
// import CheckSeatStatus from '@salesforce/apex/CheckSeatStatus.checkStatus';
// import BusData from '@salesforce/apex/DisplayBusDataAfterSeatSelection.busData';
// import GetCurrentUserAccountId from '@salesforce/apex/GetCurrentUserAccountId.getUserId';
// import FetchStopsOfSelectedBus from '@salesforce/apex/FetchStopsOfSelectedBus.busStopList';
// import DistanceCalculator from '@salesforce/apex/DistanceCalculator.distanceCalculator';
// import seatSelect1 from '@salesforce/resourceUrl/seatSelect1';
// import seatSelect2 from '@salesforce/resourceUrl/seatSelect2';

// import { NavigationMixin } from 'lightning/navigation';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';
// import { CurrentPageReference } from 'lightning/navigation';


// export default class Seats extends NavigationMixin(LightningElement) {

//     busId;
//     totalDistance;
//     sourceCity;
//     destinationCity;
//     stop1;
//     stop2;
//     stop3;
//     stop4;
//     stop5;
//     distance;
//     currentPageReference = null; 
//     urlStateParameters = null;

//     @track stopList = [];

//     @wire(CurrentPageReference)
//     getPageReferenceParameters(currentPageReference) {
//         this.busId = currentPageReference.state.Id;
//         this.sourceCity = currentPageReference.state.sc;
//         this.destinationCity = currentPageReference.state.ds;
//         this.distance = currentPageReference.state.distance;
//     }

//     seatSelect1 = seatSelect1;
//     seatSelect2 = seatSelect2;

//     handleAlreadyBooked() {
//         const event = new ShowToastEvent({
//             title: 'Failed!',
//             message: 'Selected Seat is already booked!',
//             variant: 'danger',
//         });
//         this.dispatchEvent(event);
//     }

// accountId;
// @track userWalletBalance;

// seats = [];
// sittingSeats = [];
// sleeperSeats = [];


//     seperateSeatsByType(){
//         this.sittingSeats = this.seats.filter(seat => seat.Seat_Type__c === 'Sitting');
//         this.sleeperSeats = this.seats.filter(seat => seat.Seat_Type__c === 'Sleeper');
//     }
// farePerKmForSittingSeat;
// farePerKmForSleeperSeat;
// busName;
// journeyDate;

//     connectedCallback(){
        
//         ViewSeatsController({busId : this.busId})
//         .then(response => {
//             console.log('Check');
//             this.seats = response;
//             this.seperateSeatsByType();
//             this.seats.forEach((item) => {
//                 console.log('Seat : ' + item.Name + ' | Status : '+ item.Status__c);
//             })
//         })
//         .catch(error => {
//             console.log(error);
//         })

//         FetchStopsOfSelectedBus({busId : this.busId})
//         .then(response => {
//             this.stopList = response;
//             this.stop1 = response[0].City__r.Name;
//             this.stop2 = response[1].City__r.Name;
//             this.stop3 = response[2].City__r.Name;
//             this.stop4 = response[3].City__r.Name;
//             this.stop5 = response[4].City__r.Name;

//         })
//         .catch(error => {
//             console.log(error);
//         })

//         BusData({busId : this.busId})
//             .then(response => {
//                 this.farePerKmForSittingSeat = response[0].Fair_Per_Kilometer_Sitting_Seat__c;
//                 this.farePerKmForSleeperSeat = response[0].Fair_Per_Kilometer_Sleeper_Seat__c;
//                 this.busName = response[0].Name;
//                 this.journeyDate = response[0].Journey_Date__c;
//             })
//             .catch(error => {
//                 console.log(error);
//             })
            
//         DistanceCalculator({sourceCity:this.sourceCity , destinationCity:this.destinationCity , busId:this.busId})
//         .then(response => {
//             this.totalDistance = response;
//         })
//         .catch(error => {
//             console.log(error);
//         })    

//         GetCurrentUserAccountId()
//         .then(response => {
//             this.accountId = response;
//             console.log(response);
//         })
//         .catch(error => {
//             console.log(error);
//         })
//     }

//     @track selectedSeats = [];
//     @track showSelectedSeatsName = [];
//     @track showSelectedSeatsFare = [];
//     @track TotalFare;

//     handleBookSeat(event){

//         const seatId = event.target.value;
//         const seatIndex = this.selectedSeats.indexOf(seatId);        
//         if(seatIndex === -1){
//             this.selectedSeats.push(seatId);  
//             console.log(seatId + ' : Selected');         
//         }else{
//             this.selectedSeats.splice(seatIndex, 1);           
//             console.log(seatId + ' : Removed');         
//         }    

//         ShowSelectedSeatsController({seatId : this.selectedSeats})
//         .then(response => {
//              this.showSelectedSeatsName = response;
//             })
//         .catch(error => { console.log(error); })

//         TotalFareCalculator({busId: this.busId, seatIds : this.selectedSeats , Distance:this.distance})
//         .then(response => {
//             this.TotalFare = response;
//         })
//         .catch(error => {
//             console.log(error);
//         })
//     }

//     handleClick() {
            
//             CheckSeatStatus({seatId : this.selectedSeats})
//             .then(response => {
//                 if(response === null){
//                     this.handleAlreadyBooked();
//                 }else if(response.length >= 1){

//                     const busId = this.busId;
//                     const sc = this.sourceCity;
//                     const ds = this.destinationCity;
//                     localStorage.setItem('selectedSeats', JSON.stringify(this.selectedSeats));
//                             this[NavigationMixin.Navigate]({
//                                 type: 'comm__namedPage',
//                                 attributes: {
//                                     name: 'payment__c',
//                                 },
//                                 state:{
//                                     accountId : this.accountId,
//                                     busId: busId,
//                                     sc:sc,
//                                     ds:ds,
//                                     fare:this.TotalFare,
//                                 }
//                             })
//                         }
//             })
//             .catch(error => {
//                 console.log(error);
//             })
//     }    
// }


// New Beginning.........................

import { LightningElement , track } from 'lwc';
// import GetSeatList from '@salesforce/apex/GetSeatList.returnSeatList';
import ShowSelectedSeatsController from '@salesforce/apex/ShowSelectedSeatsController.displaySelectedSeats';
import TotalFareCalculator from '@salesforce/apex/TotalFareCalculator.calculateTotalFare';
import CheckSeatStatus from '@salesforce/apex/CheckSeatStatus.checkSeatStatus';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class Seats extends NavigationMixin(LightningElement) {

    @track showSeats = false;
    @track isBookingDisabled = true;
    seats;

    rowOne = [];
    rowTwo = [];
    rowThree = [];
    rowFour = [];
    sleeperRow1 = [];
    sleeperRow2 = [];
    sleeperRow3 = [];
    sleeperRow4 = [];
    booked;
    styleColor;
    @track seatStatus;

    handleAlreadyBooked() {
        const event = new ShowToastEvent({
            title: 'Failed!',
            message: 'Selected Seat is already booked!',
            variant: 'danger',
        });
        this.dispatchEvent(event);
    }
    @track isFirstRender = true;

    // renderedCallback(){

    //     const busItineraryId = JSON.parse(localStorage.getItem('busItineraryId'));
    //     if(this.isFirstRender){
    //         GetSeatList({busItineraryId: busItineraryId})
    //         .then(response => {
                
    //             this.seats = response;

    //             for(let i = 0 ; i < response.length ; i++){
    //                 if(i < 24){
    //                     if(i < 6){
    //                         this.rowOne.push(this.seats[i]);
    //                     } else if(i < 12){
    //                         this.rowTwo.push(this.seats[i]);
    //                     } else if(i < 18){
    //                         this.rowThree.push(this.seats[i]);
    //                     } else {
    //                         this.rowFour.push(this.seats[i]);
    //                     }
    //                 }else if(i > 23 && i < response.length){
    //                     if(i < 27){
    //                         this.sleeperRow1.push(this.seats[i]);
    //                     } else if(i < 30){
    //                         this.sleeperRow2.push(this.seats[i]);
    //                     } else if(i < 33){
    //                         this.sleeperRow3.push(this.seats[i]);
    //                     } else {
    //                         this.sleeperRow4.push(this.seats[i]);
    //                     }
    //                 }
    //             }

    //             console.log(this.rowOne);
    //             console.log(this.rowTwo);
    //             console.log(this.rowThree);
    //             console.log(this.rowFour);

    //             console.log(this.sleeperRow1);
    //             console.log(this.sleeperRow2);
    //             console.log(this.sleeperRow3);
    //             console.log(this.sleeperRow4);
    //         })
    //         .catch(error => {
    //             console.log(error);
    //         })
    //         console.log('clicked');

    //         this.isFirstRender = false;
    //     } 
    // }

    handleViewSeats(){
            
        if(this.showSeats === false){
            this.showSeats = true;
            console.log(this.showSeats);
        }else if(this.showSeats === true){
            this.showSeats = false;
            console.log(this.showSeats);
        } 
    }

    @track selectedSeats = [];
    @track showSelectedSeatsName = [];
    @track totalFare;

    @track isPickupPointSelected = false;
    @track isDropPointSelected = false;

    handleClickSeat(event){

        const button = event.target;
        if(button.style.background === 'cornflowerblue'){
            button.style.background = '';
            button.style.border = '1px solid #05060e';
        }else{
            button.style.background = 'cornflowerblue';
            button.style.border = 'none';
        }


        const seatId = event.target.value;
        const seatIndex = this.selectedSeats.indexOf(seatId);        
        if(seatIndex === -1){
            this.selectedSeats.push(seatId);  
            console.log(seatId + ' : Selected');         
        }else{
            this.selectedSeats.splice(seatIndex, 1);           
            console.log(seatId + ' : Removed');         
        }


        console.log(this.selectedSeats);
        ShowSelectedSeatsController({seatIds : this.selectedSeats})
        .then(response => {
            if(response.length > 0){
                this.isBookingDisabled = false;
            }else if(response.length === 0){
                this.isBookingDisabled = true;
            }
                this.showSelectedSeatsName = response;
                console.log(response);
            })
        .catch(error => { console.log(error); })

        TotalFareCalculator({seatIds : this.selectedSeats})
        .then(response => {
            this.totalFare = response;
            console.log(response);
        })
        .catch(error => {
            console.log(error);
        })
    }

    handleBookSeat(){

        CheckSeatStatus({seatIds : this.selectedSeats})
        .then(response => {
            console.log(response);
            if(response === 'Selected seat is already booked'){
                this.handleAlreadyBooked();
            }else if(response === 'Booking can be done'){
                
                localStorage.setItem('selectedSeats', JSON.stringify(this.selectedSeats));
                this[NavigationMixin.Navigate]({
                type: 'comm__namedPage',
                attributes: {
                    name: 'Bus_Information__c'
                }
                })
            } 
        })
    }
}