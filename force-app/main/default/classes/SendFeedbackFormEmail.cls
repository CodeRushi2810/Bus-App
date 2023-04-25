global class SendFeedbackFormEmail  implements Schedulable {
    global void execute(SchedulableContext SC) {
//public class SendFeedbackFormEmail{
//    public static void myMethod() {
        DateTime currentTime = DateTime.now();
        List<Passenger_Journey__c> journeys = [SELECT Id, End_Time__c, Feedback_Provided__c, Passenger_Id__c FROM Passenger_Journey__c WHERE End_Time__c <: currentTime AND Feedback_Provided__c = false];
        
        List<Passenger_Journey__c> updateJourneyList = new List<Passenger_Journey__c> ();
        
        for(Passenger_Journey__c journey : journeys){
            journey.Feedback_Provided__c = true;
            updateJourneyList.add(journey);
        }
        update updateJourneyList;
        
        List<String> IdList = new List<String> ();
        for(Passenger_Journey__c journey : journeys){
            IdList.add(journey.Passenger_Id__c);
        }
        List<Id> journeyIdList = new List<Id> ();
        for(Passenger_Journey__c journeyId : journeys){
            journeyIdList.add(journeyId.Id);
        }
        
        List<Account> accList = [SELECT Id, PersonEmail FROM Account WHERE Id IN : IdList];
        
        List<String> emailList = new List<String> ();
        
        for(Account acc : accList){
            emailList.add(acc.PersonEmail);
        }
        
        List<Map<String, Object>> myMapList = new List<Map<String, Object>>();
        
        for(Integer i = 0; i < emailList.size(); i++){
            Map<String, Object> journeyEmailMap = new Map<String, Object>();
            journeyEmailMap.put('journeyId', journeyIdList[i]);
            journeyEmailMap.put('email', emailList[i]);
            myMapList.add(journeyEmailMap);
        }
        
        system.debug(myMapList);
        
        String orgWideEmailId = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'unicorn.bus999@gmail.com' LIMIT 1].Id;
        String link = 'https://horizontaldigital-c-dev-ed.my.site.com/unicornBusService/s/feedback-form?Id=';
        
        for (Map<String, Object> myMap : myMapList) {
            // access the values of the 'Journey Id' and 'email' fields
            String journeyId = (String) myMap.get('journeyId');
            String userEmail = (String) myMap.get('email');
            System.debug('Journey Id: ' + journeyId + ', Email: ' + userEmail);
            
            String body = 'Hope you had an amazing Journey. Here is the link to a passenger Feedback Form. Please take a moment to fill the form. ';
            
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[] {userEmail});
            email.setSubject('Feedback Form');
            email.setPlainTextBody(body+link+journeyId);
            email.setOrgWideEmailAddressId(orgWideEmailId);
            
            Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
            if (results[0].isSuccess()) {
                System.debug('Email sent successfully.');
            } else {
                System.debug('Email failed to send: ' + results[0].getErrors()[0].getMessage());
            }
        }        
    }
}