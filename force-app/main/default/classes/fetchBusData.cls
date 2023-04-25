/*	
*   @Class Name 	: 	fetchBusData
*	@Description 	:	Returns the name of the selected Bus
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/

public class fetchBusData {
	@AuraEnabled(cacheable = true)
    public static String busName(Id busId){
        List<Bus__c> busList = [SELECT Name FROM Bus__c WHERE Id =: busId];
        
        String busName = busList[0].Name;
        system.debug(busName);
        return busName;
    }
}