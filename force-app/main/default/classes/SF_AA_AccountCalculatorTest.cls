@isTest
public class SF_AA_AccountCalculatorTest {
    @isTest
    public static void myMethod() {
         List<Account> accList = new List<Account>();

         for(integer i=0 ; i<250 ; i++){
            accList.add(new Account(Name='Test'+i));
         }
 
         insert accList;

         List<Contact> conList = new List<Contact>();
         
         List<Id> accIds = new List<Id>();

         for(Account acc : accList){
            conList.add(new Contact(FirstName='Hey', LastName=acc.Name, AccountId=acc.Id));
            accIds.add(acc.Id);
        }
        insert conList;

        System.Test.startTest();
        SF_AA_AccountCalculator.myMethod(accIds);
        System.Test.stopTest();

        List<Account> accs = [SELECT Id, Number_of_contacts__c FROM Account];
        system.assertEquals(1, accs[0].Number_of_contacts__c, 'Contacts are not counted succesfully');
    }
}