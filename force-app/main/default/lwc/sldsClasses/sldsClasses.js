import { LightningElement , track} from 'lwc';

export default class SldsClasses extends LightningElement {
    @track currentStep = "1";
    @track hasError = "false";

    handleSelectStepOne(){
        this.currentStep = "1";
    }
    handleSelectStepTwo(){
        this.currentStep = "2";
    }
    handleSelectStepThree(){
        this.currentStep = "3";
    }
    handleSelectStepFour(){
        this.currentStep = "4";
    }
}