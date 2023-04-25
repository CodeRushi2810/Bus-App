import { LightningElement } from 'lwc';
import BackgroundImg from '@salesforce/resourceUrl/busImage';

export default class CSSImageTest extends LightningElement {
    imageUrl = BackgroundImg;

    get getBackgroundImage(){
        return `background-image:url("${this.imageUrl}")`;
    }
}