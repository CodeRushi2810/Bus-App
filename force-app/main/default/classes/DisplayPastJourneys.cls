/*	
*   @Class Name 	: 	DisplayPastJourneys
*	@Description 	:	Displays the Past Journey Details of the Current Logged In User
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/

public class DisplayPastJourneys {
    @auraEnabled(cacheable = true)
    public static List<Passenger_Journey__c> pastJourneyList(){
        
        Id userId = UserInfo.getUserId();
        User currentUser = [SELECT Id, AccountId FROM User WHERE Id =: userId];
        userId = currentUser.AccountId;
        
        DateTime currentDateTime = Datetime.now();
        
        List<Passenger_Journey__c> pastJourneys = [SELECT Id, Name, Start_Time__c,  End_Time__c, Bus_Id__r.Name, Total_Fare__c, Source_City__c, Destination_City__c,
                                                   Journey_Date__c, Booking_Date__c, Pickup_Point__r.Name, Pickup_Point__r.City__r.Name, Pickup_Point__r.Address__c, 
                                                   Drop_Point__r.Name, Drop_Point__r.City__r.Name, Drop_Point__r.Address__c
                                                   FROM Passenger_Journey__c
                                                   WHERE Passenger_Id__c =: userId AND Start_Time__c <:  currentDateTime];
        if(!pastJourneys.isEmpty()){
            return pastJourneys;
        }
        else{
            return null;
        }
    }
}