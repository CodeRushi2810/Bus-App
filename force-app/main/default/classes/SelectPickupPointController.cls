public without sharing class SelectPickupPointController {
    @AuraEnabled(cacheable = true)
    public static Station__c pickupPoint(Id pickupPointId){
        Route_Line_Item__c routePointId = [SELECT Id, Name, Station__c FROM Route_Line_Item__c WHERE Id =: pickupPointId];
        system.debug(routePointId);
        Id stationId = routePointId.Station__c;
        
        Station__c locationData = [SELECT Id, Name, Address__c, City__r.Name FROM Station__c WHERE Id =: stationId];
        
        return locationData;
    }
}