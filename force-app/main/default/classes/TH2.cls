public  class TH2 {


    // 1. When a new opportunity is created and its Amount is between 100000-500000, then update its description to 'Hot Opportunity'
    
    public static void updateDescription(List<Opportunity> oppList) {
        for(Opportunity opp : oppList){
            if(opp.Amount != null && opp.Amount >= 100000 && opp.Amount <= 500000){
               opp.Description = 'Hot Opportunity'; 
            }
        }
    }



    // 2. When a new opportunity is created, then put the latest opportunity amount in the 'Latest Opportunity Amount' field inside the  Account Object

    public static void populateLatestOppAmt(List<Opportunity> oppList){

        List<Account> accList = new List<Account>();
        
        for(Opportunity opp : oppList){
            //Checking if the new opportunity's amount and account id is not null
            if(opp.Amount != null && opp.AccountId != null){
                // Creating a new account
                Account acc = new Account();
                //Adding the opportunity's id in the new account
                acc.Id = opp.AccountId;
                //Update the account's 'Latest Opportunity Amount'
                acc.Latest_Opp_Amount__c = opp.Amount;
                //Add all the values of the new account inside the 'accList' List
                accList.add(acc);
            }
        }
        //Validation
        if(!accList.isEmpty()){
            update accList;
        }
    }




    // 3. When a new Opportunity is created or existing oportunity is updated, then base on its Stage, update the description with the 'Stage'. Eg. Stage=Closed Won, then update the description with Stage is closed and won.

    public static void updateDescBasedOnStage(List<Opportunity> oppList, Map<Id, Opportunity> OldMap){
        for (Opportunity opp : oppList){

            //This block of code will check if the record is inserted or updated
            //If the oldMap will be null, it means that the record is inserted
            //If the oldMap is not null, it means that the record is updated
            //If the record is updated, we ll check if the stageName is updated

            if(OldMap == null || opp.StageName != OldMap.get(opp.Id).StageName){
                if(opp.StageName == 'Closed Won'){
                    opp.Description = 'Opportunity is closed won';
                }
                else if(opp.StageName == 'Closed Lost'){
                    opp.Description = 'Opportunity is closed lost';
                }
                else{
                    opp.Description = 'Opportunity is Open';
                }
            }
        }
    }




    // 4. When the stage is changed in any opportunity, then create a task record on that opportunity. When the task is created, assign it to the logged in user or the opportunity owner

    public static void createTask(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        
        List<Task> taskList = new List<Task>();
        
        for(Opportunity opp : oppList){
            //Validating if the opportunity's stage name is updated or not
            //oldMap.get(key).record - we are using opp.Id as the key here
            
            if(opp.StageName != oldMap.get(opp.Id).StageName){
                Task tsk = new Task();
                tsk.WhatId = opp.Id;   //Related to which record
                tsk.Subject = 'Demo Task';
                tsk.Status = 'In Progress';
                tsk.Priority = 'High';
                tsk.OwnerId = UserInfo.getUserId();
                taskList.add(tsk);
            }
        }

        if(!taskList.isEmpty()){
            insert taskList;
        }
    }



    //5. Prevent record creation on Opportunity object if the 'Amount' is null

    public static void applyValidation(List<Opportunity> oppList){

        for(Opportunity opp : oppList){
            if(opp.Amount == null){
                opp.addError('Amount field cannot be null');
            }
        }
    }   




    // 6. When Opportunity is updated to Closed Lost and the Closed Lost reason is not populated, then throw a validation error

    public static void populateClosedLostReason(List<Opportunity> oppList, Map<Id,Opportunity> oldMap){

        for(Opportunity opp : oppList){
            
            if(opp.StageName == 'Closed Lost' 
            && opp.StageName != oldMap.get(opp.id).StageName
            && opp.Closed_Lost_Reason__c == null){
                opp.addError('Please Populate Closed Lost Reason');
            }
        }

    }



    //7. When the Account is updated check all opportunities related to the account. Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from today and stage not equal to close won.

    public static void opportunityStageUpdate(List<Account> accList){
        Set<Id> accountIDs = new Set<ID>();

        for(Account acc : accList){
            accountIDs.add(acc.Id);
        }
        //day30 is the date which is 30 days less than today
        Datetime day30 = System.now()-30;

        List<Opportunity> updatedOppList = new List<Opportunity>();
        //getting the opportunities whose account has been updated

        List<Opportunity> oppList = [Select Id, AccountId, StageName, CreatedDate, CloseDate FROM Opportunity WHERE AccountId IN :accountIds];

        if(!oppList.isEmpty()){
            for(Opportunity opp : oppList){
                //checking for condition if created date is greater than 30 days from today and stage not equal to close won
                if(opp.CreatedDate<day30 && opp.StageName !='Closed Won'){
                    opp.StageName = 'Closed Lost';
                    opp.CloseDate = System.today();
                    updatedOppList.add(opp);
                }
            }
        }

        if(!oppList.isEmpty()){
            update updatedOppList;
        }
    }
}