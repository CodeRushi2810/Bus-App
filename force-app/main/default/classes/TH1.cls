public  class TH1 {

    //1. If the new account's industry is Media or Energy, then update the account's rating to 'Hot'

    //Passing values in this method
    public static void updateRating(List<Account> accList) {
    //Iterating the new records from accList into acc one by one
        for(Account acc : accList){
    //Using condition statement, we ll check if the new account's industry is 'media' or 'Energy'        
            if(acc.Industry == 'Media' || acc.Industry == 'Energy'){
    //If condition gets true, we ll update that account's rating to 'Hot'
                acc.Rating = 'Hot';
            }
        }
    }



    //2. IF the copy billing to shipping check-boy is checked then copy the billing address to shipping address

    public static void copyBillingToShipping(List<Account> accList){
        for(Account acc : accList){
            // CopyBillingToShipping__c is the check box value
            if (acc.CopyBillingToShipping__c && acc.BillingCity != null) {
                acc.ShippingStreet = acc.BillingStreet;
                acc.ShippingCity = acc.BillingCity;
                acc.ShippingState = acc.BillingState;
                acc.ShippingPostalCode = acc.ShippingPostalCode;
                acc.ShippingCountry = acc.BillingCountry;
            }
        }
    }



    //3. When a new Account is created, create a contact record with the help of trigger

    public static void createRelatedContact(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            Contact con = new Contact();
            con.FirstName = 'Thomas';
            con.LastName = 'Shelby';
            con.AccountId = acc.Id;
            conList.add(con);
        }
        if (!conList.isEmpty()) {
            insert conList;
        }
    }



    //4. When a new Account is created, then create a new opportunity with the help of trigger

    public static void createRelatedOpportunity(List<Account> accList){
        
        List<Opportunity> oppList = new List<Opportunity>();

        for (Account acc : accList) {
            
            Opportunity opp = new Opportunity();
            opp.Name = acc.Name;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            opp.AccountId = acc.Id;
            opp.Discount_Percent__c = 4;
            oppList.add(opp);
        }
        if(!oppList.isEmpty()){
            insert oppList;
        }
    }


    // 5. When a new account is created and if the new contact checkbox is checked, then create a new contact record.
    //    If the new opportunity checkbox is checked and Active status is set to Active, then create a new opportunity.

    public static void createConOrOpp(List<Account> accList){
        List<Contact> conList = new List<Contact>();
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account acc : accList){
            //Contact
            if(acc.New_Contact__c){
                Contact con = new Contact();
                con.FirstName = 'Test'+acc.Name;
                con.LastName = 'Test'+acc.Name;
                con.AccountId = acc.Id;
                conList.add(con);   
            }

            //Opportunity
            if(acc.New_Opportunity__c && acc.Active__c == 'Yes'){
                Opportunity opp = new Opportunity();
                opp.Name = acc.Name;
                opp.CloseDate = System.today();
                opp.StageName = 'Prospecting';
                opp.Discount_Percent__c = 5;
                opp.AccountId = acc.Id;
                oppList.add(opp);
            }
        }

        if (!conList.isEmpty()) {
            insert conList;
        }
        
        if (!oppList.isEmpty()) {
            insert oppList;
        }
    }




    //6. When an account's phone field is updated, then in description field, input the old phone number and the new phone number

    public static void updateAccountDescOnPhoneUpdate(List<Account> accList, Map<Id, Account> oldAccMap){
        for(Account acc : accList){
            //Validating if the old phone is not same as the new phone number
            if(acc.Phone != oldAccMap.get(acc.Id).Phone){
                acc.Description = 'Phone is updated... Old Phone No. : '+oldAccMap.get(acc.Id).Phone + ' New Phone No. : '+acc.Phone;
            }
        }
    }



    //7. When Account record's Phone field is updated, then update the phone field on all the related contact list.

    public static void updateRelatedContact(List<Account> accList, Map<Id, Account> oldAccMap){
        
        List<Contact> conList = new List<Contact>();
        Map<Id, Account> accToAccountMap = new Map<Id,Account>();
    
        for (Account acc : accList) {
            if (acc.Phone != null && acc.Phone != oldAccMap.get(acc.Id).Phone && oldAccMap != null) {
                accToAccountMap.put(acc.Id, acc);
            }
        }

        if(accToAccountMap.size() > 0){
            for(Contact con : [SELECT Id, HomePhone, AccountID FROM Contact WHERE AccountId IN : accToAccountMap.keySet()]){
                if (accToAccountMap.containsKey(con.AccountId)) {
                    con.HomePhone = accToAccountMap.get(con.AccountId).Phone;
                    conList.add(con);
                }
            }
        }

        if (conList.size()>0) {
            update conList;
        }
    }




    //8. When an account's billing address is updated, then populate the billing address in all the related Contact's mailing address

    public static void updateContactsMailingAdd(List<Account> accList, Map<Id, Account> OldMap) {
        
        Map<Id, Account> accToAccountMap = new Map<Id, Account>();

        List<Contact> conList = new List<Contact>();

        for(ACcount acc : accList){
            if( (acc.BillingCity != OldMap.get(acc.Id).BillingCity ||
                acc.BillingState != OldMap.get(acc.Id).BillingState ||
                acc.BillingCountry != OldMap.get(acc.Id).BillingCountry ||
                acc.BillingPostalCode != OldMap.get(acc.Id).BillingPostalCode ||
                acc.BillingStreet != OldMap.get(acc.Id).BillingStreet) &&
                OldMap != null ) {
                    accToAccountMap.put(acc.id, acc);
            }
        }

        for(Contact con : [SELECT ID, AccountId FROM Contact WHERE AccountID IN: accToAccountMap.keySet()])
            {
                if(accToAccountMap.containsKey(con.AccountID)){
                    con.MailingCity = accToAccountMap.get(con.AccountId).BillingCity;
                    con.MailingState = accToAccountMap.get(con.AccountId).BillingState;
                    con.MailingCountry = accToAccountMap.get(con.AccountId).BillingCountry;
                    con.MailingPostalCode = accToAccountMap.get(con.AccountId).BillingPostalCode;
                    con.MailingStreet = accToAccountMap.get(con.AccountId).BillingStreet;
                }
                conList.add(con);
            }  
            
            if (!conList.isEmpty()) {
                update conList;
            }
    }   





    // 9. If the active field of any Account Record is set to 'Yes' and then it gets updated to 'No', then update the 'Stage' of every related opportunity to 'Closed Lost' except the opportunities whose 'Stage' is 'Closed Won'.

    public static void updateRelatedOppStage(List<Account> accList, Map<Id, Account> OldMap){

        List<Opportunity> oppList = new List<Opportunity>();

        Set<Id> accIds = new Set<Id>();

        for(Account acc : accList){
            
            //Fetching those ids whose active status was 'yes' and after updation it is 'no'
            if(acc.Active__c == 'No' && OldMap.get(acc.Id).Active__c == 'Yes'){
                accIds.add(acc.Id);
            }
        }

        if(!accIds.isEmpty()){
            for(Account acc : [SELECT Id, Active__c, 
                               (SELECT Id, StageName FROM Opportunities)
                               FROM Account WHERE Id IN:accIds]){
                                if(acc.Opportunities != null){
                                    for(Opportunity opp : acc.Opportunities){
                                        if(opp.StageName != 'Closed Won' && opp.StageName != 'Closed Lost'){
                                            opp.StageName = 'Closed Lost';
                                            oppList.add(opp);
                                        }
                                    }
                                }
                               }
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }




    // 10. Prevent deletion of Account Record if the 'Active' field is 'Yes'

    public static void preventDeletion(List<Account> accList){
        for(Account acc : accList){
            if (acc.Active__C == 'Yes') {
                acc.addError(Label.Prevent_Account_Deletion);
            }
        }
    }



    //11. Prevent Account form being updated if the record was created before 7

    public static void preventUpdate(List<Account> accList){
        
        for (Account acc : accList) {
            if (acc.CreatedDate < System.today() - 7) {
                acc.addError('You cannot update records which are created before 7 days');
            }
        }
    }



    //12. When the Account is updated check all opportunities related to the account. Update all Opportunities Stage to close lost if an opportunity created date is greater than 30 days from today and stage not equal to close won.

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





    //13. When a new Account is inserted, send an email to the System Admin with text such as : An account has been created and the name is “Account Name”.

    public static void sendEmailToAdmin(List<Account> accList){
        
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();

        User userObj = [SELECT Id, Profile.Name, Email from USER WHERE Profile.Name = 'System Administrator'];

        for(Account acc : accList){
            if(userObj.Email != null){
                //Assigning a single Mail to send
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                //Assigning the Sender Name for Mail
                mail.setSenderDisplayName('Salesforce');
                //We are making all this below fields as false because those are not needed for now
                mail.setUseSignature(false);
                mail.setBccSender(false);
                mail.setSaveAsActivity(false);
                //Assigning the receiver Mail Address
                mail.toAddresses = new String[]{userObj.Email};
                //Assign the Subject of the Mail
                mail.setSubject('New Account was Created.');
                //A variable to write the body of the Mail
                String body = 'Dear System Administrator, <br/>';
                body += 'An account has been created and name is '+acc.Name+'.';
                //Assigning the variable in which we wrote the body to the Mail Body
                mail.setHtmlBody(body);
                //Adding each single mail to be sent to the list of mails
                mails.add(mail);
            }
        }

        //Checking if the list of mails is not empty
    if(mails.size()>0){
        //" Messaging.sendEmail(mails) " is used to send the list of mails
        Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
        //we are checking if the mails are sent or not.
        if (results[0].success)
            {
            System.debug('The email was sent successfully.');
        }   else {
                System.debug('The email failed to send: '+ results[0].errors[0].message);
            }

        }

    }





    //14. When the account gets updated, we need to fill the 'Total Opportunity Amount' field with the sum of all the Opportunities Amount

    public static void totalAmountOfRelatedOpp(List<Account> accList){
        
        Set<Id> accId = new Set<Id>();
        
        for(Account acc : accList){
            acc.Total_Opportunity_Amount__c = 0;
            accId.add(acc.Id);
        }
        //map to get the Account Id and the sum of its related opportunities amount to insert later
        Map<Id,Double> amountMap = new Map<Id,Double>();

        //AggregateResult to get the sum of opportunities amount grouped by Account Id
        List<AggregateResult> results=[select AccountId,sum(Amount)TotalAmount FROM opportunity WHERE AccountId IN :accId GROUP BY AccountId];

        if(results.size()>0){
            for(AggregateResult a: results){
            //getting the AccountId and sum(Amount) in separate variables and putting it to map
            Id accountId = (Id)a.get('AccountId');
            double TotalAmount = (double)a.get('TotalAmount');
            amountMap.put(accountId,TotalAmount);
            }
        }

        //Again looping the accounts which are getting updated and making changes in "Total Opportunity Amount" field
        for(Account acc : accList){
            if(amountMap.containskey(acc.Id)){
            acc.Total_Opportunity_Amount__c=amountMap.get(acc.Id);
            }
         }
    }




    //15. When any new account gets created, and if the rating is 'Hot', the update the customer priority to 'high'
    //    if the rating is 'Warm', the update the customer priority to 'Medium'
    //    and if the rating is 'Cold', the update the customer priority to 'Low' and also update the description.

    public static void ratingToPriority(List<Account> accList){
        
        for(Account acc : accList){

            if(acc.Rating != null){
            
                if(acc.Rating == 'Hot'){
                    acc.CustomerPriority__c = 'High';
                    acc.Description = 'Rating is high';
                }
                else If(acc.Rating == 'Warm'){
                    acc.CustomerPriority__c = 'Medium';
                    acc.Description = 'Rating is Warm';
                }
                else if(acc.Rating == 'Cold'){
                    acc.CustomerPriority__c = 'Low';
                    acc.Description = 'Rating is Cold';
                }
            }   
        }
    }
}