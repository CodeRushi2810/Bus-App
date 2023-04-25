public class wireDecorator {
    
	@AuraEnabled(cacheable=true)
    public static List<Account> accList(){
        
        List<Account> acc = [SELECT Id, Name FROM Account];
        return acc;
    }
}