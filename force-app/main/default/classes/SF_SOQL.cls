public  class SF_SOQL {
    public static void mySOQL() {
        List<Account> accList = new List<Account>();
        
        accList = [SELECT Id, Name FROM Account LIMIT 2];

        System.debug('Account List : '+accList);
        
        //When using custom objects, use the api name of the object and the fields, eg: students__c
        
        //We can use query editor for checking our SOQL query wether its working fine or not.
        
        List<Opportunity> oppList1 = new List<Opportunity>();
        List<Opportunity> oppList2 = new List<Opportunity>();
        
        //We can store field values in a variabe and use that in the query as well
        String oppName = 'LinksCan';
        
        oppList1 = [SELECT Id, Name FROM Opportunity WHERE Name=: 'Nirvana'];
        oppList2 = [SELECT Id, Name FROM Opportunity WHERE Name=: oppName];
        
        System.debug('Opportunity List : '+oppList1);
        System.debug('Opportunity List : '+oppList2);
        
        
        
        //Applying Null Check
        
        List<Account> accList2 = new List<ACcount>();
        
        accList2 = [SELECT Id, Name FROM Account];
        
        if(!accList2.isEmpty()){
            for(Account acc : accList2){
                System.debug(acc);
            }
        }
        
        
        //Counting the number of records queried
        
        integer count;
        
        List<Account> accList3 = new List<ACcount>();

        count =[SELECT count() FROM Account];
        system.debug(count + ' records found');
        

        //When we want to find all the records with a same firstname followed by their lastname
        
        List<Account> accList4 = new List<ACcount>();

        accList3 = [SELECT Id, Name FROM Account WHERE Name LIKE 'Nir%' ORDER BY Name];
        //By default, the records will be displayed in ascending order
        // To dispaly them in descending order, we need to write like this :
        
        // accList3 = [SELECT Id, Name FROM Account WHERE Name LIKE 'Nir%' ORDER BY Name DESC];
        
        system.debug(accList3);

        
        
        //Parent To Child
        
        //When we query child records from the parent records, we need to use the Child Relationship Name

        //For custom objects we need to use namee__r in child relationShip Name

        //ListName = [SELECT Id, Name, (Child Query FROM Child Relationship Name) FROM Parent Object];
          accList4 = [SELECT Id, Name, (SELECT ID, Name FROM Contacts) FROM Account WHERE Name =: 'Edge Communications'];

        for(Account acc : accList4){
            system.debug('Contact of Edge Communications : ' + acc.Contacts);
        }


        //Child to Parent

        List<Contact> conList = new List<Contact>();

        conList = [SELECT Id, Name, Account.Name FROM Contact WHERE Name =: 'Mr. Sean Forbes'];

        system.debug('Account Name of Mr. Sean Forbes is '+conList);
    }
}