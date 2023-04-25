public class DreamTeamPositions {

	@auraEnabled(cacheable = true)
    
    public static List<Position__c> posList(String searchKeys){
        if(searchKeys != null && searchKeys != ''){
            string key = '%'+searchKeys+'%';
            List<Position__c> searchPosList = [SELECT Id, Name, Status__c, Max_Pay__c, Min_Pay__c, Job_Level__c	 FROM Position__c WHERE Name Like: key AND Status__c = 'Open - Approved'];
            return searchPosList;
        }
        else{
        	List<Position__c> pos = [SELECT Id, Name, Status__c, Max_Pay__c, Min_Pay__c, Job_Level__c FROM Position__c WHERE Status__c = 'Open - Approved'];
            	if(!pos.isEmpty()){
            		return pos;    
            	}
            return null;
        }           
    }
}