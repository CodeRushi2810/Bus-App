public without sharing class ShowDetailedJourney {
    @AuraEnabled (cacheable = true)
    public static List<Passenger_Journey_Seat__c> journeyDetails(Id journeyId){
        
        Passenger_Journey__c journeyData = [SELECT Id, Seat_Ids__c FROM Passenger_Journey__c WHERE Id =: journeyId];
        
        String idString = journeyData.Seat_Ids__c;
        
        List<String> idList = idString.split(',');
        
        Integer count = 1;
        for(String seatId : idList){
            system.debug('Seat '+count+' : '+seatId);
            count++;
        }
        
        List<Passenger_Journey_Seat__c> selectedSeats = [SELECT Id, Name, Seat__c FROM Passenger_Journey_Seat__c
                                                         WHERE Id IN : idList];
        
        return selectedSeats;
    }
}