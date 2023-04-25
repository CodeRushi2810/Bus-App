public class SF_InsertUpdateSOQL {
    public static void myMethod() {

        // UPDATE RELATED RECORDS------------------------------------

        //Creating account

        // Account acc = new Account(Name = 'Royal Dogs', Phone = '456852');
        // insert acc;
        
        //Fetching the created account
        // Account acc = [SELECT Id FROM Account WHERE Name =: 'Royal Dogs'];

        //Creating contact and linking it with the above account
        // Contact con = new Contact(AccountId = acc.id, FirstName = 'German', LastName = 'Shephard', Phone = '789456');
        // insert con;

        //Fetching the account of the contact and updating its values
        // Contact con = [SELECT Id, Name, Phone, Account.Phone FROM Contact WHERE Name = 'Siberian Husky' AND AccountId != Null AND Account.Name = 'Royal Dogs'];

        // con.Phone = '11111';
        // con.Account.Phone = '22222';

        // update con;
        // update con.Account;



        // Fetching Related Records................Parent To Child
        // List<Account> accList = new List<Account>();
        
        // accList = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Name =: 'Royal Dogs'];
        
        // if(!accList.isEmpty()){
        //     for(Account acc : accList){
        //         system.debug('Contacts : '+acc.Contacts);
        //     }
        // }
        
        // Fetching Related Records................Parent To Child

        List<Contact> conList = [SELECT Id, Name, Account.Name FROM Contact WHERE Name = 'Siberian Husky'];

        for(Contact con : conList){
            system.debug('Contact Name : ' +con.Name + ' | Account Name : ' +con.Account.Name);
        }
    }
}