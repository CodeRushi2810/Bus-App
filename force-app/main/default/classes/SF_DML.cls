public class SF_DML{
    public static void normalInsert(){
        Account acc1 = new Account(Name='ABC', Phone='123456');
        Account acc2 = new Account(Name='DEF', Phone='789456');
        Account acc3 = new Account(Name='GHI', Phone='654789');
        Account acc4 = new Account(Name='JKL', Phone='741369');
        Account acc5 = new Account(Name='MNO', Phone='789123');
        // Inserting seperately

        // insert acc1;
        // insert acc2;

        //Governor Limit
        //If we insert the records seperately, then n number of DMLs will be counted
        //If we insert the records in bulk, then only 1 number of DML will be counted

        system.debug('Account ID : '+acc1.id + ' | Account Name : '+acc1.Name+' | Phone : '+acc1.Phone);
        system.debug('Account ID : '+acc2.id + ' | Account Name : '+acc2.Name+' | Phone : '+acc2.Phone);
        
        // Inserting all at once using list
        List<Account> accList = new List<Account>();
        accList.add(acc3);
        accList.add(acc4);
        accList.add(acc5);

        // insert accList;


        system.debug('Account ID : '+acc3.id + ' | Account Name : '+acc3.Name+' | Phone : '+acc3.Phone);
        system.debug('Account ID : '+acc4.id + ' | Account Name : '+acc4.Name+' | Phone : '+acc4.Phone);
        system.debug('Account ID : '+acc5.id + ' | Account Name : '+acc5.Name+' | Phone : '+acc5.Phone);
    }




    public static void insertLookUpDML(){
        //Here we made a new account and stored that account's id in the new contact 
        //So the lookup relationship will be filled and the Contact will be linked with the account

        Account acc10 = new Account(Name='ASD', Phone='123456');
        // insert acc10;
        Contact con10 = new Contact(FirstName='Rushi', LastName='Patel', AccountID=acc10.id);
        // insert con10;
    }



    public static void updateDML(){
        Account acc20 = [SELECT Id, Name, Phone from Account WHERE Name='ABC'];
        system.debug(acc20);

        acc20.Phone = '852741';
        update acc20;
        system.debug(acc20);
    }



    public static void updateLookUpDML(){
        Contact con = [SELECT Id,FirstName, LastName, Phone, Account.Phone FROM Contact WHERE FirstName='Rushi' AND LastName='Patel'];

        system.debug(con);

        con.phone = '99999';
        con.Account.Phone = '11111';

        update con;
        update con.Account;
    }

    public static void upsertDML(){

        List<Account> accList = new List<Account>();

        Account acc50 = new Account(Name='IJN', Phone='74747');                     //Creating new account
        Account acc51 = [SELECT Id, Name, Phone FROM Account WHERE Name = 'DEF'];   //Fetching existing account

        acc51.Phone = '35353';      // Updating one field of the fetched account... before it was = [789456]
        accList.add(acc50);         // Adding the new account in list
        accList.add(acc51);         // Adding the updated account in list

        upsert accList;             // Using upsert operation. It will insert if account is not present or it will update if the account is already present in the database

        system.debug(accList);
    }


    public static void mergeDML(){
        // Account acc30 = new Account(Name='JKL', Phone='741369');
        // insert acc30;

        // Account acc42 = new Account(Name='MNO', Phone='789123');
        // insert acc42;
        
        // Contact con42 = new Contact(FirstName='Bruce', LastName='Wayne', AccountID=acc42.id);
        // insert con42;

        Account masterAcc = [SELECT Id, Name, Phone FROM Account WHERE Name = 'JKL' LIMIT 1];
        Account mergeAcc = [SELECT Id, Name, Phone FROM Account WHERE Name = 'MNO' LIMIT 1];
        
        try {
            merge masterAcc mergeAcc;
        } catch (DmlException e) {
            // Process exception
            System.debug('An unexpected error has occurred: ' + e.getMessage()); 
        }
    }



    public static void deleteDML(){
        Account acc69 = [SELECT Id, Name, Phone FROM Account WHERE Name = 'GHI'];
        List<Account> deleteList = new List<Account>();

        Account acc70 = [SELECT Id, Name, Phone FROM Account WHERE Name = 'ASD'];
        Account acc71 = [SELECT Id, Name, Phone FROM Account WHERE Name = 'ABC'];
        deleteList.add(acc70);
        deleteList.add(acc71);

        delete acc69; //Single delete
        delete deleteList;
    }



    public static void unDeleteDML(){
        List<Account> deletedAcc = [SELECT Id, Name, Phone FROM Account WHERE Name = 'GHI' ALL ROWS];

        undelete deletedAcc;
    }
}