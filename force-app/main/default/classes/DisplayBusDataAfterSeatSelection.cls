public without sharing class DisplayBusDataAfterSeatSelection {
    @AuraEnabled(cacheable = true)
    public static List<Bus__c> busData(Id seatId){
        
        Bus_Itinerary_Seat__c busItinerary = [SELECT Id, Bus_Itinerary__r.Bus_Name__c FROM Bus_Itinerary_Seat__c WHERE Id =: seatId];
        
        Id busId = busItinerary.Bus_Itinerary__r.Bus_Name__c;
        
        List<Bus__c> busDetails = [SELECT Id, Name, Type__c FROM Bus__c WHERE Id =: busId];
        
        return busDetails;
    }
    /*
    @AuraEnabled(cacheable = true)
        public static List<Bus__c> busData(Id busId){
            return [SELECT Id, Name, Conductor__r.Name, Driver__r.Name, Journey_Date__c, Fair_Per_Kilometer_Sitting_Seat__c, Fair_Per_Kilometer_Sleeper_Seat__c FROM Bus__c WHERE Id =: busId];
    } 
*/
}