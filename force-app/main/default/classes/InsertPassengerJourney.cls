/*	
*   @Class Name 	: 	InsertPassengerJourney
*	@Description 	:	Controller for inserting the Journey Details in the Passenger_Journey__c object
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/


public without sharing class InsertPassengerJourney {
    @AuraEnabled(cacheable=false)
    public static Id passengerJourney(Id busId, Decimal fare, string sourceCity, string destinationCity, Date bookingDate, List<Id> seatIds, Id busItineraryId, Id pickupPointId, Id dropPointId){
        Savepoint rollbackStartPoint = Database.setSavepoint();
        try{
            List<Bus_Itinerary_Seat__c> busItineraryIdList = [SELECT Id, Name, Bus_Itinerary__c
                                                              FROM Bus_Itinerary_Seat__c WHERE Id IN : seatIds LIMIT 1];
            Id itineraryId = busItineraryIdList[0].Bus_Itinerary__c;
            
            List<Bus_Itinerary__c> busItinerary = [SELECT Id, Journey_Date__c, Start_Date_Time__c, End_Date_Time__c, Journey_Duration__c FROM Bus_Itinerary__c WHERE ID =: itineraryId];
            Date journeyDate = busItinerary[0].Journey_Date__c;
            DateTime startTime = busItinerary[0].Start_Date_Time__c;
            DateTime endTime = busItinerary[0].End_Date_Time__c;
            String journeyDuration = busItinerary[0].Journey_Duration__c;
            
            Id userId = UserInfo.getUserId();
            User currentUser = [SELECT Id, AccountId FROM User WHERE Id =: userId];
            userId = currentUser.AccountId;
            
            Passenger_Journey__c journey = new Passenger_Journey__c (); 
            journey.Passenger_Id__c = userId;
            journey.Journey_Date__c = journeyDate;
            journey.Bus_Id__c = busId;
            journey.Total_Fare__c = fare;
            journey.Source_City__c = sourceCity;
            journey.Destination_City__c = destinationCity;
            journey.Booking_Date__c = bookingDate;
            journey.Bus_Itinerary__c = busItineraryId;
            journey.Pickup_Point__c	 = pickupPointId;
            journey.Drop_Point__c = dropPointId;
            journey.Start_Time__c = startTime;
            journey.End_Time__c = endTime;
            journey.Journey_Duration__c = journeyDuration;
            
            Database.SaveResult result = Database.insert(journey, false);
            
            if (result.isSuccess()) {
                System.debug('Data inserted successfully');
                String response = insertPassengerSeats(seatIds, journey.Id);
                if(response == 'Passenger Seats Insertion Failed'){
                    Database.rollback(rollbackStartPoint);
                    System.debug('ROLLBACK CALLED>>');
                    return null;
                }else{
                    return journey.Id;
                }
            } 
            else {
                for (Database.Error err : result.getErrors()) {
                    System.debug('Error message: ' + err.getMessage());
                } 
                return null;
            }
        }
        catch(Exception ex){
            system.debug(ex.getMessage());
            system.debug(ex.getStackTraceString());
            return null;
        }
    }
    
    @AuraEnabled (cacheable = false)
    public static string insertPassengerSeats(List<Id> seatIds, Id passengerJourneyId){
        
        List<Passenger_Journey_Seat__c> seatsToInsert = new List<Passenger_Journey_Seat__c> ();
        
        for(integer i = 0 ; i < seatIds.size() ; i++){
            Passenger_Journey_Seat__c seat = new Passenger_Journey_Seat__c ();
            seat.Seat__c = seatIds[i];
            seat.Passenger_Journey__c = passengerJourneyId;
            seatsToInsert.add(seat);
        }
        List<Database.SaveResult> saveResults  = Database.insert(seatsToInsert, false);
        
        integer count = 0;
        for (Database.SaveResult result : saveResults) {
            if (result.isSuccess()) {
                System.debug('Account was inserted successfully. ID: ' + result.getId());
                count++;
            } else {
                System.debug('Account insertion failed. Error: ' + result.getErrors()[0].getMessage());
            }
        }
        if(count == seatIds.size()){
            
            List<Passenger_Journey_Seat__c> seatIdsToInsert = [SELECT Id, Name,Passenger_Journey__c FROM Passenger_Journey_Seat__c 
                                                               WHERE Passenger_Journey__c =: passengerJourneyId];
            
            Passenger_Journey__c journeyList = [SELECT Id, Name, Seat_Ids__c FROM Passenger_Journey__c WHERE Id =: passengerJourneyId];
            
            String seatId = '';
            for(Passenger_Journey_Seat__c seat : seatIdsToInsert){
                seatId = seatId+''+seat.Id+',';
            }
            journeyList.Seat_Ids__c = seatId;
            
            Database.SaveResult result = Database.update(journeyList, false);
            
            if (result.isSuccess()) {
                return 'Passenger Seats Inserted Successfully';
            }else{
                return 'Passenger Seats Insertion Failed';
            }
        } 
        else {
            return 'Passenger Seats Insertion Failed';
        }
    }
}