@isTest
public class TH2_testClass {



    // 1. When a new opportunity is created and its Amount is between 100000-500000, then update its description to 'Hot Opportunity'
	@isTest
    public static void testClass(){
        //Create data
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(integer i=1 ; i<=5 ; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'TestOpp'+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Discount_Percent__c	= 4;
            opp.Amount = 450000;
			oppList.add(opp);            
        }
        System.Test.startTest();
        insert oppList;
		System.Test.stopTest();     
        
        List<Opportunity> updatedOppList = [SELECT Id, Description FROM Opportunity WHERE Id=: oppList[0].Id];
        
        System.assertEquals('Hot Opportunity', updatedOppList[0].Description);        
    }





    // 2. When a new opportunity is created, then put the latest opportunity amount in the 'Latest Opportunity Amount' field inside the  Account Object

    @isTest
    public static void populateLatestOppAmtTest(){
        List<Account> accList = new List <Account>();
        List<Opportunity> oppList = new List <Opportunity>();

        for(Integer i=1 ; i<=5 ; i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            accList.add(acc);
        }
        insert accList;

        for(Account acc: accList){
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Discount_Percent__c	= 4;
            opp.Amount = 450000;
            opp.AccountId = acc.Id;
			oppList.add(opp); 
        }

        System.test.startTest();
        insert oppList;    
        System.test.stopTest();

        List<Account> updatedAccount = [SELECT Id, Latest_Opp_Amount__c FROM Account WHERE Id =: accList[0].Id];

        system.assertEquals(oppList[0].Amount, updatedAccount[0].Latest_Opp_Amount__c);
    }





    // 3. When a new Opportunity is created, update the description with the 'Stage'

    @isTest
    public static void updateDescBasedOnStageInsertTest(){
        
        //Create data
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(integer i=1 ; i<=5 ; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'TestOpp'+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Discount_Percent__c	= 4;
            opp.Amount = 450000;
			oppList.add(opp);            
        }
        System.Test.startTest();
        insert oppList;
		System.Test.stopTest();  
    
        List<Opportunity> updatedOppList = [SELECT Description FROM Opportunity WHERE Id =: oppList[0].Id];
        
        System.assertEquals('Opportunity is Open', updatedOppList[0].Description);

    }

    // 3. When an Opportunity is updated, update the description with the 'Stage'

    @isTest
    public static void updateDescBasedOnStageUpdateTest(){
        
        //Create data
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(integer i=1 ; i<=5 ; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'TestOpp'+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Discount_Percent__c	= 4;
            opp.Amount = 450000;
			oppList.add(opp);            
        }
        System.Test.startTest();
        insert oppList;

        for(Opportunity opp : oppList){
            opp.StageName = 'Closed Won';
        }
        
        update OppList;

		System.Test.stopTest();  
    
        List<Opportunity> updatedOppList = [SELECT Description FROM Opportunity WHERE Id =: oppList[0].Id];
        
        System.assertEquals('Opportunity is closed won', updatedOppList[0].Description);

    }




    // 4. When the stage is changed in any opportunity, then create a task record on that opportunity. When the task is created, assign it to the logged in user or the opportunity owner

    @isTest
    public static void createTaskTest(){

        //Create data
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(integer i=1 ; i<=5 ; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'TestOpp'+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Discount_Percent__c	= 4;
            opp.Amount = 450000;
			oppList.add(opp);            
        }

        System.Test.startTest();

        insert oppList;

        for(Opportunity opp : oppList){
            opp.StageName = 'Value Proposition';
        }
        update oppList;
        
        List<Task> taskList = [SELECT Id FROM Task WHERE WhatId =: oppList[0].id];

        system.assertEquals(1, taskList.size());
    }




    // 5. Prevent record creation on Opportunity object if the 'Amount' is null

    @isTest
    public static void applyValidationTest(){

        //Create data
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(integer i=1 ; i<=5 ; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'TestOpp'+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Discount_Percent__c	= 4;
			oppList.add(opp);            
        }

        System.Test.startTest();
        Boolean exceptionThrown = False;

        try {
            insert oppList;
        } catch (Exception e) {
            exceptionThrown = true;
            Boolean expectedExceptionThrown 
            = (e.getMessage().contains('Amount field cannot be null'))?true:false;
            System.assertEquals(true, expectedExceptionThrown, e.getMessage());
        }

        System.Test.stopTest();
    }





    // 6. When Opportunity is updated to Closed Lost and the Closed Lost reason is not populated, then throw a validation error

    @isTest
    public static void populateClosedLostReasonTest(){

        //Create data
        
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(integer i=1 ; i<=5 ; i++){
            Opportunity opp = new Opportunity();
            opp.Name = 'TestOpp'+i;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.Amount = 50000;
            opp.Discount_Percent__c	= 4;
			oppList.add(opp);            
        }

        System.Test.startTest();
        
        insert oppList;

        try{
            for(Opportunity opp : oppList){
                opp.StageName = 'Closed Lost';
            }
            update oppList;
        } 
        catch (Exception e) {
            Boolean expectedExceptionThrown 
            = (e.getMessage().contains('Please Populate Closed Lost Reason'))?true:false;
            System.assertEquals(true, expectedExceptionThrown, e.getMessage());
        }

        System.Test.stopTest();
    }


}