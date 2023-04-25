/* eslint-disable no-unused-vars */
import { LightningElement , track} from 'lwc';
import DisplayPastJourneys from '@salesforce/apex/DisplayPastJourneys.pastJourneyList';
import DisplayUpcomingJourneys from '@salesforce/apex/DisplayUpcomingJourneys.upcomingJourneyList';

export default class PassengerJourneyHistory extends LightningElement {

    @track pastJourneys = [];
    @track updatedPastJourney = [];
    
    @track upcomingJourneys = [];
    @track updatedUpcomingJourney = [];

    @track pastJourneyAvailable = false;
    @track upcomingJourneyAvailable = false;
    @track isThereAnyHistory = false;
        
    connectedCallback(){
        DisplayPastJourneys()
        .then(response => {
            if(response !== null){
                this.pastJourneyAvailable = true;
                this.pastJourneys = response;
                for(let i = 0 ; i < this.pastJourneys.length ; i++){
                    let pastJourney = { ...this.pastJourneys[i] };
    
                    const startTime = new Date(pastJourney.Start_Time__c);
                    pastJourney.Start_Time__c = new Intl.DateTimeFormat('en-US', {
                    hour: 'numeric',
                    minute: 'numeric',
                    hour12: true,
                    month: 'short',
                    day: 'numeric'
                    }).format(startTime);
    
                    const endTime = new Date(pastJourney.End_Time__c);
                    pastJourney.End_Time__c = new Intl.DateTimeFormat('en-US', {
                    hour: 'numeric',
                    minute: 'numeric',
                    hour12: true,
                    month: 'short',
                    day: 'numeric'
                    }).format(endTime);
  
                    this.updatedPastJourney.push(pastJourney);
                }
                console.log(this.updatedPastJourney);
            }
            else{
                this.pastJourneyAvailable = false;
            }
            console.log('Past journey Available : '+ this.pastJourneyAvailable);
        })        
        .catch(error => {
            console.log(error);
        })


        DisplayUpcomingJourneys()
        .then(response => {
            if(response !== null){
                this.upcomingJourneyAvailable = true;
                this.upcomingJourneys = response;
                for(let i = 0 ; i < this.upcomingJourneys.length ; i++){
                    let upcomingJourney = { ...this.upcomingJourneys[i] };
        
                    const startTime = new Date(upcomingJourney.Start_Time__c);
                    upcomingJourney.Start_Time__c = new Intl.DateTimeFormat('en-US', {
                        hour: 'numeric',
                        minute: 'numeric',
                        hour12: true,
                        month: 'short',
                        day: 'numeric'
                    }).format(startTime);
        
                    const endTime = new Date(upcomingJourney.End_Time__c);
                    upcomingJourney.End_Time__c = new Intl.DateTimeFormat('en-US', {
                        hour: 'numeric',
                        minute: 'numeric',
                        hour12: true,
                        month: 'short',
                        day: 'numeric'
                    }).format(endTime);
        
                    this.updatedUpcomingJourney.push(upcomingJourney);
                }

                console.log(this.updatedUpcomingJourney);
            }else{
                this.upcomingJourneyAvailable = false;
            }
            console.log('Upcoming Journey Available : ' + this.upcomingJourneyAvailable);
            if( (this.upcomingJourneyAvailable === true) || (this.pastJourneyAvailable === true) ){
                this.isThereAnyHistory = true;
            }else{
                this.isThereAnyHistory = false;
            }
            console.log('Any Journey Available : ' + this.isThereAnyHistory);
        })        
        .catch(error => {
            console.log(error);
        })
    }
}

