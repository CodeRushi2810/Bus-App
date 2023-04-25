public class getWalletAmount {
	@AuraEnabled(cacheable = true)
    public static Decimal walletBalance(Id userId){
        List<Account> userAccount = [SELECT Id, Name, Wallet_Amount__c FROM Account WHERE Id =: userId];
        
        Decimal Balance = userAccount[0].Wallet_Amount__c;
        system.debug('Balance : '+Balance);
        return Balance;
    }
}