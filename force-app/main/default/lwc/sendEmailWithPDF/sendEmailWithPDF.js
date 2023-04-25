/* eslint-disable no-unused-vars */
/* eslint-disable vars-on-top */
/* eslint-disable no-shadow */
/* eslint-disable guard-for-in */
import {LightningElement, track, wire} from 'lwc';
import TestPDFClass from "@salesforce/apex/TestPDFClass.sendPdf";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class SendEmailWithPDF extends LightningElement {

 
    generatePDF(){
        TestPDFClass({journeyId : 'a0F5g000003DKvIEAW'})
        .then(res=>{
            this.ShowToast('Success', res, 'success', 'dismissable');
        })
        .catch(error=>{
            this.ShowToast('Error', 'Error in send email!!', 'error', 'dismissable');
            console.log(error);
        })
    }
     
 
    ShowToast(title, message, variant, mode){
        const evt = new ShowToastEvent({
            title: title,
            message:message,
            variant: variant,
            mode: mode
        });
        this.dispatchEvent(evt);
    }

}