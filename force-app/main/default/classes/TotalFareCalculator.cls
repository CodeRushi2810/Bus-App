/*	
*   @Class Name 	: 	TotalFareCalculator
*	@Description 	:	Calculates the Total Fare of all the Selected Seats
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/
public without sharing class TotalFareCalculator {
    @AuraEnabled(cacheable = true)
    public static Decimal calculateTotalFare(List<Id> seatIds){
        
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
            
            Bus__c farePerKm = [SELECT Fair_Per_Kilometer_Sitting_Seat__c, Fair_Per_Kilometer_Sleeper_Seat__c FROM Bus__c WHERE Id =: busID];
            Decimal sittingSeatFarePerKm = farePerKm.Fair_Per_Kilometer_Sitting_Seat__c;
            Decimal sleeperSeatFarePerKm = farePerKm.Fair_Per_Kilometer_Sleeper_Seat__c;
            system.debug('Sitting Fare : '+sittingSeatFarePerKm + ' | Sleeper Fare : '+sleeperSeatFarePerKm);
            
            List<Bus_Itinerary_Seat__c> seatList = [SELECT Id, Name, Fare__c, Seat__r.Seat_Type__c FROM Bus_Itinerary_Seat__c WHERE Id IN : seatIds];
            for(Bus_Itinerary_Seat__c seat : seatList){
                if(seat.Seat__r.Seat_Type__c == 'Sitting'){
                    seat.Fare__c = totalDistance*sittingSeatFarePerKm;
                    totalFare = totalFare + seat.Fare__c;
                }else if(seat.Seat__r.Seat_Type__c == 'Sleeper'){
                    seat.Fare__c = totalDistance*sleeperSeatFarePerKm;
                    totalFare = totalFare + seat.Fare__c;
                }
            }
            system.debug('Total Fare : '+totalFare);
            return totalFare;
        }
        else{
            return returnZero;
        }
    }
}


/*
public class TotalFareCalculator {
@AuraEnabled(cacheable = true)
public static Decimal calculateTotalFare(Id busId , List<Id> seatIds, Decimal Distance){
Decimal TotalFare = 0;
List<Seat__c> seatList = [SELECT Id, Name,Seat_Number__c, Seat_Type__c, Cost__c FROM Seat__c WHERE Id IN :seatIds];
List<Bus__c> busData = [SELECT Name, Fair_Per_Kilometer_Sitting_Seat__c, Fair_Per_Kilometer_Sleeper_Seat__c FROM Bus__c WHERE Id =: busId];

Decimal sleeperFairPerKm = busData[0].Fair_Per_Kilometer_Sleeper_Seat__c;
Decimal sittingFairPerKm = busData[0].Fair_Per_Kilometer_Sitting_Seat__c;

for(Seat__c seat : seatList){
if(seat.Seat_Type__c == 'Sitting'){
seat.Cost__c = Distance*sittingFairPerKm;
TotalFare = TotalFare+seat.Cost__c;
}
else if(seat.Seat_Type__c == 'Sleeper'){
seat.Cost__c = Distance*sleeperFairPerKm;
TotalFare = TotalFare+seat.Cost__c;
}
}
system.debug('Total Fare : '+TotalFare);
return TotalFare;
}
}
*/