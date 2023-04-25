public class dreamTeamLogin {
	@AuraEnabled
  public static Boolean checkLogin(String username, String password) {
      
    // Add your logic for checking the username and password against your Salesforce org here
    // For this example, return true if the username is "admin" and the password is "admin"
    List<Candidate__c> getPass = [SELECT First__c FROM Candidate__c WHERE userName__c =: username AND Password__c =: password];
    if (!getPass.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }
}