public class AccountHandler {
    
 public Static Account insertNewAccount(String an){
        Account acc=new Account(name=an);
            try{
                insert acc;
                return acc;
            }
        catch(DMLException e){
            return null;

        }
    }
 
}