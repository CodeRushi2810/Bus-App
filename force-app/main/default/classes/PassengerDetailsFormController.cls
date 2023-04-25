public without sharing class PassengerDetailsFormController {
    @AuraEnabled(cacheable = false)
    public static List<Bus_Itinerary_Seat__c> seatDetails(List<Id> selectedSeatsItineraryIds){
        
        List<Bus_Itinerary_Seat__c> busItinerarySeatId = [SELECT Id, Name, Seat__r.Name,Seat__r.Seat_Number__c, Seat__r.Seat_Type__c FROM Bus_Itinerary_Seat__c WHERE Id IN : selectedSeatsItineraryIds ORDER BY Seat__r.Seat_Number__c];

        return busItinerarySeatId;
        
        //Bus_Itinerary__c busDetails = [SELECT Id, Bus_Name__c , Total_Distance__c FROM Bus_Itinerary__c WHERE Id =: busItineraryId]; 
        //Id busID = busDetails.Bus_Name__c;
        //system.debug('Bus Id : '+busId);
        
    }
}