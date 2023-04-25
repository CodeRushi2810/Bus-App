public class SF_databaseMethods{
    public static void insertMethod(){

        List<Contact> contactList = new List<Contact>{
            new Contact(FirstName='Siberian', LastName='Husky'),
            new Contact(FirstName='German', LastName='Shephard'),
            new Contact()
        };

        //methodName[] variableName = methodName.insert(listName, AllorNone);
        Database.SaveResult[] srList = Database.insert(contactList, false);

        //AllorNone can be true or false
        //IF set true, then either all the records will be inserted or none if any error occurs
        //IF set false, then all the records which are correct will be inserted and one with errors will not be inserted

        for(Database.SaveResult sr : srList){
            if (sr.isSuccess()) {
                //If operation is successful
                system.debug('Successfully inserted contact with Id : '+sr.getId());
            }else{
                for(Database.Error err : sr.getErrors()) {
                system.debug('Error occured while inserting');
                system.debug(err.getStatusCode() + ' : ' + err.getMessage());
                system.debug('Contact field that affected this error' + err.getFields());
                }
            }
        }
    } 
}