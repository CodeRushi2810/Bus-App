public class GetAllSeatsStatus {
    @AuraEnabled(cacheable = true)
    public static string seatStatus(Id busId){
        
        List<Seat__c> seatList = [SELECT Id, Name, Status__c FROM Seat__c WHERE Bus_Id__c =: busId AND Status__c = false];
        
        if(!seatList.isEmpty()){
            return 'Booking Open';
        }else{
            return 'Booking Closed';
        }
            
    }
}