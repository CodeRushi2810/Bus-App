import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import LoginDetails from '@salesforce/apex/loginValidator.loginInfo';

import registerImg2 from '@salesforce/resourceUrl/busImageRegister';


export default class CustomLogin extends NavigationMixin(LightningElement) {

    @track data = [];

    registerImg2 = registerImg2;

    @track email;
    @track password;

    handleChangeEmail(event){
        this.email = event.target.value;
    }

    handleChangePassword(event){
        this.password = event.target.value;
    }

    handleLogin(){

        LoginDetails({email:this.email , password:this.password})
        .then(response => {
            if(response != null){
                window.alert("Logged In Successfully");
                this[NavigationMixin.Navigate]({
                    type: 'comm__namedPage',
                    attributes: {
                        name: 'Home'
                    },
                })
            }
            else{
                window.alert('Incorrect Credentials');
            }
        })
        .catch(error => {
            window.alert("Error Occured : "+error);
        }) 
    }   

}