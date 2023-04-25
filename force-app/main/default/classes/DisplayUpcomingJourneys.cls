/*	
*   @Class Name 	: 	DisplayUpcomingJourneys
*	@Description 	:	Displays the Upcoming Journey Details of the Current Logged In User
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/


public class DisplayUpcomingJourneys {
    @auraEnabled(cacheable = false)
    public static List<Passenger_Journey__c> upcomingJourneyList(){
        
        Id userId = UserInfo.getUserId();
        User currentUser = [SELECT Id, AccountId FROM User WHERE Id =: userId];
        userId = currentUser.AccountId;
        
        DateTime currentDateTime = Datetime.now();
        
        List<Passenger_Journey__c> upcomingJourneys = [SELECT Id, Name, Start_Time__c,  End_Time__c, Bus_Id__r.Name, Total_Fare__c, Source_City__c, Destination_City__c,
                                                       Journey_Date__c, Booking_Date__c, Pickup_Point__r.Name, Drop_Point__r.Name FROM Passenger_Journey__c
                                                       WHERE Passenger_Id__c =: userId AND Start_Time__c >:  currentDateTime];

        if(!upcomingJourneys.isEmpty()){
            return upcomingJourneys;
        }
        else{
            return null;
        }
        
    }
}