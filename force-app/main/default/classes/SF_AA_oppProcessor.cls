public class SF_AA_oppProcessor implements Database.Batchable<SObject>, Database.stateful{
    
    //Every Batch class need to have three methods.
    /*
    1. Start method
    2. Execute method
    3. Finish method
    */

    //We are using Database.stateful so that once a new batch starts, the record count does not gets reset
    public integer recordCount = 0;


    //Doubt -- 
    /*
    For example, i have 1000 records in opportunity object, 
    
    So if I use a batchable method, will all the records be queried at once in the start method and then passed as a batch of 100 to the execute method 
    OR
    The records will be queried in the batch of 100 and this operation will be done 10 times???


    */


    //In start method, we query the data on which we want to perform the operations and store it in a List. And the with the help of return statement we send the queried data to the 'EXECUTE' method.
    public Database.QueryLocator start(Database.BatchableContext bc){
        // List<Opportunity> oppList = [SELECT Id, Name FROM Opportunity];

        return Database.getQueryLocator([SELECT Id, Name FROM Opportunity]);
    }



    //The oppList which we returned will be received in the execute method in the 'receivedOppList', and we can then perform our operations on that list
    public void execute(Database.BatchableContext bc, List<Opportunity> receivedOppList){
        for(Opportunity op : receivedOppList){
            op.LeadSource = 'Web';
            op.CloseDate = system.today();
            op.Name = 'Test';
            op.StageName = 'Prospecting';
            op.Discount_Percent__c = 4;
        }

        update receivedOppList; 
        recordCount = recordCount + receivedOppList.size();
    }



    //The 'finish' method is used to do the post operations like sending messages or emails about the completion of the task 
    public void finish(Database.BatchableContext bc){
        System.debug('Total records Processed : ' + recordCount);
    }
} 





//How to execute!!

/*

SF_AA_oppProcessor oppProcess = new SF_AA_oppProcessor();
Id batchId = Databse.executeBatch(oppProcess);

*/


//How to divide the records in batches!!
//We will pass one more parameter in the method
/*

SF_AA_oppProcessor oppProcess = new SF_AA_oppProcessor();
Id batchId = Databse.executeBatch(oppProcess, 10);

*/