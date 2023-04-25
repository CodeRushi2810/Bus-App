public without sharing class SleeperSeatFareCalculator {
    @AuraEnabled(cacheable = true)
    public static Decimal calculateSleeperFare(List<Id> seatIds){
        Decimal returnZero = 0;
        if(!seatIds.isEmpty()){
            Decimal totalFare = 0;
            List<Bus_Itinerary_Seat__c> busItinerarySeatId = [SELECT Bus_Itinerary__c FROM Bus_Itinerary_Seat__c WHERE Id IN : seatIds];
            Id busItineraryId = busItinerarySeatId[0].Bus_Itinerary__c;
            Bus_Itinerary__c busDetails = [SELECT Id, Bus_Name__c , Total_Distance__c FROM Bus_Itinerary__c WHERE Id =: busItineraryId];
            Id busID = busDetails.Bus_Name__c;
            system.debug('Bus Id : '+busId);
            
            Decimal totalDistance = busDetails.Total_Distance__c;
            system.debug('Total Distance : '+totalDistance);
            
            Bus__c farePerKm = [SELECT Fair_Per_Kilometer_Sleeper_Seat__c FROM Bus__c WHERE Id =: busID];
            Decimal sleeperSeatFarePerKm = farePerKm.Fair_Per_Kilometer_Sleeper_Seat__c;
            system.debug('Sleeper Fare : '+sleeperSeatFarePerKm);
            
            List<Bus_Itinerary_Seat__c> seatList = [SELECT Id, Name, Fare__c, Seat__r.Seat_Type__c FROM Bus_Itinerary_Seat__c WHERE Id IN : seatIds AND Seat__r.Seat_Type__c = 'Sleeper'];
            
            for(Bus_Itinerary_Seat__c seat : seatList){
                seat.Fare__c = totalDistance*sleeperSeatFarePerKm;
                totalFare = totalFare + seat.Fare__c;
                system.debug('Seat Name : ' + seat.Name+ ' | Seat Type : ' + seat.Seat__r.Seat_Type__c);
            }
            system.debug('Total Fare : '+totalFare);
            return totalFare;
        }
        else{
            return returnZero;
        }
    }
}