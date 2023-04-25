/*	
*   @Class Name 	: 	ViewSeatsController
*	@Description 	:	Displays Seats of a particular Bus
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/
public class ViewSeatsController {
	@AuraEnabled(cacheable = true)
    
    public static List<Seat__c> myMethod(Id busId){
        List<Seat__c> displaySeats = [SELECT Id, Name , Seat_Number__c, Status__c, Seat_Type__c FROM Seat__c WHERE Bus_Id__c =: busId ORDER BY Seat_Number__c ASC];     
                
        return displaySeats;
    }   
}