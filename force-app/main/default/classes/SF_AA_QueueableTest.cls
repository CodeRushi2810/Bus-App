@isTest

public class SF_AA_QueueableTest{

    @TestSetup
    static void setup(){

        List<Account> accList = new List<Account>();

        Account parentAccount = new Account();
        parentAccount.Name = 'Parent Account';

        accList.add(parentAccount);

        for(integer i=0 ; i<100 ; i++){
            Account acc = new Account();
            acc.Name = 'Test Account'+i;
            accList.add(acc);
        }

        insert accList;
    }
   

    @isTest
    private static void  testQueueable(){
    
        Id parentId = [SELECT Id FROM Account WHERE Name = 'Parent Account'][0].id;

        List<Account> accList = [SELECT Id, Name FROM Account WHERE Name LIKE 'Test Account%'];

        SF_AA_Queueable updateJob = new SF_AA_Queueable(accList, parentId);
        System.Test.StartTest();
        System.enqueueJob(updateJob);
        System.Test.stopTest();

        System.assertEquals(100, [SELECT count() FROM Account WHERE ParentId = :parentId]);
    }
}