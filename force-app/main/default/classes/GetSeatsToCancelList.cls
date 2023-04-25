public class GetSeatsToCancelList {
    @AuraEnabled(cacheable = true)
    
    public static List<Id> seatList (Id journeyId){
        
        List<Passenger_Journey_Seat__c> seatList = [SELECT Id, Name FROM Passenger_Journey_Seat__c WHERE Passenger_Journey__c =: journeyId];
        
        List<Id> seatIdList = new List<Id>();
        
        for(Passenger_Journey_Seat__c seat : seatList){
            seatIdList.add(seat.Id);
        }
        return seatIdList;
    }
}