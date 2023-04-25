import { LightningElement } from 'lwc';
import { createRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation';

import USER_OBJECT from '@salesforce/schema/custom_User__c';

import userName_field from '@salesforce/schema/custom_User__c.Name'
import email_field from '@salesforce/schema/custom_User__c.Email__c'
import password_field from '@salesforce/schema/custom_User__c.Password__c'

import registerImg2 from '@salesforce/resourceUrl/busImageRegister';


export default class CustomRegister extends NavigationMixin(LightningElement) {

    registerImg2 = registerImg2;

    userName;
    email;
    password;

    handleChangeEmail(event){
        this.email = event.target.value;
    }

    handleChangeUserName(event){
        this.userName = event.target.value;
    }

    handleChangePassword(event){
        this.password = event.target.value;
    }

    handleNavigateToLogin(){
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Custom_Login__c'
            },
        })
    }


    handleRegister(

    ) {       

            const fields = {};

            fields[userName_field.fieldApiName] = this.userName;
            fields[email_field.fieldApiName] = this.email;
            fields[password_field.fieldApiName] = this.password;

            const recordInput = { apiName: USER_OBJECT.objectApiName, fields };
            createRecord(recordInput)
            .then( () => {
                window.alert("Registered Successfully");
                this[NavigationMixin.Navigate]({
                    type: 'comm__namedPage',
                    attributes: {
                        name: 'Custom_Login__c'
                    },
                })
            })
            .catch(error => {
                window.alert('Registration Failed! Error : '+error);
            })
        
    }
   

}