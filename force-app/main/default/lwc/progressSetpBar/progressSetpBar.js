import { LightningElement , track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class ProgressSetpBar extends NavigationMixin(LightningElement) {
    @track selectedStep = 'Step1';
 
    handleNext() {
        var getselectedStep = this.selectedStep;
        if(getselectedStep === 'Step1'){
            this.selectedStep = 'Step2';
        }
        else if(getselectedStep === 'Step2'){
            this.selectedStep = 'Step3';
        }
        else if(getselectedStep === 'Step3'){
            this.selectedStep = 'Step4';
        }
    }
    handleStepOne(){
        this.selectedStep = 'Step1';
    }
    handleStepTwo(){
        this.selectedStep = 'Step2';
    }
    handleStepThree(){
        this.selectedStep = 'Step3';
    }
    handleStepFour(){
        this.selectedStep = 'Step4';
    }
 
    selectStep1() {
        this.selectedStep = 'Step1';
    }
 
    selectStep2() {
        this.selectedStep = 'Step2';
        
    }
 
    selectStep3() {
        this.selectedStep = 'Step3';
        this[NavigationMixin.Navigate]({
            type: 'comm__namedPage',
            attributes: {
                name: 'Home'
            }
            })
    }
 
    selectStep4() {
        this.selectedStep = 'Step4';
    }
 
    get isSelectStep4() {
        return this.selectedStep === "Step4";
    }
}
