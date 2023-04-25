public without sharing class ShowSelectedSeatsController {
    @auraEnabled(cacheable=true)
    public static List<Bus_Itinerary_Seat__c> displaySelectedSeats(List<Id> seatIds){
        List<Bus_Itinerary_Seat__c> seatList = [SELECT Id, Name, Status__c, Bus_Itinerary__c, Seat__c, Seat__r.Name, Seat__r.Seat_Type__c, Seat__r.Active__c, Seat_Bg_Color__c FROM Bus_Itinerary_Seat__c WHERE Id IN :seatIds];

        return seatList; 	
    }
    /*
    public static List<Seat__c> displaySelectedSeats(List<Id> seatId){
        List<Seat__c> seatList = [SELECT Id, Name, Seat_Type__c FROM Seat__c WHERE Id IN :seatId];
        system.debug(seatList);
        return seatList;
    }
	*/
}