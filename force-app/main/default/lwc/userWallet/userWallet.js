/* eslint-disable @lwc/lwc/no-async-operation */
/* eslint-disable radix */
import { LightningElement, track , wire} from 'lwc';
import getWalletAmount from '@salesforce/apex/getWalletAmount.walletBalance';
import AddMoneyToWallet from '@salesforce/apex/AddMoneyToWallet.updateBalance';
import GetCurrentUserAccountId from '@salesforce/apex/GetCurrentUserAccountId.getUserId';
import USER_ID from '@salesforce/user/Id';
import USER_NAME_FIELD from '@salesforce/schema/User.Name';
import USER_NAME_EMAIL from '@salesforce/schema/User.Email';
import { getRecord } from 'lightning/uiRecordApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class UserWallet extends LightningElement {

    @track userBalance;
    @track amountToBeAdded = 1000;
    @track isItFirstRender = true;
    @track accountId;

    renderedCallback(){
        if(this.isItFirstRender === true){

        GetCurrentUserAccountId()
        .then(response => {
            this.accountId = response;
            console.log('User Account Id : '+this.accountId);
        })
        .catch(error => {
            console.log(error);
        })

        setTimeout( () => {
            getWalletAmount({userId : this.accountId})
            .then(response => {
                this.userBalance = response;
                console.log(response);
            })
        },1000)
        this.isItFirstRender = false;
    }
}
    userName;
    userEmail;

    handleDecreseAmount(){
        if(this.amountToBeAdded > 1000){
            this.amountToBeAdded = this.amountToBeAdded - 1000;
        }else{
            if(this.amountToBeAdded !== 1000){
                this.amountToBeAdded = 1000;
            }
        }
        console.log(this.amountToBeAdded);
    }
    handleInceaseAmount(){
        this.amountToBeAdded = this.amountToBeAdded + 1000;
        console.log(this.amountToBeAdded);
    }
    handleInputAmount(event){
        const amountInInteger = parseInt(event.target.value);
        console.log(amountInInteger);
        this.amountToBeAdded = amountInInteger;
        console.log(this.amountToBeAdded);
    }

    @wire(getRecord, { recordId: USER_ID, fields: [USER_NAME_FIELD] })
        wiredUserName({ error, data }) {
            if (data) {
                console.log('User Name : ');
                console.log(data);
                this.userName = data.fields.Name.value;
            } else if (error) {
                console.error(error);
            }
        }
        @wire(getRecord, { recordId: USER_ID, fields: [USER_NAME_EMAIL] })
        wiredUserEmail({ error, data }) {
            if (data) {
                console.log('User Email...............');
                console.log(data);
                this.userEmail = data.fields.Email.value;
            } else if (error) {
                console.error(error);
            }
        }

        walletAmountAddedSuccessfully() {
            const event = new ShowToastEvent({
                title: 'Success!',
                message: 'Amount added successfully',
                variant: 'success',
            });
            this.dispatchEvent(event);
        }
        walletAmountAdditionFailed() {
            const event = new ShowToastEvent({
                title: 'Failed!',
                message: 'Transaction Failed',
                variant: 'error',
            });
            this.dispatchEvent(event);
        }
        minimumAmountMessage() {
            const event = new ShowToastEvent({
                message: 'Minimum ₹ 1,000 must be added!',
                variant: 'info',
            });
            this.dispatchEvent(event);
        }
        maximumAmountMessage() {
            const event = new ShowToastEvent({
                message: 'Maximum of ₹ 10,000 can be added at a time!',
                variant: 'info',
            });
            this.dispatchEvent(event);
        }
        invalidAmountMessage() {
            const event = new ShowToastEvent({
                message: ' Only multiples of 100 are allowed.',
                variant: 'info',
            });
            this.dispatchEvent(event);
        }
        enterValidAmount() {
            const event = new ShowToastEvent({
                message: 'Please enter valid amount!',
                variant: 'error',
            });
            this.dispatchEvent(event);
        }
        
        handleAddMoney(){
            if(this.amountToBeAdded < 1000){
                this.minimumAmountMessage();
            }
            else if(this.amountToBeAdded > 10000){
                this.maximumAmountMessage();
            }
            else if(this.amountToBeAdded % 100 !== 0){
                this.invalidAmountMessage();
            }
            else if(this.amountToBeAdded % 100 === 0 && this.amountToBeAdded >= 1000 && this.amountToBeAdded <= 10000){
                console.log(this.amountToBeAdded);
                console.log(this.accountId);
                AddMoneyToWallet({userId : this.accountId , amount : this.amountToBeAdded})
                .then(response => {
                    if(response != null){
                        this.userBalance = response;
                        console.log(response);
                        this.walletAmountAddedSuccessfully();
                    }else{
                        this.walletAmountAdditionFailed();
                    }
                })  
            }
            else{
                this.enterValidAmount();
            }
        }
}