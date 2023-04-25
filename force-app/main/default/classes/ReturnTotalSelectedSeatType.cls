public without sharing class ReturnTotalSelectedSeatType {
    @AuraEnabled(cacheable = true)
    public static List<Decimal> returnSeatTypeCount(List<Id> seatIds){
        
        List<Bus_Itinerary_Seat__c> sittingSeatList = [SELECT Id, Seat__r.Seat_Type__c FROM Bus_Itinerary_Seat__c WHERE Id IN : seatIds AND Seat__r.Seat_Type__c = 'Sitting'];
        List<Bus_Itinerary_Seat__c> sleeperSeatList = [SELECT Id, Seat__r.Seat_Type__c FROM Bus_Itinerary_Seat__c WHERE Id IN : seatIds AND Seat__r.Seat_Type__c = 'Sleeper'];
        Decimal TotalSittingSeatsSelcted = sittingSeatList.size();
        Decimal TotalSleeperSeatsSelcted = sleeperSeatList.size();
        
        List<Decimal> seatsCount = new List<Decimal> ();
        seatsCount.add(TotalSittingSeatsSelcted);
        seatsCount.add(TotalSleeperSeatsSelcted);
        system.debug(seatsCount);
        
        return seatsCount;
    }
}