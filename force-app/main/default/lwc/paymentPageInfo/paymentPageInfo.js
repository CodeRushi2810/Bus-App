import { LightningElement } from 'lwc';
import payImage from '@salesforce/resourceUrl/payImage';


export default class PaymentPageInfo extends LightningElement {
    payImage = payImage;
}