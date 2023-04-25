public class homeComponentOne {
	@auraEnabled(cacheable=true)
    
    public static List<Bus__c> fetchBuses(){
        List<Bus__c> busList = [SELECT Id, Name FROM Bus__c];
        
        return busList;
    }
}