public class dreamTeamJACount {
    
    @auraEnabled(cacheable = true)
    
	public static integer myMethod(){
        
		List<Job_Application__c> myList = [SELECT Id FROM Job_Application__c];
       	integer counts = myList.size();
        system.debug('Total number of Job Applications : ' + counts);
        return counts;
    }
}