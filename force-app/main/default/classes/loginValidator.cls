public class loginValidator {
	@auraEnabled(cacheable=true)
    
    public static List<custom_User__c> loginInfo (string email , string password){
        List<custom_User__c> validateCredentials = [SELECT Name, Email__c, Password__c FROM custom_User__c WHERE Email__c =: email AND Password__c =: password ];
        if(!validateCredentials.isEmpty()){
			 return validateCredentials;
        }
        return null;
    }
}