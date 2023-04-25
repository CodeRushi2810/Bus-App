public class imperativeMethod {
    @auraEnabled
    public static List<Account> accList(){
 		List<Account> acc = [SELECT Id, Name FROM Account];       
        return acc;
    }
}