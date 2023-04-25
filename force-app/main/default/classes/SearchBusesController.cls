/*	
*   @Class Name 	: 	SearchBusesController
*	@Description 	:	Returns all the buses available routing between the source city and the destination city
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/

/*
public class SearchBusesController {
@AuraEnabled(cacheable = false)
public static List<Bus__c> searchBus(string cityOne, string cityTwo) {

List<Bus_Stop__c> listOne = [SELECT Id, Name, Bus_Id__c, City__r.Name, Stop_Number__c, Distance_From_Previous_Stop__c FROM Bus_Stop__c WHERE City__r.Name =: cityOne];
List<Bus_Stop__c> listTwo = [SELECT Id, Name, Bus_Id__c, City__r.Name, Stop_Number__c, Distance_From_Previous_Stop__c FROM Bus_Stop__c WHERE City__r.Name =: cityTwo];
List<Bus_Stop__c> secondLevelList = new List<Bus_Stop__c>();
List<String> thirdLevelList = new List<String>();    
Map<String, Bus_Stop__c> map1 = new Map<String, Bus_Stop__c>();
for(Bus_Stop__c obj : listOne) {
map1.put(obj.Bus_Id__c, obj);
}
for(Bus_Stop__c obj : listTwo) {
if(map1.containsKey(obj.Bus_Id__c)) {
secondLevelList.add(obj);
}
}
for(Bus_Stop__c check : secondLevelList){
thirdLevelList.add(check.Bus_Id__c);
}


List<Bus_Stop__c> forthLevelList = [SELECT Id, Bus_Id__c, City__r.Name, Stop_Number__c FROM Bus_Stop__c WHERE Bus_Id__c IN : thirdLevelList];
List<Bus_Stop__c> finalList = new List<Bus_Stop__c>();
for(Bus_Stop__c testOne : forthLevelList){
for(Bus_Stop__c testTwo : forthLevelList){
if(testOne.City__r.Name == cityOne && testTwo.City__r.Name == cityTwo){
if(testOne.Stop_Number__c < testTwo.Stop_Number__c){
finalList.add(testOne);
break;
}
}
}
}
//Check : If the destination city provided by the user is in any bus's 1st stop in any route, and Source City is also available
//        in that route, than that bus is also being displayed.

List<Bus_Stop__c> fullAndFinalList = new List<Bus_Stop__c>();

for(Bus_Stop__c busList : finalList){
Integer startIndex = -1;
Integer endIndex = -1;
List<Bus_Stop__c> testList = [SELECT Id,Bus_Id__r.Name, Stop_Number__c, City__r.Name FROM Bus_Stop__c WHERE Bus_Id__c =: busList.Bus_Id__c];
for(Integer i = 0 ; i < testList.size(); i++){
if (testList[i].City__r.Name == cityOne) {
startIndex = i;
system.debug('Start Index : '+startIndex+' City Name : '+testList[i].City__r.Name+' Bus Name : '+testList[i].Bus_Id__r.Name);
}
if (testList[i].City__r.Name == cityTwo) {
endIndex = i;
system.debug('End Index : '+endIndex+' City Name : '+testList[i].City__r.Name+' Bus Name : '+testList[i].Bus_Id__r.Name);
break;
}
}
if(endIndex > 0 && startIndex != -1){
fullAndFinalList.add(busList);
//system.debug(busList.City__r.Name);
}
}

List<Id> busIdList = new List<Id>();

for(Bus_Stop__c busId : fullAndFinalList){
busIdList.add(busId.Bus_Id__c);
}
List<Bus__c> fetchBusDetails = [SELECT Id, Name, Source_City__c,  Destination_City__c, Type__c, Journey_Date__c,Number_Of_Sitting_Seats__c,Number_Of_Sleeper_Seat__c FROM Bus__c WHERE Id IN :busIdList];

List<Bus__c> returnBusList = new List<Bus__c>();

for(Bus__c bus : fetchBusDetails){
bus.Source_City__c = cityOne;
bus.Destination_City__c = cityTwo;
returnBusList.add(bus);
}                         
return returnBusList;
}
}

*/

public without sharing class SearchBusesController {
    @AuraEnabled(cacheable=true)
    public static List<Bus_Itinerary__c> searchBus(string cityOne, string cityTwo, Date journeyDate) {
        //Fetching all the routes with Source city and Destination city as per the user input 
        
        try{
            List<Route__c> routesList = [SELECT Id, Name, Source__r.Name, Destination__r.Name FROM Route__c WHERE Source__r.Name =: cityOne AND Destination__r.Name =: cityTwo];
            for(Route__c route : routesList){
                //system.debug(route.Name);
            }
            //Getting the Ids of all the records present in the routesList List
            List<Id> routeIds = new List<Id>();
            for(Route__c routeId : routesList){
                routeIds.add(routeId.Id);	
            }   
            //Fetching all the Bus Itinerary records which has the Route availabe in the routesList 
            
            List<Bus_Itinerary__c> busList = [SELECT Id, Name, Bus_Name__c, Bus_Name__r.Bus_Number__c, Bus_Name__r.Type__c, Bus_Name__r.Name, Bus_Name__r.Fair_Per_Kilometer_Sitting_Seat__c,
                                              Bus_Name__r.Fair_Per_Kilometer_Sleeper_Seat__c, Route__r.Name, Total_Distance__c, Journey_Date__c,
                                              Lowest_Fare__c, Highest_Fare__c, Seats_Left__c, Window_Seats_Left__c, Start_Date_Time__c, End_Date_Time__c, Journey_Status__c, Journey_Duration__c,
                                              Ratings__c, Total_Ratings__c
                                              FROM Bus_Itinerary__c WHERE Route__c IN : routeIds AND Journey_Date__c =: journeyDate
                                              AND Journey_Status__c =: 'Journey Not Started' ORDER BY Start_Date_Time__c];

            List<Bus_Itinerary__c> returnBusList = new List<Bus_Itinerary__c>();
            
            for(Bus_Itinerary__c busItinerary : busList){
                List<Bus_Itinerary_Seat__c> leftSeats = [SELECT Id FROM Bus_Itinerary_Seat__c WHERE Bus_Itinerary__c =: busItinerary.Id AND Status__c = 'Available'];
                List<Bus_Itinerary_Seat__c> windowSeatsLeft = [SELECT Id FROM Bus_Itinerary_Seat__c WHERE Bus_Itinerary__c =: busItinerary.Id AND Status__c = 'Available'
                                                               AND Seat__r.Is_Window_Seat__c = true];
                
                List<Bus_Review__c> busReview = [SELECT Id, Overall_Rating__c FROM Bus_Review__c WHERE Bus__c =: busItinerary.Bus_Name__c];
                Decimal TotalRating = 0;
                for(Bus_Review__c review : busReview){
                    TotalRating += review.Overall_Rating__c;
                }
                Decimal averageRating = busReview.size() > 0 ? TotalRating / busReview.size() : 0;
                averageRating = averageRating.setScale(1);
                
                busItinerary.Lowest_Fare__c = busItinerary.Total_Distance__c * busItinerary.Bus_Name__r.Fair_Per_Kilometer_Sitting_Seat__c;
                busItinerary.Highest_Fare__c = busItinerary.Total_Distance__c * busItinerary.Bus_Name__r.Fair_Per_Kilometer_Sleeper_Seat__c;  
                busItinerary.Seats_Left__c = leftSeats.size();
                busItinerary.Window_Seats_Left__c = windowSeatsLeft.size();
                
                busItinerary.Ratings__c = averageRating;
                busItinerary.Total_Ratings__c = busReview.size();
                returnBusList.add(busItinerary);
                system.debug(busItinerary.Id + ' | ' + busItinerary.Name + ' | ' + busItinerary.Bus_Name__r.Name + ' | ' + busItinerary.Route__r.Name + ' | '+ busItinerary.Journey_Date__c);
            }       
            return returnBusList;
        }
        catch(Exception ex){
            system.debug('Error : '+ex.getLineNumber() + ' @@ ' + ex.getMessage() + ' @@ ' +ex.getStackTraceString());
            return null;
        }
    }
}