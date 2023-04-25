trigger UpdateSeatStatusAfterJourneyCompletion on Bus_Itinerary__c (after update) {

    List<Bus_Itinerary__c> busItineraryList = new List<Bus_Itinerary__c> ();

    for(Bus_Itinerary__c busItinerary : Trigger.new){
        if(busItinerary.Journey_Status__c == 'Journey Completed'){
            busItineraryList.add(busItinerary);
        }
    }

    if(!busItineraryList.isEmpty()){
        List<Bus_Itinerary_Seat__c> busItinerarySeatList = [SELECT Id, Status__c FROM Bus_Itinerary_Seat__c WHERE Bus_Itinerary__c IN : busItineraryList];
        
        for(Bus_Itinerary_Seat__c seat : busItinerarySeatList){
            seat.Status__c = 'Available';
        }
        update busItinerarySeatList;
    }
}