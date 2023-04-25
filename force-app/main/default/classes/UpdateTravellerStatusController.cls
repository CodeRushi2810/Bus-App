public class UpdateTravellerStatusController {
    @AuraEnabled(cacheable = false)
    public static String updateStatus(List<Id> travellerIds, String Operation, Id journeyId){
        List<Journey_Traveller_Details__c> travellerData = [SELECT Id, Status__c, Passenger_Journey__c FROM Journey_Traveller_Details__c
                                                            WHERE Id IN : travellerIds];
        List<Journey_Traveller_Details__c> updatedData = new List<Journey_Traveller_Details__c> ();
        
        for(Journey_Traveller_Details__c traveller : travellerData){    
            if(operation == 'Confirm Booking'){
                traveller.Status__c = 'Booked';
                traveller.Passenger_Journey__c = journeyId;
                updatedData.add(traveller);
            }else if(operation == 'Cancel Booking'){
                traveller.Status__c = 'Cancelled';
                traveller.Passenger_Journey__c = journeyId;
                updatedData.add(traveller);
            }
        }
        
        Integer updateCount = 0;
        Database.SaveResult[] updateResults = Database.update(updatedData);
        for (Database.SaveResult result : updateResults) {
            if (result.isSuccess()) {
                System.debug('Record updated successfully.');
                updateCount++;
            } else {
                for(Database.Error error : result.getErrors()) {
                    System.debug('Record update failed with message: ' + error.getMessage());
                }
            }
        }
        if(updateCount == updatedData.size()){
            return 'Status Updated Successfully';
        }else{
            return 'Status Updation Failed';
        }
    }
}