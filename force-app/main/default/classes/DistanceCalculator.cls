/*	
*   @Class Name 	: 	DistanceCalculator
*	@Description 	:	Calculates the distance between the source city and the destination city
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/

public class DistanceCalculator {
	@AuraEnabled(cacheable = true)
    public static Decimal distanceCalculator(String sourceCity, String destinationCity, Id busId){
		
        List<Bus_Stop__c> stopsList = [SELECT Stop_Number__c, City__r.Name, Bus_Id__r.Name, Distance_From_Previous_Stop__c
                                   FROM Bus_Stop__c
                                   WHERE Bus_Id__c =: busId
                                   ORDER BY Stop_Number__c ASC];
        // Find the indices of the source city and destination city in the stopsList
        Integer startIndex = -1;
        Integer endIndex = -1;
        for (Integer i = 0; i < stopsList.size(); i++) {
            if (stopsList[i].City__r.Name == sourceCity) {
                startIndex = i;
                system.debug('Start Index : '+startIndex);
            }
            if (stopsList[i].City__r.Name == destinationCity) {
                endIndex = i;
                system.debug('End Index : '+endIndex);
                break;
            }
        }
        // Calculate the total distance between the source city and destination city
        Decimal totalDistance = 0;
        if(startIndex == 0){
            for(Integer i = startIndex ; i <= endIndex; i++){
                totalDistance = totalDistance + stopsList[i].Distance_From_Previous_Stop__c;
            }
        }
        if(startIndex != 0){
            for(Integer i = startIndex ; i <= endIndex; i++){
                totalDistance = totalDistance + stopsList[i].Distance_From_Previous_Stop__c;
            }    
            totalDistance = totalDistance - stopsList[startIndex].Distance_From_Previous_Stop__c;
        }
    	System.debug('Total distance between ' + sourceCity + ' and ' + destinationCity + ': ' + totalDistance);
   
    	return totalDistance;
    }
}