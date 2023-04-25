/*

public without sharing class CancelBooking {
@AuraEnabled(cacheable = false)
public static String cancelTicket(Id seatId){
Savepoint rollbackStartPoint = Database.setSavepoint();
Passenger_Journey__c ticket = [SELECT Id, Passenger_Id__r.Name, Passenger_Id__c, Bus_Id__r.Name, Total_Fare__c FROM Passenger_Journey__c WHERE Seat__c =: seatId];

Decimal refundAmount = ticket.Total_Fare__c;
Id PassengerId = ticket.Passenger_Id__c;

Account userAccount = [SELECT Id, Wallet_Amount__c FROM Account WHERE Id =: PassengerId];
Decimal userBalance = userAccount.Wallet_Amount__c;

system.debug('Ticket : ' +ticket);
system.debug('Refund Amount : ' + refundAmount);
system.debug('Wallet Amount : ' + userBalance);

//Updates the seat Status
Seat__c seatToUpdate = [SELECT Id, Status__c FROM Seat__c WHERE Id =: seatId];
seatToUpdate.Status__c = false;

Database.SaveResult result = Database.update(seatToUpdate, false);
if(result.isSuccess()){
System.debug('Ticket Cancelled Successfully');

userAccount.Wallet_Amount__c = userBalance+refundAmount;
Database.SaveResult refundStatus = Database.update(userAccount, false);
if(refundStatus.isSuccess()){
system.debug('Refund Processed Successfully');

Passenger_Journey__c deleteRecord = [SELECT Id FROM Passenger_Journey__c WHERE Seat__c =: seatId];
Database.DeleteResult deleteRecordStatus = Database.delete(deleteRecord, false);
if(deleteRecordStatus.isSuccess()){
system.debug('Record Deleted Successfully');
}else{
Database.rollback(rollbackStartPoint);
System.debug('ROLLBACK CALLED>>');
system.debug('Record Deletion Failed');
}

}else{
system.debug('Refund Failed');
Database.rollback(rollbackStartPoint);
System.debug('ROLLBACK CALLED>>');
}
return 'Ticket Cancelled Successfully';
}else{
System.debug('Ticket Cancellation Failed');
return 'Ticket Cancellation Failed';
}        
}
}

*/

public without sharing class CancelBooking {
    @AuraEnabled(cacheable = false)
    public static String cancelTicket(List<Id> PJSIds){
        Savepoint rollbackStartPoint = Database.setSavepoint();
        List<Passenger_Journey_Seat__c> PJSList = [SELECT Id, Name, Passenger_Journey__c, Seat__c FROM Passenger_Journey_Seat__c WHERE Id IN : PJSIds];
        
        //Ids of the seats which are to be cancelled
        List<Id> seatIds = new List<Id>();
        
        for(Passenger_Journey_Seat__c pjsId : PJSList){
            seatIds.add(pjsId.Seat__c);
            system.debug(pjsId);
        }
        for(Id seatId : seatIds){
            system.debug('Seat Id : '+seatId);
        }
        //Journey Id
        Id journeyId = PJSList[0].Passenger_Journey__c;
        Passenger_Journey__c journeyDetails = [SELECT Id, Name, Total_Fare__c, Start_Time__c FROM Passenger_Journey__c WHERE Id =: journeyId];
        
        DateTime journeyStartTime = journeyDetails.Start_Time__c;
        DateTime currentDateTime = DateTime.now();
        Decimal totalFare = journeyDetails.Total_Fare__c;
        Decimal refundAmount;
        
        Decimal timeDifference = (journeyStartTime.getTime() - currentDateTime.getTime()) / (1000*60*60);
        
        if(timeDifference > 48){
            refundAmount = totalFare*0.85;
        } else if(timeDifference > 24){
            refundAmount = totalFare*0.5;
        } else if(timeDifference > 6){
            refundAmount = totalFare*0.4;
        } else{
            refundAmount = 0;
        }
        
        system.debug('Total Fare : '+totalFare);
        system.debug('Journey ID : '+journeyId);
        
        List<Bus_Itinerary_Seat__c> seatsToBeCancelled = new List<Bus_Itinerary_Seat__c>();
        
        for(Id seat : seatIds){
            Bus_Itinerary_Seat__c cancelSeat = [SELECT Id, Name, Status__c FROM Bus_Itinerary_Seat__c WHERE Id =: seat];
            seatsToBeCancelled.add(cancelSeat);
        }
        for(Bus_Itinerary_Seat__c seatData : seatsToBeCancelled){
            system.debug('Seat Id : '+seatData.Id+' | Seat Name : '+seatData.Name+' | Seat Status : '+seatData.Status__c);
        }
        
        List<Bus_Itinerary_Seat__c> updatedSeatList = new List<Bus_Itinerary_Seat__c>();
        system.debug('Seat Updation Opertation Started');
        for(Bus_Itinerary_Seat__c seat : seatsToBeCancelled){
            seat.Status__c = 'Available';
            updatedSeatList.add(seat);
        }
        system.debug('Seat Updation Opertation Completed');
        for(Bus_Itinerary_Seat__c seatData : updatedSeatList){
            system.debug('Seat Id : '+seatData.Id+' | Seat Name : '+seatData.Name+' | Seat Status : '+seatData.Status__c);
        }
        
        List<Database.SaveResult> updateStatus = Database.update(updatedSeatList, false);
        
        Integer successCount = 0;
        for (Database.SaveResult result : updateStatus) {
            if (result.isSuccess()) {
                successCount++;
            } else {
                for (Database.Error error : result.getErrors()) {
                    System.debug('Error inserting record. Message: ' + error.getMessage());
                    Database.rollback(rollbackStartPoint);
                    System.debug('ROLLBACK CALLED>>');
                }
            }
        }
        
        if(successCount == updatedSeatList.size()){
            system.debug('Seat Status Updated Successfully in Database');
            
            Id userId = UserInfo.getUserId();
            User currentUser = [SELECT Id, AccountId FROM User WHERE Id =: userId];
            userId = currentUser.AccountId;
            
            //Id userId = '0015g000018A7ECAA0';
            Account userAccount = [SELECT Id, Wallet_Amount__c FROM Account WHERE Id =: userId];
            Decimal userBalance = userAccount.Wallet_Amount__c;
            
            system.debug('User Account Wallet Balance : '+userBalance);
            userAccount.Wallet_Amount__c = userAccount.Wallet_Amount__c + refundAmount;
            
            Database.SaveResult refundStatus = Database.update(userAccount, false);
            if(refundStatus.isSuccess()){
                system.debug('Refund Processed Successfully');
                system.debug('Updated User Wallet Balance : '+userAccount.Wallet_Amount__c);
                
                Passenger_Journey__c deleteJourney = [SELECT Id FROM Passenger_Journey__c WHERE Id =: journeyId];
                Database.DeleteResult deleteJourneyStatus = Database.delete(deleteJourney, false);
                
                if(deleteJourneyStatus.isSuccess()){
                    system.debug('Journey Deleted Successfully');
                    List<Passenger_Journey_Seat__c> deleteJourneySeatRecords = [SELECT Id FROM Passenger_Journey_Seat__c WHERE Id IN : PJSIds];
                    
                    List<Database.DeleteResult> recordsDeleteStatus = Database.delete(deleteJourneySeatRecords, false);
                    
                    Integer deleteCount = 0;
                    for (Database.DeleteResult result : recordsDeleteStatus) {
                        if (result.isSuccess()) {
                            deleteCount++;
                        } else {
                            system.debug('Journey Record Deletion Failed');
                            Database.rollback(rollbackStartPoint);
                            System.debug('ROLLBACK CALLED>>');
                        }
                    }
                    if(deleteCount == deleteJourneySeatRecords.size()){
                        system.debug('All Journey Records Deleted Successfully');
                        return 'Tickets Cancelled Successfully';
                    }else{
                        system.debug('Failed To Delete Some or All Journey Records');
                        Database.rollback(rollbackStartPoint);
                        System.debug('ROLLBACK CALLED TO RETRIEVE DATA>>');
                        return 'Ticket Cancellation Failed';
                    }
                    
                }else{
                    system.debug('Journey Deletion Failed');
                    Database.rollback(rollbackStartPoint);
                    System.debug('ROLLBACK CALLED>>');
                    return 'Ticket Cancellation Failed';
                }
                
            }else{
                system.debug('Refund Failed');
                Database.rollback(rollbackStartPoint);
                System.debug('ROLLBACK CALLED>>');
                return 'Ticket Cancellation Failed';
            }
        }
        else{
            system.debug('Seat Status Updation Failed');
            Database.rollback(rollbackStartPoint);
            System.debug('ROLLBACK CALLED>>');
            return 'Ticket Cancellation Failed';
        }
    }
}