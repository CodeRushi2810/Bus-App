public class SF_AA_AccountCalculator{
    @future
    public static void myMethod(List<Id> accIds){
        List<Account> accList = [SELECT Id, (SELECT Id FROM Contacts) FROM Account WHERE Id IN: accIds];

        for(Account acc: accList){
            acc.Number_of_contacts__c = acc.Contacts.size();
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
}