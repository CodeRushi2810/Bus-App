public without sharing class GetCityNames {

    @AuraEnabled(cacheable = false)
    public static List<Route__c> cityNames(List<Id> selectedSeatsItineraryIds){
        
        List<Bus_Itinerary_Seat__c> busItinerarySeatId = [SELECT Bus_Itinerary__c FROM Bus_Itinerary_Seat__c WHERE Id IN : selectedSeatsItineraryIds];
        Id busItineraryId = busItinerarySeatId[0].Bus_Itinerary__c;
        
        List<Bus_Itinerary__c> busItinerary = [SELECT Id, Name, Route__c FROM Bus_Itinerary__c WHERE Id =: busItineraryId];
        system.debug(busItinerary);
        
        Id routeId = busItinerary[0].Route__c;
        system.debug(routeId);
        
        List<Route__c> city = [SELECT Id, Source__r.Name, Destination__r.Name FROM Route__c WHERE Id =: routeId];
        
        return city;
    }
    /*
    @AuraEnabled(cacheable = true)
    public static List<City__c> returnCityList(){
        List<City__c> cityList = [SELECT Id, Name FROM City__c ORDER BY Name ASC];

        return cityList;
    }
*/
}