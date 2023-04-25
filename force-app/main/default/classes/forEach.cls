public class forEach {
	@auraEnabled(cacheable=true)
    public static List<Account> accList(){
        List<Account> acc = [SELECT Id, Name FROM Account];
        return acc;
    }
}