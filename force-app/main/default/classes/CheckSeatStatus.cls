/*  
*   @Class Name     :   CheckSeatStatus
*   @Description    :   Checks the status of the seat if it is available or not
*   @Author Name    :   Rushi Patel (Horizontal Digital)
*/

public without sharing class CheckSeatStatus {
    
    @AuraEnabled(cacheable = true)
    public static String checkSeatStatus(List<Id> seatIds){
        List<Bus_Itinerary_Seat__c> selectedSeats = [SELECT Id, Status__c FROM Bus_Itinerary_Seat__c WHERE Id IN : seatIds]; 
        
        List<Bus_Itinerary_Seat__c> bookedSeats = new List<Bus_Itinerary_Seat__c> ();
        
        for(Bus_Itinerary_Seat__c seat : selectedSeats){
            if(seat.Status__c == 'Booked'){
                bookedSeats.add(seat);
            }
        }
        if(!bookedSeats.isEmpty()){
            return 'Selected seat is already booked';
        }else{
            return 'Booking can be done';
        }
    }
    /*
    @AuraEnabled(cacheable = true)
    public static List<seat__c> checkStatus(List<Id> seatId){
        List<seat__c> selectedSeats = [SELECT Id, Name, Status__c FROM seat__c WHERE Id IN :seatId];        
        List<seat__c> bookedSeats = new List<seat__c>();        
        for(seat__c seat : selectedSeats){
            if(seat.Status__c == true){
                bookedSeats.add(seat);
            }
        }
        if(!bookedSeats.isEmpty()){
            return null;
        }else{
            return selectedSeats;
        }
    }
    
    public static List<Bus__c> busData(Id busId){
        return [SELECT Id, Name, Conductor__c, Driver__c, Journey_Date__c FROM Bus__c WHERE Id =: busId];
    } 
*/
}