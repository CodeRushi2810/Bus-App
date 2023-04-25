public without sharing class GetSeatList {
    @AuraEnabled(cacheable=false)
    public static List<Bus_Itinerary_Seat__c> returnSeatList(Id busItineraryId){
        List<Bus_Itinerary_Seat__c> seatsList = [SELECT Id, Name, Status__c, Bus_Itinerary__c, Seat__c, Seat__r.Name, Seat__r.Seat_Number__c, Seat__r.Seat_Type__c, Seat__r.Active__c, Seat_Bg_Color__c, Is_Disabled__c FROM Bus_Itinerary_Seat__c WHERE Bus_Itinerary__c =: busItineraryId ORDER BY Name];
    	
        List<Bus_Itinerary_Seat__c> returnSeatsList = new List<Bus_Itinerary_Seat__c> ();
        for(Bus_Itinerary_Seat__c seat : seatsList){
            if(seat.Status__c != 'Available'){
                seat.Is_Disabled__c = true;
                returnSeatsList.add(seat);
            }
        }
        return seatsList;
    }
}