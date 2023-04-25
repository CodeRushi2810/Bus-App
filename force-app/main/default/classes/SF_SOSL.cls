public class SF_SOSL{
    public static void myMethod(){
        //SOSL is used when we want to search for a particular word on multiple accounts
        List<List<sObject>> searchList = [Find 'test' IN ALL FIELDS RETURNING Account(Name), Contact(FirstName, LastName, Email)];

        List<Account> accList = new List<Account>();
        List<Contact> conList = new List<Contact>();

        accList = (List<Account>) searchList[0];
        conList = (List<Contact>) searchList[1];

        for(Account acc : accList){
            System.debug('Name : '+acc.Name);
        }
        
        for(Contact con : conList){
            System.debug(con.FirstName + ' ' +con.LastName);
        }

    }
}