/*	
*   @Class Name 	: 	UpdateSeatStatusController
*	@Description 	:	Update the status of the seat selected by the user
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/
public without sharing class UpdateSeatStatusController {
    @AuraEnabled(cacheable = false) 
    public static string updateSeatStatus(List<Id> seatId){       
        try{
            List<Bus_Itinerary_Seat__c> updatedSeats  = new List<Bus_Itinerary_Seat__c>(); 
            List<Bus_Itinerary_Seat__c> seatsToUpdate =[SELECT Id, Status__c FROM Bus_Itinerary_Seat__c WHERE Id IN : seatId];
            
            for(Bus_Itinerary_Seat__c seat : seatsToUpdate){
                seat.Status__c = 'Booked';
                updatedSeats.add(seat); 
            }
                                         
            if(!updatedSeats.isEmpty()){
                update updatedSeats;
                system.debug('Seat ID : '+seatId + ' | Status Updated Successfully');
                return 'Status Updated Successfully';
            }else{
                system.debug('No Seat Updated');
                return 'No Seat Updated';
            }
        }
        catch(Exception ex){
            system.debug(ex.getMessage());
            system.debug(ex.getStackTraceString());
            return 'Error Occured' + ex;
        }
    }
}