/* eslint-disable no-useless-escape */
/* eslint-disable no-else-return */
/* eslint-disable no-unused-expressions */
/* eslint-disable no-unused-vars */
/* eslint-disable no-restricted-globals */
/* eslint-disable @lwc/lwc/no-api-reassignments */

// import { LightningElement, track, api, wire } from 'lwc';
// import SearchBusesController from '@salesforce/apex/SearchBusesController.searchBus';
// import GetCityNames from '@salesforce/apex/GetCityNames.returnCityList';

// import { NavigationMixin } from 'lightning/navigation';
// import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// export default class SearchBar extends NavigationMixin(LightningElement) {

//     cityOptions = [];   

//     @wire(GetCityNames)
//     wiredCityNames({ error, data }) {
//         if (data) {
//             this.cityOptions = data.map(City__c => ({
//                 label: City__c.Name,
//                 value: City__c.Name
//             }));
//         } else if (error) {
//             console.error(error);
//         }
//     }

//     @track data = [];
//     @track cityOne = '';
//     @track cityTwo = '';
//     @track journeyDate;
//     @api temp = this.cityOne;
//     @track resultsVisiblity = false;
//     @api totalResults;

//     handleSelectSourceCity(event){
//         this.cityOne = event.detail.value;
//         console.log(this.cityOne);
//     }
//     handleSelectDestinationCity(event){
//         this.cityTwo = event.detail.value;
//         console.log(this.cityTwo);
//     }

//     today = new Date().toISOString().split('T')[0];    

//     handleChangeCityOne(event){
//         this.cityOne = event.target.value;
//     }

//     handleChangeCityTwo(event){
//         this.cityTwo = event.target.value;
//     }
//     handleChangeDate(event){
//         this.journeyDate = event.target.value;
//     }
//     handleSwap(){    
//         this.temp = this.cityOne;
//         this.cityOne = this.cityTwo;
//         this.cityTwo = this.temp;
//     }
//     handleFillAllFields() {
//         const event = new ShowToastEvent({
//             title: '',
//             message: 'Please fill all the fields',
//             variant: 'danger',
//         });
//         this.dispatchEvent(event);
//     }
//     handleNoBusAvailable() {
//         const event = new ShowToastEvent({
//             title: '',
//             message: 'No bus available for this route',
//             variant: 'danger',
//         });
//         this.dispatchEvent(event);
//     }
//     handleError() {
//         const event = new ShowToastEvent({
//             title: 'Error',
//             message: 'Something is wrong, try again later!!!',
//             variant: 'error',
//         });
//         this.dispatchEvent(event);
//     }

//     handleSubmit(){

//         if(this.cityOne === '' || this.cityTwo === ''){
//            this.handleFillAllFields();
//         }
//         else{
//             // SearchBusesController({cityOne: this.cityOne, cityTwo: this.cityTwo, journeyDate: this.journeyDate})
//             SearchBusesController({cityOne: this.cityOne, cityTwo: this.cityTwo})
//             .then(response => {
//                 this.totalResults = response.length;
//                 this.resultsVisiblity = true;
//                 this.data = response;
//                 console.log(response);
//             })
//             .catch(error => {
//                 console.log(error);
//             })
//         }
    
//     }


//    handleViewSeats(event){
    
//         const recordId = event.target.value;
//         const sc = this.cityOne;
//         const ds = this.cityTwo;

//         this[NavigationMixin.Navigate]({
//             type: 'comm__namedPage',
//             attributes: {
//                 name: 'Bus_Information__c'
//             },
//             state:{
//                 busId:recordId,
//                 sc:sc,
//                 ds:ds
//             }
//         })
//     }





// ................................................................New Beginning

import { LightningElement, track, api, wire } from 'lwc';
import SearchBusesController from '@salesforce/apex/SearchBusesController.searchBus';
import searchOptions from '@salesforce/apex/LiveSearchFunctionality.searchCities';

import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SearchBar extends NavigationMixin(LightningElement) {



searchResults1 = [];
@track sourceCity = ''
@track showTemplate1 = false;

handleFillAllDetails() {
  const event = new ShowToastEvent({
      message: 'Please provide all the details!',
      variant: 'danger',
  });
  this.dispatchEvent(event);
}
handleSelectAtleastOneFilter() {
  const event = new ShowToastEvent({
      message: 'Please select atleast one filter!',
      variant: 'danger',
  });
  this.dispatchEvent(event);
}

renderedCallback(){

  if(this.sourceCity === '' && this.sourceCity === ''){
    const sourceCity = localStorage.getItem('sourceCity');
    if(sourceCity){
      this.sourceCity = sourceCity.replace(/[\"']/g, '');
    }else {
      this.sourceCity = '';
    }

    const destinationCity = localStorage.getItem('destinationCity');
    if(destinationCity){
      this.destinationCity = destinationCity.replace(/[\"']/g, '');
    }else {
      this.destinationCity = '';
    }
  }
}

handleSearchSourceCity(event) {
  const searchTerm1 = event.target.value;
  if(searchTerm1 === ''){
    this.searchResults1 = [];
    this.showTemplate1 = false;
  }else{
    searchOptions({ searchTerm : searchTerm1 })
    .then(result => {
      if(result !== null){
        this.showTemplate1 = true;
        this.searchResults1 = result;
      } else if(result === null){
        this.showTemplate1 = false;
      }
    })
    .catch(error => {
        console.error(error);
    });
  }
}
handleInputCityOne(event){
  this.updatedRecordsWithTime = [];
  this.sourceCity = event.target.value;
  console.log('Source City : '+this.sourceCity);
  this.searchResults1 = [];
  this.showTemplate1 = false;
}

searchResults2 = [];
@track destinationCity = ''
@track showTemplate2 = false;
handleSearchDestinationCity(event) {
  const searchTerm2 = event.target.value;
  if(searchTerm2 === ''){
    this.searchResults2 = [];
    this.showTemplate2 = false;
  }else{
    searchOptions({ searchTerm : searchTerm2 })
    .then(result => {
      if(result !== null){
        this.showTemplate2 = true;
        this.searchResults2 = result;
      } else if(result === null){
        this.showTemplate2 = false;
      }
    })
    .catch(error => {
        console.error(error);
    });
  }
}
handleInputCityTwo(event){
  this.updatedRecordsWithTime = [];
  this.destinationCity = event.target.value;
  console.log('Destination City : '+this.destinationCity);
  this.searchResults2 = [];
  this.showTemplate2 = false;
}

@track todayDateClass = 'date';
@track tomorrowDateClass = 'date';
@track customDateClass = 'date';

@track journeyDate;


handleChangeJourneyDate(event){
  this.updatedRecordsWithTime = [];
  this.journeyDate = event.target.value;
  console.log(this.journeyDate);
}


@api temp;
handleSwap(){  
  console.log('clicked');  
  this.temp = this.sourceCity;
  this.sourceCity = this.destinationCity;
  this.destinationCity = this.temp;
}
@track records = [];
@track updatedRecordsWithTime = [];
@track backupSearchResult = [];
@track pickupPoints = [];
@track dropPoints = [];

@track results;
@track backupResults;
@track dataVisibility = false;
@track filtersVisibility = false;

@track resultsClass = 'resultsContainerFilterOff';
@track filterClass = 'filterContainerOff';

//Default Values in Filter
@track volvoButtonClass = 'unSelectedTypeButton';
@track deluxeButtonClass = 'unSelectedTypeButton';
@track semiDButtonClass = 'unSelectedTypeButton';

@track minValue = 100;
@track maxValue = 2000;

@track fourStarSelector = 'unSelectedStarButton';
@track threeStarSelector = 'unSelectedStarButton';
@track twoStarSelector = 'unSelectedStarButton';


//Selected Values in Filter
@track selectedValues = [];
@track selectedMaximumFare = null;
@track selectedMinimumStars = null;


  handleSearchBuses(){
    if(!this.sourceCity || !this.destinationCity || !this.journeyDate){
      this.handleFillAllDetails();
    }else{
      this.updatedRecordsWithTime = [];
      localStorage.setItem('sourceCity', JSON.stringify(this.sourceCity));
      localStorage.setItem('destinationCity', JSON.stringify(this.destinationCity));
        console.log(this.sourceCity + ' | '+ this.destinationCity);
        SearchBusesController({cityOne: this.sourceCity , cityTwo : this.destinationCity, journeyDate: this.journeyDate})
        .then(response => {
            this.results = response.length;
            this.dataVisibility = true;
            if(response.length > 0){
                console.log(response);
                this.records = response;
                this.backupResults = this.results;
    
                for(let i = 0 ; i < this.records.length ; i++){
                  let record = { ...this.records[i] };
    
                  const startTime = new Date(record.Start_Date_Time__c);
                  record.Start_Date_Time__c = new Intl.DateTimeFormat('en-US', {
                    hour: 'numeric',
                    minute: 'numeric',
                    hour12: true,
                    month: 'short',
                    day: 'numeric'
                  }).format(startTime);
    
                  const endTime = new Date(record.End_Date_Time__c);
                  record.End_Date_Time__c = new Intl.DateTimeFormat('en-US', {
                    hour: 'numeric',
                    minute: 'numeric',
                    hour12: true,
                    month: 'short',
                    day: 'numeric'
                  }).format(endTime);
                  this.updatedRecordsWithTime.push(record);
                }
    
                console.log(this.records);
                console.log(this.updatedRecordsWithTime);
                this.backupSearchResult = this.updatedRecordsWithTime;
                this.resultsVisibility = true;
            }else if(response.length === 0){
                this.resultsVisibility = false;
                this.filtersVisibility = false;
            }
        })
        .catch(error => {
            console.log(error);
        })
    }
  }

  showFilters(){
    if (this.resultsClass === 'resultsContainerFilterOff') {
      this.resultsClass = 'resultsContainerFilterOn';
      this.filterClass = 'filterContainerOn';
    }else{
      this.resultsClass = 'resultsContainerFilterOff';
      this.filterClass = 'filterContainerOff';
    }
  }

  handleSelectVolvo(){
    if(this.volvoButtonClass === 'unSelectedTypeButton'){
      this.volvoButtonClass = 'selectedTypeButton';
    }else{
      this.volvoButtonClass = 'unSelectedTypeButton';
    }
    this.handleSelectBusType("Volvo");
  }
  handleSelectDeluxe(){
    if(this.deluxeButtonClass === 'unSelectedTypeButton'){
      this.deluxeButtonClass = 'selectedTypeButton';
    }else{
      this.deluxeButtonClass = 'unSelectedTypeButton';
    }
    this.handleSelectBusType("Deluxe");
  }
  handleSelectSDeluxe(){
    if(this.semiDButtonClass === 'unSelectedTypeButton'){
      this.semiDButtonClass = 'selectedTypeButton';
    }else{
      this.semiDButtonClass = 'unSelectedTypeButton';
    }
    this.handleSelectBusType("Semi Deluxe");
  }  

  handleSelectBusType(value) {
    const index = this.selectedValues.indexOf(value);
    if (index === -1) {
        this.selectedValues = [...this.selectedValues, value];
    } else {
        this.selectedValues.splice(index, 1);
        this.selectedValues = [...this.selectedValues];
    }
  }

  handleRangeValueChange(event) {
    this.selectedMaximumFare = event.target.value;
  }

  @track counter = 0;

  handleSelectFourStars(){
    if(this.fourStarSelector === 'unSelectedStarButton'){
      this.counter = 0;
      this.fourStarSelector = 'selectedStarButton';
      this.threeStarSelector = 'unSelectedStarButton';
      this.twoStarSelector = 'unSelectedStarButton';
      this.selectedMinimumStars = 4;
      this.counter = this.counter+1;
    }else{
      this.fourStarSelector = 'unSelectedStarButton';
      this.threeStarSelector = 'unSelectedStarButton';
      this.twoStarSelector = 'unSelectedStarButton';
      this.counter = this.counter-1;
    }
  }
  handleSelectThreeStars(){
    if(this.threeStarSelector === 'unSelectedStarButton'){
      this.counter = 0;
      this.fourStarSelector = 'unSelectedStarButton';
      this.threeStarSelector = 'selectedStarButton';
      this.twoStarSelector = 'unSelectedStarButton';
      this.selectedMinimumStars = 3;
      this.counter = this.counter+1;
    }else{
      this.fourStarSelector = 'unSelectedStarButton';
      this.threeStarSelector = 'unSelectedStarButton';
      this.twoStarSelector = 'unSelectedStarButton';
      this.counter = this.counter-1;
    }
  }
  handleSelectTwoStars(){
    if(this.twoStarSelector === 'unSelectedStarButton'){
      this.counter = 0;
      this.fourStarSelector = 'unSelectedStarButton';
      this.threeStarSelector = 'unSelectedStarButton';
      this.twoStarSelector = 'selectedStarButton';
      this.selectedMinimumStars = 2;
      this.counter = this.counter+1;
    }else{
      this.fourStarSelector = 'unSelectedStarButton';
      this.threeStarSelector = 'unSelectedStarButton';
      this.twoStarSelector = 'unSelectedStarButton';
      this.counter = this.counter-1;
    }
  }


  handleResetValues(){
    this.selectedMaximumFare = null;
    this.selectedMinimumStars = null;

    this.selectedValues = [];

    this.volvoButtonClass = 'unSelectedTypeButton';
    this.deluxeButtonClass = 'unSelectedTypeButton';
    this.semiDButtonClass = 'unSelectedTypeButton';

    this.fourStarSelector = 'unSelectedStarButton';
    this.threeStarSelector = 'unSelectedStarButton';
    this.twoStarSelector = 'unSelectedStarButton';

    this.updatedRecordsWithTime = this.backupSearchResult;
    this.results = this.backupResults;
  }

  @track filteredBusRecords = [];

  @track isTypeFilterSelected = false;
  @track isPriceRangeFilterSelected = false;
  @track isRatingsFilterSelected = false;

  handleShowFilteredResults(){

    this.filteredBusRecords = this.updatedRecordsWithTime;

    this.updatedRecordsWithTime = this.backupSearchResult;
    this.results = this.backupResults;

    if(this.selectedValues.length !== 0 || this.selectedMaximumFare !== null || this.selectedMinimumStars !== null){
      if(this.selectedValues.length === 0){
        console.log("Selected Type (Nothing Selected): "+this.selectedValues);
        this.isTypeFilterSelected = false;
      }else{
        console.log(this.selectedValues);
        this.isTypeFilterSelected = true;
      }
  
      if(this.selectedMaximumFare === null){
        console.log('Max Fare is null : ' + this.selectedMaximumFare);
        this.isPriceRangeFilterSelected = false;
      }else{
        console.log('Max Fare : ' + this.selectedMaximumFare);
        this.isPriceRangeFilterSelected = true;
      }
  
      if(this.counter === 0){
        this.selectedMinimumStars = null;
        console.log('Selected Ratings : '+this.selectedMinimumStars);
        this.isRatingsFilterSelected = false;
      }else{
        console.log('Selected Ratings : '+this.selectedMinimumStars);
        this.isRatingsFilterSelected = true;
      }
  

      if(this.isTypeFilterSelected === true){
          this.filteredBusRecords = this.updatedRecordsWithTime.filter(bus => this.selectedValues.includes(bus.Bus_Name__r.Type__c));   
      }else{
        this.filteredBusRecords = this.backupSearchResult;
      }

      if(this.isPriceRangeFilterSelected === true){
        this.filteredBusRecords = this.filteredBusRecords.filter(bus => bus.Lowest_Fare__c <= this.selectedMaximumFare);
      }

      if(this.isRatingsFilterSelected === true){
        this.filteredBusRecords = this.filteredBusRecords.filter(bus => bus.Ratings__c >= this.selectedMinimumStars);  
      }

      this.results = this.filteredBusRecords.length;
      console.log(this.filteredBusRecords);
      this.updatedRecordsWithTime = this.filteredBusRecords;
    }else{
      this.handleSelectAtleastOneFilter();
    }   
  }
}

