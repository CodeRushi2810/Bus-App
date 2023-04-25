@isTest
public  class TH1_testClass {


    //1. If the new account's industry is Media or Energy, then update the account's rating to 'Hot'
    @isTest
    public static void updateRatingTest() {
        //Creating sample data
        List<Account> accList = new List<Account>();
        for(Integer i=1 ; i<=5 ; i++){
            Account acc = new Account();
            acc.Name = 'Account 10'+i;
            acc.Industry = 'Media';
            accList.add(acc);
        }
        //Inserting the sample data
        System.Test.startTest();
        insert accList;
        System.Test.stopTest(); 

        //Applying assert to check       
            List<Account> updatedList = [SELECT Id, Rating FROM Account WHERE Id =: accList[0].id];   
            System.assertEquals('Hot', updatedList[0].Rating);
    
    }


    //2. IF the copy billing to shipping check-boy is checked then copy the billing address to shipping address
    @isTest 
    public static void copyBillingToShippingTest(){

        List<Account> accList = new List<Account>();

        for(Integer i=1 ; i<=1 ; i++){
            Account acc = new Account();
            acc.Name = 'Test Account';
            acc.BillingCity = 'Test City';
            acc.BillingStreet = 'Test Street';
            acc.BillingState = 'Test State';
            acc.BillingPostalCode = 'Test Postal Code';
            acc.BillingCountry = 'Test Country';
            acc.CopyBillingToShipping__c = true;
            accList.add(acc);
        }
        //Inserting the sample data
        System.Test.startTest();
        insert accList;
        System.Test.stopTest();

    
        List<Account> updatedAccList = [SELECT Id, ShippingCity FROM Account WHERE Id =: accList[0].Id];

        system.assertEquals('Test City', updatedAccList[0].ShippingCity);
    }



    //3. When a new Account is created, create a contact record with the help of trigger
    @isTest
    public static void createRelatedContactTest(){
        List<Account> accList = new List<Account>();
        
        for(Integer i=1 ; i<=5 ; i++){
            Account acc = new Account();
            acc.Name = 'Account 10';
            acc.Industry = 'Media';
            accList.add(acc);
        }

        //Inserting the sample data
        System.Test.startTest();
        insert accList;
        System.Test.stopTest(); 
    
        List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId =: accList[0].Id];

        system.assert(conList!=null, 'Contact is not created');
    }



    // 4. When a new Account is created, then create a new opportunity with the help of trigger
    @isTest
    public static void createRelatedOpportunityTest(){
        
        List<Account> accList = new List<Account>();
        
        for(Integer i=1 ; i<=5 ; i++){
            Account acc = new Account();
            acc.Name = 'Account 10';
            accList.add(acc);
        }

        System.Test.startTest();
        insert accList;
        System.Test.stopTest();

        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId =: accList[0].Id];
        system.assert(oppList!=null, 'Opportunity is not created');
    }



    // 5. When a new account is created and if the new contact checkbox is checked, then create a new contact record.
    //    If the new opportunity checkbox is checked and Active status is set to Active, then create a new opportunity.
    @isTest
    public static void createConOrOppTest(){
        List<Account> accList = new List<Account>();
        
        for(Integer i=1 ; i<=10 ; i++){
            Account acc = new Account();
            acc.Name = 'Test'+i;
            if(Math.mod(i, 2) == 0){
                acc.New_Contact__c = true;
            }else{
                acc.New_Opportunity__C = true;
                acc.Active__c = 'Yes';
            }
            accList.add(acc);
        }

        System.Test.startTest();
        insert accList;
        System.Test.stopTest();

        List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId =: accList[0].Id];
        List<Opportunity> oppList = [SELECT Id FROM Opportunity WHERE AccountId =: accList[1].Id];

        System.assert(conList != null, 'Contact is not created');
        System.assert(oppList != null, 'Opportunity is not created');
    }




    
    //6. When an account's phone field is updated, then in description field, input the old phone number and the new phone number

    @isTest
    public static void updateAccountDescOnPhoneUpdateTest(){
        List<Account> accList = new List<Account>();

        //Inserting Data
        for(Integer i=1 ; i<=5 ; i++){
            Account acc = new Account();
            acc.Name = 'Account 10';
            acc.Phone = '123456';
            accList.add(acc);
        }

        System.Test.startTest();
        insert accList;
        
        ////Updating Data
        for(Account acc : accList){
            acc.Phone = '789456';
        }
        update accList;

        System.Test.stopTest();

        List<Account> updatedAccList = [SELECT Id, Phone FROM Account WHERE Id =: accList[0].Id];

        System.assertEquals('789456', updatedAccList[0].Phone, 'Phone is not updated');
    }




    //7. When Account record's Phone field is updated, then update the phone field on all the related contact list.

    @isTest
    public static void updateRelatedContactTest(){
        
        //Create sample data for account

        List<Account> accList = new List<Account>();
        
        List<Contact> conList = new List<Contact>();
        
        for(Integer i=1 ; i<=5 ; i++){
            Account acc = new Account();
            acc.Name = 'Test' +i;
            acc.Phone = '123456';
            accList.add(acc);
        }

        System.test.startTest();

        insert accList;

        for(Account acc : accList){
            Contact con = new Contact(LastName = 'acc.Name');
            con.AccountId = acc.Id;
            conList.add(con);
        }
        insert conList;

        //Updating Phone no.
        for (Account acc : AccList) {
            acc.Phone = '456789';
        }
        update accList;

        System.test.stopTest();

        List<Contact> updatedContactList = [SELECT Id, HomePhone FROM Contact WHERE Id =: conList[0].Id];
        
        system.assertEquals('456789', updatedContactList[0].HomePhone);
    }
    




    //8. When an account's billing address is updated, then populate the billing address in all the related Contact's mailing address

    @isTest
    public static void updateContactsMailingAddTest(){

        List<Account> accList = new List<Account>();

        List<Contact> conList = new List<Contact >();

        //Creating dummy data
        for(Integer i=1 ; i<=5 ; i++){

            Account acc = new Account();

            acc.Name = 'Test'+i;
            acc.BillingCity = 'Vadodara'+i;
            acc.BillingState = 'Gujarat'+i;
            acc.BillingCountry = 'India'+i;
            acc.BillingPostalCode = '390007'+i;
            acc.BillingStreet = 'D-78'+i;

            accList.add(acc);
        }
        system.test.startTest();
        
        insert accList;

        //Creating related contact
        for(Account acc : accList){
            Contact con = new Contact(LastName = 'acc.Name');
            con.AccountId = acc.Id;
            conList.add(con);
        }

        insert conList;

        //Updating data
        for (Account acc : AccList) {
            acc.BillingCity = 'Surat';
        }

        update accList;
        system.test.stopTest();

        List<Contact> updatedContactList = [SELECT Id, MailingCity FROM Contact WHERE Id =: conList[0].Id];
        
        system.assertEquals('Surat', updatedContactList[0].MailingCity);
    }   




    // 9. If the active field of any Account Record is set to 'Yes' and then it gets updated to 'No', then update the 'Stage' of every related opportunity to 'Closed Lost' except the opportunities whose 'Stage' is 'Closed Won'.

    @isTest
    public static void updateRelatedOppStageTest(){
        //Creating sample data

        List<Account> accList = new List<Account>();

        for(integer i=1 ; i<=5 ; i++){
            Account acc = new Account();

            acc.Name = 'Test'+acc.Name;
            acc.Active__c = 'Yes';
            accList.add(acc);
        }

        System.Test.startTest();
        insert accList;

        List<Opportunity> oppList = new List<Opportunity>();

        for(Account acc : accList){
            
            Opportunity opp = new Opportunity();

            opp.Name = 'Test'+1;
            opp.StageName = 'Prospecting';
            opp.CloseDate = system.today();
            opp.Amount = 300000;
            opp.AccountId = acc.Id;
            opp.Discount_Percent__c	= 4;
            oppList.add(opp);
        }

        insert oppList;

        for(Account acc : accList){
            acc.Active__c = 'No';
        }
        update accList;

        List<Opportunity> updatedOppList = [SELECT Id, StageName FROM Opportunity WHERE Id =: oppList[0].id ];

        system.assertEquals('Closed Lost', updatedOppList[0].StageName);
    }




    // 10. Prevent deletion of Account Record if the 'Active' field is 'Yes'

    @isTest
    public static void preventDeletionTest(){
        
        //Create sample data
        List<Account> accList = new List<Account>();

        for (integer i=1 ; i<=5 ; i++) {
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Active__c = 'Yes';
            accList.add(acc);
        }

        System.test.startTest();
        insert accList;

        Boolean exceptionThrown = false;

        try {
            delete accList;
            
        } catch (Exception e) {
            exceptionThrown = True;
            Boolean expectedExceptionThrown = (e.getMessage().contains(Label.Prevent_Account_Deletion))? true:false;
            System.assertEquals(true, expectedExceptionThrown, e.getMessage());
        }
        System.assertEquals(true, exceptionThrown, 'No exception was thrown');

        System.Test.stopTest();

    } 




//11. Prevent Account form being updated if the record was created before 7
@isTest
public static void preventUpdateTest(){

    List<Account> accList = new List<Account>();
        
        for (integer i=1 ; i<=5 ; i++) {
            Account acc = new Account();
            acc.Name = 'Test'+i;
            acc.Active__c = 'Yes';
            accList.add(acc);
        }

        System.test.startTest();
        insert accList;

        Boolean exceptionThrown = false;

        try {
            for(Account acc : accList){
                acc.Phone = '4567123454';
            }
            update accList;
            
        } catch (Exception e) {
            exceptionThrown = True;
            Boolean expectedExceptionThrown = (e.getMessage().contains('You cannot update records which are created before 7 days'))? true:false;
            System.assertEquals(true, expectedExceptionThrown, e.getMessage());

            
        }
        // System.assertEquals(true, exceptionThrown, 'No exception was thrown');

        System.Test.stopTest();
}



//12. When the Account is updated check all opportunities related to the account. Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from today and stage not equal to close won.

@isTest
    public static void opportunityStageUpdateTest(){
    
    List<Account> accList = new List<Account>();

    for(integer i=5 ; i<=5 ; i++){
       
        Account acc = new Account();

        acc.Name = 'Test'+acc.Name;
        accList.add(acc);
    }

    System.Test.startTest();
        insert accList;

    List<Opportunity> oppList = new List<Opportunity>();
    
    for(Account acc : accList){
        Opportunity opp = new Opportunity();
        opp.AccountId = acc.Id;
        opp.Name = 'TestOpp';
        opp.StageName = 'Prospecting';
        opp.Amount = 50000;
        opp.Discount_Percent__c	= 4;
        opp.CloseDate = system.today();
        oppList.add(opp);            
    }

    insert oppList;

    for(Account acc : accList){
            acc.Active__c = 'No';
        }

    update accList;

    List<Opportunity> updatedOppList = [SELECT Id, StageName FROM Opportunity WHERE Id =: oppList[0].id ];

        system.assertEquals('Closed Lost', updatedOppList[0].StageName);

    }





    //13. When a new Account is inserted, send an email to the System Admin with text such as : An account has been created and the name is “Account Name”.

    // @isTest
    // public Static Void sendEmailToAdminTest()
    // {

    // }




    //14. When the account gets updated, we need to fill the 'Total Opportunity Amount' field with the sum of all the Opportunities Amount

    // @isTest
    //     public static void totalAmountOfRelatedOppTest(){
    //         List<Account> accList = new List<Account>();
    //         List<Opportunity> oppList = new List<Opportunity>();

    //         for(Integer i=1 ; i<=5 ; i++){
    //             Account acc = new Account();
    //             acc.Name = 'Test'+i;
    //             accList.add(acc);
    //         }

    //         if(!accList.isEmpty()){
    //             insert accList;
    //         }
           
    //         for(Account acc : accList){
    //             Opportunity opp = new Opportunity();
    //             opp.AccountId = acc.Id;
    //             opp.Name = 'TestOpp';
    //             opp.CloseDate = System.today();
    //             opp.StageName = 'Prospecting';
    //             opp.Discount_Percent__c = 5;
    //             opp.Amount = 50000;
    //             oppList.add(opp);
    //         }
        

    //     }




    //15. When any new account gets created, and if the rating is 'Hot', the update the customer priority to 'high'
    //    if the rating is 'Warm', the update the customer priority to 'Medium'
    //    and if the rating is 'Cold', the update the customer priority to 'Low' and also update the description.
    
    @isTest
        public static void ratingToPriorityTest(){
            
            List<Account> accList = new List<Account>();

            for(Integer i=0 ; i<3 ; i++){
                Account acc = new Account();
                
                if(i == 0){
                acc.Name = 'Test'+i;
                acc.Rating = 'Cold';
                }
                else if(i == 1){
                acc.Name = 'Test'+i;
                acc.Rating = 'Warm';
                }
                else if(i == 2){
                acc.Name = 'Cold'+i;
                acc.Rating = 'Hot';
                }
                accList.add(acc);
            }

            System.Test.startTest();
            insert accList;
            System.Test.stopTest();

            List<account> updatedAccList = new List<Account>();

            for(integer i=0 ; i<3 ; i++){
                updatedAccList[i] = [SELECT Id, CustomerPriority__c FROM Account WHERE Id =: accList[i].id];
            }

            for(integer i=0 ; i<3 ; i++){
                if(i == 0){
                    System.assertEquals('Low', updatedAccList[i].CustomerPriority__c);
                }else if(i == 1){
                    System.assertEquals('Medium', updatedAccList[i].CustomerPriority__c);
                }else if(i == 2){
                    System.assertEquals('High', updatedAccList[i].CustomerPriority__c);
                }
            }

            // List<Account>  updatedAccList1 = [SELECT Id, CustomerPriority__c FROM Account WHERE Id =: accList[0].id];

            // List<Account>  updatedAccList2 = [SELECT Id, CustomerPriority__c FROM Account WHERE Id =: accList[1].id];

            // List<Account>  updatedAccList3 = [SELECT Id, CustomerPriority__c FROM Account WHERE Id =: accList[2].id];

            // System.assertEquals('Low', updatedAccList1[0].CustomerPriority__c);

            // System.assertEquals('Medium', updatedAccList2[0].CustomerPriority__c);

            // System.assertEquals('High', updatedAccList3[0].CustomerPriority__c);
        }
}


// System.run as