/*  
*   @Class Name     :   fetchSelectedBus
*   @Description    :   Displays the bus details
*   @Author Name    :   Rushi Patel (Horizontal Digital)
*/
public class fetchSelectedBus {
    @auraEnabled(cacheable=true)
    public static List<Bus__c> busList (String busId, String sourceCity, String destinationCity){
        List<Bus__c> busData = [SELECT Id, Name, Bus_Number__c, Source_City__c, Destination_City__c FROM Bus__c WHERE Id =: busId];
        List<Bus__c> returnBusData = new List<Bus__c>();
        system.debug(busData);
        
        for(Bus__c bus : busData){
            bus.Source_City__c = sourceCity;
            bus.Destination_City__c = destinationCity;
            returnBusData.add(bus);
        }
        system.debug(returnBusData);
        return returnBusData;
    }
    
}