public class SF_sObjects{
    public static void standard_sObjects(){
        //Standard sObjects
        Account acc1 = new Account(); //First way
        acc1.Name = 'test';
        acc1.Phone = '123456';
        system.debug(acc1);
        
        Account acc2 = new Account(Name='test2',Phone='789456'); //Second way
        Account acc3 = new Account(Name='test3',Phone='741258');
        system.debug(acc2);
        system.debug(acc3);
    }

    public static void custom_sObjects(){
        //Custom sObjects - we must use the api name which is like 'account__c'
        
        Task__c task1 = new Task__c(); //First way
        task1.Name = 'Scrum Meeting';
        task1.Task__c = 'Interact with the grads and take daily updates';

        Task__c task2 = new Task__c(Name = 'Sprint 1', Task__c = 'Take feedback from the clients and apply the necessary changes'); //Second way

        system.debug(task1);
        system.debug(task2);
    }


    public static void generic_sObjects(){
        SObject myObj;

        myObj = new Task__c(Name = 'Sprint 2', Task__c = 'Provide updates');
        Task__c task4 = (Task__c)myObj;
        system.debug('Task : ' + task4);

    }
}