/* eslint-disable eqeqeq */
/* eslint-disable no-alert */
import { LightningElement, track } from 'lwc';
import CustomSelfRegisterClass from '@salesforce/apex/CustomSelfRegisterClass.createAccount';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import registerImg2 from '@salesforce/resourceUrl/busImageRegister';

export default class PersonRegister extends NavigationMixin(LightningElement) {
registerImg2 = registerImg2;
@track firstName;
@track lastName;
@track email;

handleChangefirstName(event){
    this.firstName = event.target.value;
}
handleChangeLastName(event){
    this.lastName = event.target.value;
}
handleChangeEmail(event){
    this.email = event.target.value;
}
handleSuccess() {
    const event = new ShowToastEvent({
        title: 'Success!',
        message: 'Registered Successfully',
        variant: 'success',
    });
    this.dispatchEvent(event);
}
handleFail() {
    const event = new ShowToastEvent({
        title: 'Failed!',
        message: 'Registeration Failed',
        variant: 'error',
    });
    this.dispatchEvent(event);
}
handleFillAllFields() {
    const event = new ShowToastEvent({
        title: 'Error!',
        message: 'Please fill all the fields',
        variant: 'danger',
    });
    this.dispatchEvent(event);
}
handleEmailAlreadyRegistered() {
    const event = new ShowToastEvent({
        title: 'Failed!',
        message: 'Email is already registered',
        variant: 'error',
    });
    this.dispatchEvent(event);
}
    handleRegister() {    
                if(this.firstName != '' && this.lastName != '' && this.email != ''){
                console.log(this.firstName + ' ' + this.lastName + ' ' + this.email);

                CustomSelfRegisterClass({firstName: this.firstName , lastName:this.lastName , email:this.email})
                    .then(response => {
                        console.log(response);
                        if(response === 'Registered Successfully'){
                            console.log(response);
                            this.handleSuccess();
                            this.firstName = '';
                            this.lastName = '';
                            this.email = '';
                        }
                        else if(response === 'Registeration Failed' || response === 'Error occured while Registration!'){
                            console.log(response);
                            this.handleFail();
                            this.firstName = '';
                            this.lastName = '';
                            this.email = '';
                        }
                        else if(response === 'Email already exists!!!'){
                            console.log(response);
                            this.handleEmailAlreadyRegistered();
                            this.firstName = '';
                            this.lastName = '';
                            this.email = '';
                        }                     
                    })
                    .catch(error => {
                    window.alert("We are having some trouble at the moment...");
                    console.log(error);
                    })
            }else{
                this.handleFillAllFields();
            }
    }
}