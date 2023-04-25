public without sharing class GetDropPointsController {
	@AuraEnabled(cacheable = true)
    public static List<Route_Line_Item__c> dropPoints(Id busItineraryId, String cityName){
        Bus_Itinerary__c busItinerary = [SELECT Id, Name, Route__c FROM Bus_Itinerary__c WHERE Id =: busItineraryId LIMIT 1];
        Id routeId = busItinerary.Route__c;
        
        List<Route_Line_Item__c> stopList = [SELECT Id, Name, Station__r.Name, City__r.Name, Station__r.Address__c, Route__c FROM Route_Line_Item__c WHERE Route__c =: routeId AND City__r.Name =: cityName ORDER BY Sort_Order__c ASC];
        
        return stopList;
    }
}