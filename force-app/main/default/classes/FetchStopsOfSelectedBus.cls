public class FetchStopsOfSelectedBus {
    @AuraEnabled(cacheable = true)
    public static List<Bus_Stop__c> busStopList(Id busId){
        List<Bus_Stop__c> stopsList = [SELECT Id, Bus_Id__c, Stop_Number__c, City__r.Name, Arrival_Time__c, Departure_Time__c, Halt_Duration__c FROM Bus_Stop__c WHERE Bus_Id__c =: busId ORDER BY Stop_Number__c ASC];
   
		return stopsList;
    }
}