public without sharing class GetTravelerDetails {
    @AuraEnabled(cacheable = true)
    public static List<Journey_Traveller_Details__c> showTravelerData(List<Id> travelerIds){
        List<Journey_Traveller_Details__c> travelersData = [SELECT Id, Name, Traveller_Name__c, Traveller_Age__c, Traveller_Gender__c, Seat_Details__c
                                                           FROM Journey_Traveller_Details__c WHERE Id IN : travelerIds];
        
        return travelersData;
    }
}