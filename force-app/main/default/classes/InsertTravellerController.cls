public without sharing class InsertTravellerController {
    @AuraEnabled(cacheable = false)
    public static List<String> travellerDetails(List<Map<String, Object>> mergedData){
         
        Savepoint rollbackStartPoint = Database.setSavepoint();
             
        List<Journey_Traveller_Details__c> travellersList = new List<Journey_Traveller_Details__c>();
        
        Id userId = UserInfo.getUserId();
        User currentUser = [SELECT Id, AccountId FROM User WHERE Id =: userId];
        userId = currentUser.AccountId;	
        
        try{
            for (Map<String, Object> seat : mergedData) {
                Journey_Traveller_Details__c travellerDetails = new Journey_Traveller_Details__c();
                String seatDetails = (String) seat.get('seatDetails');
                String name = (String) seat.get('name');
                String age = (String) seat.get('age');
                String gender = (String) seat.get('gender');
                
                travellerDetails.Booker_Name__c = userId;
                travellerDetails.Traveller_Name__c = name;
                travellerDetails.Traveller_Age__c = age;
                travellerDetails.Traveller_Gender__c = gender;
                travellerDetails.Seat_Details__c = seatDetails;
                travellerDetails.Status__c = 'Drafted';
                travellersList.add(travellerDetails);
                system.debug('Name : '+name+' | Age : '+age+' | Gender : '+gender+' | Seat Details : '+seatDetails);
            }
            List<Id> travellersId = new List<Id> ();
            if(!mergedData.isEmpty()){
                Integer successCount = 0;    
                List<Database.SaveResult> insertStatus = Database.insert(travellersList, false);
                for (Database.SaveResult result : insertStatus) {
                    if (result.isSuccess()) {
                        System.debug('Record inserted successfully. ID: ' + result.getId());
                        Id insertedTravellerId = result.getId();
                        travellersId.add(insertedTravellerId);
                        successCount++;
                    } else {
                        for (Database.Error error : result.getErrors()) {
                            System.debug('Error inserting record. Message: ' + error.getMessage());
                            Database.rollback(rollbackStartPoint);
                            System.debug('ROLLBACK CALLED>>');
                        }
                    }
                }
                
                if (successCount == travellersList.size()) {
                    System.debug('Data Received in Database! All records inserted successfully');
                    return travellersId;
                    //return 'Data Received in Database! All records inserted successfully';
                } else {
                    System.debug('Data Received in Database!! Some records failed to insert');
                    //Database.rollback(rollbackStartPoint);
                    //System.debug('ROLLBACK CALLED>>');
                    return null;
                    //return 'Data Received in Database!! Some records failed to insert | '+successCount;
                }
            } else{
                System.debug('Data not received in Backend!');
                Database.rollback(rollbackStartPoint);
                System.debug('ROLLBACK CALLED>>');
                return null;
                //return 'Data not received in Backend!';
            }
        }
        catch(exception ex){
            Database.rollback(rollbackStartPoint);
            System.debug('ROLLBACK CALLED>>');
            return null;
             //return 'Error : '+ex.getMessage()+' @@ '+ex.getLineNumber();
        }
    }
}