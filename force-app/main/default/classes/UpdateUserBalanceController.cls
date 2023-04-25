/*	
*   @Class Name 	: 	UpdateUserBalanceController
*	@Description 	:	Updates the balance of the User's account after successful transaction
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/

public without sharing class UpdateUserBalanceController {
    @AuraEnabled(Cacheable = false)
    public static string updateBalance(Id userId , Decimal fare){
        
        List<Account> userAccount = [SELECT Wallet_Amount__c FROM Account WHERE Id =: userId];
        List<Account> updatedBalanceOfUser = new List<Account>();
        system.debug('Balance before transaction : ' + userAccount[0].Wallet_Amount__c);
        
        for(Account loggedInUser : userAccount){
            loggedInUser.Wallet_Amount__c = loggedInUser.Wallet_Amount__c - fare;
            updatedBalanceOfUser.add(loggedInUser);
        }   
        
        
        
        if(!updatedBalanceOfUser.isEmpty()){
            update updatedBalanceOfUser;
            system.debug('Updated Successfully');
            return 'Transaction Successfull';
        }else{
            system.debug('Nothing is there to update');
            return 'Transaction Failed';
        }
    }    
}