public class DeleteTravellerData {
    public static void deleteIds(){
        List<Journey_Traveller_Details__c> dataToBeDeleted = [SELECT Id, Name FROM Journey_Traveller_Details__c];
        delete dataToBeDeleted;
    }
}