import { LightningElement, track} from 'lwc';
import searchOptions from '@salesforce/apex/LiveSearchFunctionality.searchCities';

export default class SeatRowOne extends LightningElement {
  searchResults = [];
  @track sourceCity = ''
  @track showTemplate = false;
    handleSearch(event) {
        const searchTerm = event.target.value;
        if(searchTerm === ''){
          this.searchResults = [];
          this.showTemplate = false;
        }else{
          searchOptions({ searchTerm })
            .then(result => {
              if(result !== null){
                this.showTemplate = true;
                this.searchResults = result;
              } else if(result === null){
                this.showTemplate = false;
              }
            })
            .catch(error => {
                console.error(error);
            });
        }
    }
    handleInputCityOne(event){
      this.sourceCity = event.target.value;
      console.log('Selected City : '+this.sourceCity);
      this.searchResults = [];
      this.showTemplate = false;
    }
}
  
