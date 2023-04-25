public without Sharing class AddMoneyToWallet {
    @AuraEnabled(Cacheable = false)
    public static Decimal updateBalance(Id userId , Decimal amount){
        
        Account userAccount = [SELECT Wallet_Amount__c FROM Account WHERE Id =: userId];
        
        Decimal userBalance;
        
        userBalance = userAccount.Wallet_Amount__c + amount;
        
        userAccount.Wallet_Amount__c = userBalance;
        
        Database.SaveResult updateResult = Database.update(userAccount, false);     

        if (updateResult.isSuccess()) {
            System.debug('Amount added successfully');
            return userBalance;
        } else {
            for (Database.Error error : updateResult.getErrors()) {
                System.debug('Transaction Failed ' + error.getMessage());
            }
            return null;
        }
    }    
}