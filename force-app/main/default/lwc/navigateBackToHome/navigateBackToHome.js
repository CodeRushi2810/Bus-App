import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';


export default class NavigateBackToHome extends NavigationMixin(LightningElement) {

    handleNavigateToHomePage(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            },
        })
    }
}