/* eslint-disable no-dupe-class-members */
// import { LightningElement, track, wire } from 'lwc';
// import busImage from '@salesforce/resourceUrl/busImage';
// import { CurrentPageReference } from 'lightning/navigation';
// import { NavigationMixin } from 'lightning/navigation';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// import FetchSelectedBus from '@salesforce/apex/fetchSelectedBus.busList';
// import FetchStopsOfSelectedBus from '@salesforce/apex/FetchStopsOfSelectedBus.busStopList';
// import DistanceCalculator from '@salesforce/apex/DistanceCalculator.distanceCalculator';
// import PassengerReviews from '@salesforce/apex/DisplayReviews.showReviews';
// import GetAllSeatsStatus from '@salesforce/apex/GetAllSeatsStatus.seatStatus';

// export default class SelectedBus extends NavigationMixin(LightningElement) {

//     busId;
//     sourceCity;
//     destinationCity;
//     totalDistance;

//     pickupTime;
//     dropTime;

//     stop1;
//     arrival1;
//     utcTimeString;
//     departure1;
//     halt1;
//     localTime;

//     stop2;
//     arrival2;
//     departure2;
//     halt2;

//     stop3;
//     arrival3;
//     departure3;
//     halt3;

//     stop4;
//     arrival4;
//     departure4;
//     halt4;

//     stop5;
//     arrival5;

//     journeyDate;
//     bookingStatus;

//     busImage = busImage;

//     currentPageReference = null; 
//     urlStateParameters = null;

//     handleNoSeatsAvailable() {
//         const event = new ShowToastEvent({
//             title: 'Sorry',
//             message: 'Booking is closed!',
//             variant: 'error',
//         });
//         this.dispatchEvent(event);
//     }
//     handleSeatsFull(){
//         this.handleNoSeatsAvailable();
//     }


//     @wire(CurrentPageReference)
//     getPageReferenceParameters(currentPageReference) {
//         this.busId = currentPageReference.state.busId;
//         this.sourceCity = currentPageReference.state.sc;
//         this.destinationCity = currentPageReference.state.ds;
//     }

//     @track data = [];
//     @track stopList = [];
//     @track passengerReviews = [];

//      connectedCallback(){

//         GetAllSeatsStatus({busId : this.busId})
//         .then(response => {
//             if(response === 'Booking Open'){
//                 this.bookingStatus = true;
//             }else if(response === 'Booking Closed'){
//                 this.bookingStatus = false;
//             }
//         })

//         DistanceCalculator({sourceCity:this.sourceCity , destinationCity:this.destinationCity , busId:this.busId})
//         .then(response => {
//             this.totalDistance = response;
//         })
//         .catch(error => {
//             console.log(error);
//         })
        
//         FetchStopsOfSelectedBus({busId : this.busId})
//         .then(response => {

//             const hoursToAdd = 18;
//             this.stopList = response;
            
//             this.stop1 = response[0].City__r.Name;
//             this.arrival1 = response[0].Arrival_Time__c;
//             this.departure1 = response[0].Departure_Time__c;
//             this.halt1 = response[0].Halt_Duration__c;
//             const timeValueWithHoursAdded11 = this.arrival1 + (hoursToAdd * 60 * 60 * 1000);
//             const dateWithAdjustedTime11 = new Date(timeValueWithHoursAdded11);
//             this.arrival1 = dateWithAdjustedTime11.toLocaleTimeString();
//             const timeValueWithHoursAdded12 = this.departure1 + (hoursToAdd * 60 * 60 * 1000);
//             const dateWithAdjustedTime12 = new Date(timeValueWithHoursAdded12);
//             this.departure1 = dateWithAdjustedTime12.toLocaleTimeString();


//             this.stop2 = response[1].City__r.Name;
//             this.arrival2 = response[1].Arrival_Time__c;
//             this.departure2 = response[1].Departure_Time__c;
//             this.halt2 = response[1].Halt_Duration__c;
//             const timeValueWithHoursAdded21 = this.arrival2 + (hoursToAdd * 60 * 60 * 1000);
//             const dateWithAdjustedTime21 = new Date(timeValueWithHoursAdded21);
//             this.arrival2 = dateWithAdjustedTime21.toLocaleTimeString();
//             const timeValueWithHoursAdded22 = this.departure2 + (hoursToAdd * 60 * 60 * 1000);
//             const dateWithAdjustedTime22 = new Date(timeValueWithHoursAdded22);
//             this.departure2 = dateWithAdjustedTime22.toLocaleTimeString();


//             this.stop3 = response[2].City__r.Name;
//             this.arrival3 = response[2].Arrival_Time__c;
//             this.departure3 = response[2].Departure_Time__c;
//             this.halt3 = response[2].Halt_Duration__c;
//             const timeValueWithHoursAdded31 = this.arrival3 + (hoursToAdd * 60 * 60 * 1000);
//             const dateWithAdjustedTime31 = new Date(timeValueWithHoursAdded31);
//             this.arrival3 = dateWithAdjustedTime31.toLocaleTimeString();
//             const timeValueWithHoursAdded32 = this.departure3 + (hoursToAdd * 60 * 60 * 1000);
//             const dateWithAdjustedTime32 = new Date(timeValueWithHoursAdded32);
//             this.departure3 = dateWithAdjustedTime32.toLocaleTimeString();


//             this.stop4 = response[3].City__r.Name;
//             this.arrival4 = response[3].Arrival_Time__c;
//             this.departure4 = response[3].Departure_Time__c;
//             this.halt4 = response[3].Halt_Duration__c;
//             const timeValueWithHoursAdded41 = this.arrival4 + (hoursToAdd * 60 * 60 * 1000);
//             const dateWithAdjustedTime41 = new Date(timeValueWithHoursAdded41);
//             this.arrival4 = dateWithAdjustedTime41.toLocaleTimeString();
//             const timeValueWithHoursAdded42 = this.departure4 + (hoursToAdd * 60 * 60 * 1000);
//             const dateWithAdjustedTime42 = new Date(timeValueWithHoursAdded42);
//             this.departure4 = dateWithAdjustedTime42.toLocaleTimeString();

//             this.stop5 = response[4].City__r.Name;
//             this.arrival5 = response[4].Arrival_Time__c;
//             const timeValueWithHoursAdded51 = this.arrival5 + (hoursToAdd * 60 * 60 * 1000);
//             const dateWithAdjustedTime51 = new Date(timeValueWithHoursAdded51);
//             this.arrival5 = dateWithAdjustedTime51.toLocaleTimeString();

//             if(this.stop1 === this.sourceCity){
//                 this.pickupTime = this.arrival1;
//             }else if(this.stop2 === this.sourceCity){
//                 this.pickupTime = this.arrival2;
//             }else if(this.stop3 === this.sourceCity){
//                 this.pickupTime = this.arrival3;
//             }else if(this.stop4 === this.sourceCity){
//                 this.pickupTime = this.arrival4;
//             }else if(this.stop5 === this.sourceCity){
//                 this.pickupTime = this.arrival5;
//             }
    
//             if(this.stop1 === this.destinationCity){
//                 this.dropTime = this.departure1;
//             }else if(this.stop2 === this.destinationCity){
//                 this.dropTime = this.departure2;
//             }else if(this.stop3 === this.destinationCity){
//                 this.dropTime = this.departure3;
//             }else if(this.stop4 === this.destinationCity){
//                 this.dropTime = this.departure4;
//             }else if(this.stop5 === this.destinationCity){
//                 this.dropTime = this.departure5;
//             }    
//         })
//         .catch(error => {
//             console.log(error);
//         })     

//         FetchSelectedBus({busId:this.busId , sourceCity:this.sourceCity , destinationCity:this.destinationCity})
//         .then(response => {
//             if(response != null){
//                 this.data = response;
//                 this.journeyDate = response[0].Journey_Date__c;
//             }
//         })
//         .catch(error => {
//             console.log(error);
//         })   
        
//         PassengerReviews({busId:this.busId})
//         .then(response => {
//             this.passengerReviews = response;
//             console.log(response);
//         })
//         .catch(error => {
//             console.log(error);
//         })
//     }

//     @track information = true;
//     @track reviews = false;
//     @track contact = false;
//     button1Class = 'one';
//     button2Class = 'two';
//     button3Class = 'two';

//     handleShowInfo(){
//         this.button1Class = 'one';
//         this.button2Class = 'two';
//         this.button3Class = 'two';
//         this.information = true;
//         this.reviews = false;
//         this.contact = false;
//     }
//     handleShowReviews(){
//         this.button1Class = 'two';
//         this.button2Class = 'one';
//         this.button3Class = 'two';
//         this.information = false;
//         this.reviews = true;
//         this.contact = false;
//     }
//     handleShowContact(){
//         this.button1Class = 'two';
//         this.button2Class = 'two';
//         this.button3Class = 'one';
//         this.information = false;
//         this.reviews = false;
//         this.contact = true;
//     }


//     handleViewSeats(){
//         const busId = this.busId;
//         const sc = this.sourceCity;
//         const ds = this.destinationCity;
//         const distance = this.totalDistance;
//         this[NavigationMixin.Navigate]({
//             type: 'comm__namedPage',
//             attributes: {
//                 name: 'seats__c'
//             },
//             state:{
//                 Id:busId,
//                 sc:sc,
//                 ds:ds,
//                 distance:distance
//             }
//         })
//     }
// }




// New Beginning.........................................................

import { LightningElement, track, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import GetPickupPointsController from '@salesforce/apex/GetPickupPointsController.pickupPoints';
import GetDropPointsController from '@salesforce/apex/GetDropPointsController.dropPoints';
import SelectPickupPointController from '@salesforce/apex/SelectPickupPointController.pickupPoint';
import SelectDropPointController from '@salesforce/apex/SelectDropPointController.dropPoint';
import GetSeatList from '@salesforce/apex/GetSeatList.returnSeatList';
import ShowSelectedSeatsController from '@salesforce/apex/ShowSelectedSeatsController.displaySelectedSeats';
import TotalFareCalculator from '@salesforce/apex/TotalFareCalculator.calculateTotalFare';
import CheckSeatStatus from '@salesforce/apex/CheckSeatStatus.checkSeatStatus';
import PassengerReviews from '@salesforce/apex/DisplayReviews.showReviews';


import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class SelectedBus extends NavigationMixin(LightningElement) {

    @api record;
    @api sourcecity;
    @api destinationcity;
    @api seatsleft;
    @track bookingClosed = true;

    @track pickupPoints = [];
    @track dropPoints = [];

    @track resultsVisibility = false;
    @track policies = false;
    @track amenities = false;
    @track reviews = false;



    // Test

    @track isBookingDisabled = true;
    seats;

    @track rowOne = [];
    @track rowTwo = [];
    @track rowThree = [];
    @track rowFour = [];
    @track sleeperRow1 = [];
    @track sleeperRow2 = [];
    @track sleeperRow3 = [];
    @track sleeperRow4 = [];
    @track booked;
    @track styleColor;
    @track seatStatus;

    handleAlreadyBooked() {
        const event = new ShowToastEvent({
            title: 'Failed!',
            message: 'Selected Seat is already booked!',
            variant: 'danger',
        });
        this.dispatchEvent(event);
    }
    handleSelectPoints() {
        const event = new ShowToastEvent({
            message: 'Please select Points',
            variant: 'danger',
        });
        this.dispatchEvent(event);
    }

    policyButton = 'dropdownButtonsInActive';
    amenityButton = 'dropdownButtonsInActive';
    reviewButton = 'dropdownButtonsInActive';

    handleShowPolicies(){
        if(this.policies === false){
            this.policies = true;
            this.amenities = false;
            this.reviews = false;
    
            this.policyButton = 'dropdownButtonsActive';
            this.amenityButton = 'dropdownButtonsInActive';
            this.reviewButton = 'dropdownButtonsInActive';
    
        }else if(this.policies === true){
            this.policies = false;
            this.amenities = false;
            this.reviews = false;
    
            this.policyButton = 'dropdownButtonsInActive';
            this.amenityButton = 'dropdownButtonsInActive';
            this.reviewButton = 'dropdownButtonsInActive';
        }
    }
    handleShowAmenities(){
        if(this.amenities === false){
            this.policies = false;
            this.amenities = true;
            this.reviews = false;
    
            this.policyButton = 'dropdownButtonsInActive';
            this.amenityButton = 'dropdownButtonsActive';
            this.reviewButton = 'dropdownButtonsInActive';
    
        }else if(this.amenities === true){
            this.policies = false;
            this.amenities = false;
            this.reviews = false;
    
            this.policyButton = 'dropdownButtonsInActive';
            this.amenityButton = 'dropdownButtonsInActive';
            this.reviewButton = 'dropdownButtonsInActive';
        }
    }
    @track passengerReviews = [];
    @track isFirstCall = true;
    handleShowReviews(event){
        if(this.isFirstCall === true){
            const busId = event.target.value;
            console.log(busId);
            PassengerReviews({busId : busId})
            .then( response => {
                console.log(response); 
                this.passengerReviews = response;
            } )
            this.isFirstCall = false;
        }

        if(this.reviews === false){
            this.policies = false;
            this.amenities = false;
            this.reviews = true;
    
            this.policyButton = 'dropdownButtonsInActive';
            this.amenityButton = 'dropdownButtonsInActive';
            this.reviewButton = 'dropdownButtonsActive';
    
        }else if(this.reviews === true){
            this.policies = false;
            this.amenities = false;
            this.reviews = false;
    
            this.policyButton = 'dropdownButtonsInActive';
            this.amenityButton = 'dropdownButtonsInActive';
            this.reviewButton = 'dropdownButtonsInActive';
        }
    }

    @track cancellation = true;
    @track luggage = false;
    @track liqour = false;
    @track pickupTime = false;

    handlePolicyCancellation(){
        this.cancellation = true;
        this.luggage = false;
        this.liqour = false;
        this.pickupTime = false
    }
    handlePolicyLuggage(){
        this.cancellation = false;
        this.luggage = true;
        this.liqour = false;
        this.pickupTime = false
    }
    handlePolicyLiqour(){
        this.cancellation = false;
        this.luggage = false;
        this.liqour = true;
        this.pickupTime = false
    }
    handlePolicyPickupTime(){
        this.cancellation = false;
        this.luggage = false;
        this.liqour = false;
        this.pickupTime = true;
    }

    @track displayLocations = false;
    @track busItineraryId;

    @track pickupTime;
    @track dropTime;
    @track journeyDuration;
    @track busNumber;
    @track busRating;
    @track busTotalRating;
    @track isThisFirstCall = true;

    handleShowPickupPoints(event){
    
        this.pickupTime = this.record.Start_Date_Time__c;
        this.dropTime = this.record.End_Date_Time__c;
        this.journeyDuration = this.record.Journey_Duration__c;
        this.busNumber = this.record.Bus_Name__r.Bus_Number__c;
        this.busRating = this.record.Ratings__c;
        this.busTotalRating = this.record.Total_Ratings__c;

        localStorage.setItem('pickupTime', JSON.stringify(this.pickupTime));
        localStorage.setItem('dropTime', JSON.stringify(this.dropTime));
        localStorage.setItem('journeyDuration', JSON.stringify(this.journeyDuration));
        localStorage.setItem('busNumber', JSON.stringify(this.busNumber));
        localStorage.setItem('busRating', JSON.stringify(this.busRating));
        localStorage.setItem('busTotalRating', JSON.stringify(this.busTotalRating));

        console.log('Seats Left : '+this.seatsleft);
        if(this.seatsleft === 0){
            this.bookingClosed = true;
        }else{
            this.bookingClosed = false;
        }
        
        if(this.displayLocations === false){
            this.displayLocations = true;
        }else if(this.displayLocations === true){
            this.displayLocations = false;
        }

        console.log(this.sourcecity);
        console.log(this.destinationcity);
        console.log(event.target.value);
        this.busItineraryId = event.target.value;

        localStorage.setItem('busItineraryId', JSON.stringify(this.busItineraryId));

        if(this.isThisFirstCall === true){
            GetSeatList({busItineraryId: this.busItineraryId})
                .then(response => {
                    
                    this.seats = response;

                    for(let i = 0 ; i < response.length ; i++){
                        if(i < 24){
                            if(i < 6){
                                this.rowOne.push(this.seats[i]);
                            } else if(i < 12){
                                this.rowTwo.push(this.seats[i]);
                            } else if(i < 18){
                                this.rowThree.push(this.seats[i]);
                            } else {
                                this.rowFour.push(this.seats[i]);
                            }
                        }else if(i > 23 && i < response.length){
                            if(i < 27){
                                this.sleeperRow1.push(this.seats[i]);
                            } else if(i < 30){
                                this.sleeperRow2.push(this.seats[i]);
                            } else if(i < 33){
                                this.sleeperRow3.push(this.seats[i]);
                            } else {
                                this.sleeperRow4.push(this.seats[i]);
                            }
                        }
                    }

                    console.log(this.rowOne);
                    console.log(this.rowTwo);
                    console.log(this.rowThree);
                    console.log(this.rowFour);

                    console.log(this.sleeperRow1);
                    console.log(this.sleeperRow2);
                    console.log(this.sleeperRow3);
                    console.log(this.sleeperRow4);
                })
                .catch(error => {
                    console.log(error);
                })

            GetPickupPointsController({busItineraryId : this.busItineraryId , cityName : this.sourcecity})
            .then(response => {
                console.log('Pickup Points');
                console.log(response);
                this.pickupPoints = response;
            })
            .catch(error => {
                console.log(error);
            })

            GetDropPointsController({busItineraryId : this.busItineraryId , cityName : this.destinationcity})
            .then(response => {
                console.log('Drop Points');
                console.log(response);
                this.dropPoints = response;
            })
            .catch(error => {
                console.log(error);
            })    
        }    
        this.isThisFirstCall = false;
    }

    @track pickupPoint;
    @track dropPoint;

    @track pickupPointAddress = [];
    @track pickupPointCity = [];
    
    @track dropPointAddress = [];
    @track dropPointCity = [];

    @track isPickupPointSelected = false;
    @track isDropPointSelected = false;
    
    handleSelectPickupPoint(event){

        this.isPickupPointSelected = true;
        this.pickupPoint = event.target.value;
        console.log(this.pickupPoint);
        SelectPickupPointController({pickupPointId : this.pickupPoint})
        .then(response => {
            console.log(response);
            this.pickupPointAddress = response.Address__c;
            this.pickupPointCity = response.City__r.Name;
        })
        .catch(error => {
            console.log(error);
        })

        const storedPickupPoint = localStorage.getItem('pickupPointId');

        if(storedPickupPoint !== event.target.value){
            localStorage.setItem('pickupPointId', this.pickupPoint);
        }
    }
    handleSelectDropPoint(event){

        this.isDropPointSelected = true;
        this.dropPoint = event.target.value;
        console.log(this.dropPoint);
        SelectDropPointController({dropPointId : this.dropPoint})
        .then(response => {
            console.log(response);
            this.dropPointAddress = response.Address__c;
            this.dropPointCity = response.City__r.Name;
        })
        .catch(error => {
            console.log(error);
        })

        const storedDropPoint = localStorage.getItem('dropPointId');

        if(storedDropPoint !== event.target.value){
            localStorage.setItem('dropPointId', this.dropPoint);
        }
    }

    @track selectedSeats = [];
    @track showSelectedSeatsName = [];
    @track totalFare;

    handleClickSeat(event){

        console.log(event.target.value);
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

        if(this.isPickupPointSelected === true && this.isDropPointSelected === true){
            
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
        }else{
            this.handleSelectPoints();
        }
    }
}