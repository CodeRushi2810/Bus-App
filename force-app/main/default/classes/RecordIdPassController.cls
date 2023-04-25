public class RecordIdPassController {
	@AuraEnabled(cacheable = true)
    public static List<Account> myList (Id recordId){
        return [SELECT Name, Id FROM Account WHERE Id =: recordId];
    }
}