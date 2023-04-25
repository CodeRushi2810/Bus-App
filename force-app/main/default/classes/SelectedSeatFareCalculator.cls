/*	
*   @Class Name 	: 	SelectedSeatFareCalculator
*	@Description 	:	Calculates the Fare of the Selected Seat
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/
public class SelectedSeatFareCalculator {
	@AuraEnabled(cacheable = true)
        public static List<Seat__c> calculatePerSeatFare(Id busId , List<Id> seatIds){
            List<Seat__c> seatList = [SELECT Id, Name, Seat_Number__c, Seat_Type__c, Cost__c FROM Seat__c WHERE Id IN :seatIds];
            List<Bus__c> busData = [SELECT Name, Distance__c, Fair_Per_Kilometer_Sitting_Seat__c, Fair_Per_Kilometer_Sleeper_Seat__c FROM Bus__c WHERE Id =: busId];
            
            Decimal distance = busData[0].Distance__c;
            Decimal sleeperFairPerKm = busData[0].Fair_Per_Kilometer_Sleeper_Seat__c;
            Decimal sittingFairPerKm = busData[0].Fair_Per_Kilometer_Sitting_Seat__c;
            
            for(Seat__c seat : seatList){
                if(seat.Seat_Type__c == 'Sitting'){
                    seat.Cost__c = distance*sittingFairPerKm;
                }
                else if(seat.Seat_Type__c == 'Sleeper'){
                    seat.Cost__c = distance*sleeperFairPerKm;
                }
            }
            system.debug(seatList);
            return seatList;
        }
}