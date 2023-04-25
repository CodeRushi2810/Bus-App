import { LightningElement, track, api } from 'lwc';
import UnicornBuses from '@salesforce/apex/UnicornBuses.buslist';
import { NavigationMixin } from 'lightning/navigation';

export default class Header extends NavigationMixin(LightningElement) {

    @track data = [];
    @api recordId;
    @api cityOne = '';
    @api cityTwo = '';
    @track journeyDate;
    @track totalResults;

    connectedCallback(){
        
        UnicornBuses()
        .then(response => {
            this.data = response;
        })
        .catch(error => {
            window.alert("Error occured :" +error);
        })
    }

    handleChangeCityOne(event){
        this.cityOne = event.target.value;
    }

    handleChangeCityTwo(event){
        this.cityTwo = event.target.value;
    }
    handleChangeDate(event){
        this.journeyDate = event.target.value;
    }

    handleSubmit(){

        if(this.cityOne == '' || this.cityTwo == '' || !this.journeyDate){
            window.alert("Please fill all the fields");
        }

        else{
            UnicornBuses({pickUp:this.cityOne , destination:this.cityTwo , journeyDate:this.journeyDate})
            .then(response => {
                this.data = response;
                this.totalResults = this.data.length;
                if(this.data.length == 0){
                    window.alert('No bus available for this route');
                }
            })
            .catch(error => {
                window.alert('Error occurred while fetching data'+error);
            })
        }
    }


   handleViewSeats(event){
        
        const recordId = event.target.value;

        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Bus_Information__c'
            },
            state:{
                busId:recordId
            }
        })
    }
    
}