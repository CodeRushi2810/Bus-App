public class dreamTeamGetValues {
    
    	@auraEnabled(cacheable = true)
    
    public static List<Position__c> getPoslist (){
        List<Position__c> posList = [SELECT Name FROM Position__c WHERE Status__c = 'Open - Approved'];
        
        if(!posList.isEmpty()){
            return posList;
        }
        return null;
    }
}