/*	
*   @Class Name 	: 	GetCurrentUserAccountId
*	@Description 	:	This controller is used to get the account Id of the Logged In User
*   @Author Name 	:	Rushi Patel (Horizontal Digital)
*/

public class GetCurrentUserAccountId {
	@AuraEnabled(cacheable = true)
    public static Id getUserId(){
        Id userId = UserInfo.getUserId();
        User currentUser = [SELECT Id, AccountId FROM User WHERE Id =: userId];
       	system.debug('User Id : '+currentUser.AccountId);
        return currentUser.AccountId;
    }
}