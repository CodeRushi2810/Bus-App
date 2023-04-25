public without sharing class MergeDataWithTravellerController {
    @auraEnabled(cacheable=false)
    public static Map<String, String> sendData(List<Id> seatIds){
        List<Bus_Itinerary_Seat__c> seatList = [SELECT Id, Name, Status__c, Seat__r.Name, Seat__r.Seat_Type__c FROM Bus_Itinerary_Seat__c WHERE Id IN :seatIds];

        List<String> seatNames = new List<String>();
        for(Bus_Itinerary_Seat__c seat : seatList){
            seatNames.add(String.valueOf(seat.Seat__r.Name));
            seatNames.add(String.valueOf(seat.Seat__r.Seat_Type__c));
        }
        for(String seat : seatNames){
            system.debug(seat);
        }
        system.debug('...................');
        
        List<String> seatNamesWithType = new List<String>();
        for(Bus_Itinerary_Seat__c seat : seatList){
            seatNamesWithType.add(String.valueOf(seat.Seat__r.Name) + ' - ' + String.valueOf(seat.Seat__r.Seat_Type__c));
        }        
        for(String seat : seatNamesWithType){
            system.debug(seat);
        }
        

        system.debug('...................');
        Map<String, String> seatDataMap = new Map<String, String>();
        for (Integer i = 0; i < seatList.size(); i++) {
            String seatNameWithType = seatList[i].Seat__r.Name + ' - ' + seatList[i].Seat__r.Seat_Type__c;
            String seatId = String.valueOf(i);
            seatDataMap.put(seatId, seatNameWithType);
        }
        system.debug(seatDataMap);
        
        return seatDataMap;
        
    }
}