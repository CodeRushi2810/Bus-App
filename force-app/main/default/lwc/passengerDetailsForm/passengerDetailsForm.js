/* eslint-disable no-useless-escape */
/* eslint-disable guard-for-in */
/* eslint-disable @lwc/lwc/no-async-operation */
import { LightningElement , track} from 'lwc';
import GetCityNames from '@salesforce/apex/GetCityNames.cityNames';
import SelectPickupPointController from '@salesforce/apex/SelectPickupPointController.pickupPoint';
import SelectDropPointController from '@salesforce/apex/SelectDropPointController.dropPoint';
import PassengerDetailsFormController from '@salesforce/apex/PassengerDetailsFormController.seatDetails';
import TotalFareCalculator from '@salesforce/apex/TotalFareCalculator.calculateTotalFare';
import SittingSeatFareCalculator from '@salesforce/apex/SittingSeatFareCalculator.calculateSittingFare';
import SleeperSeatFareCalculator from '@salesforce/apex/SleeperSeatFareCalculator.calculateSleeperFare';
import ReturnTotalSelectedSeatType from '@salesforce/apex/ReturnTotalSelectedSeatType.returnSeatTypeCount';
import DisplayBusDataAfterSeatSelection from '@salesforce/apex/DisplayBusDataAfterSeatSelection.busData';
import MergeDataWithTravellerController from '@salesforce/apex/MergeDataWithTravellerController.sendData';
import InsertTravellerController from '@salesforce/apex/InsertTravellerController.travellerDetails';
import GetCurrentUserAccountId from '@salesforce/apex/GetCurrentUserAccountId.getUserId';



import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class PassengerDetailsForm extends NavigationMixin(LightningElement) {



    @track selectedStep = 'Step1';
 
    selectStep1() {
        this.selectedStep = 'Step1';
    }
    selectStep2() {
        this.selectedStep = 'Step2';
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            }
            })
    }
    selectStep3() {
        this.selectedStep = 'Step3';
    }
    selectStep4() {
        this.selectedStep = 'Step4';
    }

    accountId;

    @track seatIds = [];
    @track totalSelectedSeatsCount;
    @track sourceCity;
    @track destinationCity;
    @track seatDetails = [];
    @track totalFare;
    @track sittingFare;
    @track sleeperFare;

    @track sittingSeatsCount;
    @track sleeperSeatsCount;

    @track pickupPointAddress = [];
    @track pickupPointCity = [];
    @track dropPointAddress = [];
    @track dropPointCity = [];

    @track busName;
    @track busType;
    @track seatDataToDisplayOnForm = [];

    myDataFromApex;
    @track dataToBeSent;

    @track insertedTravellersId = [];
    
    @track showSeat = false;
    @track showSeats = false;

    @track isbutton2Disabled = true;

    @track formArray = [];

    genderOptions = [
        {label: 'Male', value: 'Male'},
        {label: 'Female', value: 'Female'}
    ]

    handleFillAllFields() {
        const event = new ShowToastEvent({
            title: 'Failed!',
            message: 'Please fill all the fields!',
            variant: 'error',
        });
        this.dispatchEvent(event);
    }
    @track isFirstRender = true;
    
    @track pickupDateTime;
    @track pickupTime;
    @track pickupDate;

    @track dropDateTime;
    @track dropTime;
    @track dropDate;

    @track busNumber;
    @track busRating;
    @track busTotalRating;
    
    @track journeyDuration; 

    renderedCallback(){
        
        if(this.isFirstRender){

        const mySeats = JSON.parse(localStorage.getItem('selectedSeats'));
        const storedPickupPoint = localStorage.getItem('pickupPointId');
        const storedDropPoint = localStorage.getItem('dropPointId');

        const pickupTime = localStorage.getItem('pickupTime');
        this.pickupDateTime = pickupTime.replace(/[\"']/g, '');
        [this.pickupDate, this.pickupTime] = this.pickupDateTime.split(", ");
        

        const dropTime = localStorage.getItem('dropTime');
        this.dropDateTime = dropTime.replace(/[\"']/g, '');
        [this.dropDate, this.dropTime] = this.dropDateTime.split(", ");

        this.journeyDuration = localStorage.getItem('journeyDuration');
        this.journeyDuration = this.journeyDuration.replace(/[\"']/g, '');

        this.busNumber = localStorage.getItem('busNumber');
        this.busRating = localStorage.getItem('busRating');
        this.busTotalRating = localStorage.getItem('busTotalRating');
        this.busNumber = this.busNumber.replace(/[\"']/g, '');

        SelectPickupPointController({pickupPointId : storedPickupPoint})
        .then(response => {
            console.log(response);
            this.pickupPointAddress = response.Address__c;
            this.pickupPointCity = response.City__r.Name;
        })
        .catch(error => {
            console.log(error);
        })

        SelectDropPointController({dropPointId : storedDropPoint})
        .then(response => {
            console.log(response);
            this.dropPointAddress = response.Address__c;
            this.dropPointCity = response.City__r.Name;
        })
        .catch(error => {
            console.log(error);
        })


        GetCurrentUserAccountId()
        .then(response => {
            this.accountId = response;
            console.log('User Account Id : '+this.accountId);
            localStorage.setItem('accountId', JSON.stringify(this.accountId));
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
            
            PassengerDetailsFormController({selectedSeatsItineraryIds : mySeats})
            .then(response => {
                this.totalSelectedSeatsCount = response.length;
                if(response.length === 1){
                    this.showSeat = true;
                }else if(response.length > 1){
                    this.showSeats = true;
                }
                //console.log(response);
                this.seatDetails = response;
                this.seatDataToDisplayOnForm = response;

                for(let i = 0 ; i < this.totalSelectedSeatsCount ; i++){
                    this.formArray.push({id: i, name: '', age: null, gender: '', seatnumber: 'Seat '+this.seatDataToDisplayOnForm[i].Seat__r.Name+' | Type : '+this.seatDataToDisplayOnForm[i].Seat__r.Seat_Type__c});
                }                

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
                console.log('..............................');
                console.log(response);
                console.log('..............................');
            })
            .catch(error => {
                console.log(error);
            })

            const seatId = mySeats[0];
            DisplayBusDataAfterSeatSelection({seatId : seatId})
            .then(response => {
                //console.log(response);
                if (response != null) {
                    this.busName  = response[0].Name;
                    this.busType  = response[0].Type__c;
                }
            })
            .catch(error => {
                console.log(error);
            })

            MergeDataWithTravellerController({seatIds : mySeats})
            .then(response => {
                if(response.length !== 0) {
                    console.log('Seat Details for merging Received From Backend');
                    this.myDataFromApex = response;
                }
            })
            .catch(error => {
                console.log(error);
            })
            
        this.isFirstRender = false;
        }
    }

    @track allFieldsFilled = true;

    handleChange(event){
        const index = event.target.dataset.index;
        // console.log(index);
        const field = event.target.label.toLowerCase();
        // console.log(field);
        const value = event.target.value;
        // console.log(value);
        this.formArray[index][field] = value;

        this.allFieldsFilled = true;
        console.log(this.allFieldsFilled);
    }

    @track mergedData = {};

    handleSaveAll() {
        // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        // this.selectedStep = 'Step3';
        this.selectedStep = 'Step2';
        // ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
        console.log(this.allFieldsFilled);
        this.formArray.forEach(data => {
            if(!data.name || !data.age || !data.gender || data.age > 100 || data.age < 5){
                this.allFieldsFilled = false;
            }
        })

        if(this.allFieldsFilled === true){
            
            console.log(this.formArray);
            console.log(this.myDataFromApex);
            
            console.log('Merging Operation Started');
            let mergedDataWithIds = {};
            for (let id in this.myDataFromApex) {
                mergedDataWithIds[id] = {
                    seatDetails: this.myDataFromApex[id],
                    name: '',
                    age: '',
                    gender: ''
                };
            }
            for (let i = 0; i < this.formArray.length; i++) {
                let id = this.formArray[i].id;
                if (id in mergedDataWithIds) {
                    mergedDataWithIds[id].name = this.formArray[i].name;
                    mergedDataWithIds[id].age = this.formArray[i].age;
                    mergedDataWithIds[id].gender = this.formArray[i].gender;
                }
            }
            console.log('Merging Operation Completed');
            console.log(mergedDataWithIds);
            console.log('The type of Data after merging is :'+typeof(this.mergedDataWithIds));

            this.dataToBeSent = Array.from(Object.values(mergedDataWithIds));
            console.log('Data: ');
            console.log(this.dataToBeSent);
            console.log('The type of Data to be sent after conversion is :'+typeof(this.dataToBeSent));
        
            InsertTravellerController({mergedData : this.dataToBeSent})
            .then(response => {
                console.log(response);
                if(response !== null){
                    console.log('Inserted Travellers Id : ');
                    console.log(response);
                    this.insertedTravellersId = response;
                    localStorage.setItem('travellerIds', JSON.stringify(this.insertedTravellersId));
                    this[NavigationMixin.Navigate]({
                        type: 'comm__namedPage',
                        attributes: {
                            name: 'payment__c',
                        },
                    })
                }
            })
            .catch(error => {
                console.log(error);
            })
    }else{
            console.log('Required fields are missing');
            this.handleFillAllFields();
        }
    }
}
