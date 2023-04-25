import { LightningElement } from 'lwc';

import bookImage from '@salesforce/resourceUrl/bookImage';
import payImage from '@salesforce/resourceUrl/payImage';
import travelImage from '@salesforce/resourceUrl/travelImage';

import { NavigationMixin } from 'lightning/navigation';


export default class Banner extends NavigationMixin(LightningElement) {

     bookImage  = bookImage;
     payImage = payImage;
     travelImage = travelImage;

     handleNavigateToBookingPage(){
          this[NavigationMixin.Navigate]({
          type: 'comm__namedPage',
          attributes: {
               name: 'Book_Online_Info__c'
          }
          })
     }
     handleNavigateToPaymentPage(){
          this[NavigationMixin.Navigate]({
          type: 'comm__namedPage',
          attributes: {
               name: 'Payment_Info__c'
          }
          })
     }
     handleNavigateToTravelPage(){
          this[NavigationMixin.Navigate]({
          type: 'comm__namedPage',
          attributes: {
               name: 'Travel_Info__c'
          }
          })
     }
}