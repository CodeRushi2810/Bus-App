public class UnicornBuses {

    @auraEnabled(cacheable=true)
    
    public static void buslist(String pickUp, String destination, Date journeyDate){
        
          	string keyOne = '%'+pickUp+'%';
          	string keyTwo = '%'+destination+'%';  
            
            //List<Bus__c> searchResult = [SELECT Id, Departure_Time__c, Name, From__c, To__c, Pickup_Time__c, Drop_Time__c,Journey_Duration__c, Journey_Date__c, Fair__c  FROM Bus__c WHERE From__c Like: keyOne AND To__c Like: keyTwo AND Journey_Date__c =: journeyDate ORDER BY Departure_Time__c];
        	//return searchResult;
    }
}