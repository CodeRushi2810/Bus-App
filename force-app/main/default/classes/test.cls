public class test {

    public  static void mymethod() {

        List<Account> accList = new List<Account>();

        accList = [SELECT Id, Name, Description FROM Account LIMIT 20];
        

        for(Account acc : accList){
            acc.Description = 'Test Desc';
        }

        update accList;
    }
}