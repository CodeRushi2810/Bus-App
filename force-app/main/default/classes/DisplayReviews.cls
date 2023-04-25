public without sharing class DisplayReviews {
   	@auraEnabled(cacheable=true)
    public static List<Bus_Review__c> showReviews (String busId){
        
        return [SELECT Id, Name, Passenger_Name__r.Name, Feedback__c, Overall_Rating__c FROM Bus_Review__c WHERE Bus__c =: busId];        
    }
}