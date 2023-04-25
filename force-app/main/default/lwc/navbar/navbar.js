import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class Navbar extends NavigationMixin(LightningElement) {
    
    navigateToHome(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            }
        })
    }
    
    navigateToBuses(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Bus__c'
            }
        })
    }

    navigateToContact(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Contact__c'
            }
        })
    }

    navigateToLogin(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Custom_Login__c'
            }
        })
    }
    
    navigateToRegister(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Custom_Register__c'
            }
      });
    }
}