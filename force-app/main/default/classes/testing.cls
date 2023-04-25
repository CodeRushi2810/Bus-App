public class testing {
    public static void check(string password){
        string password1 = '12345';
        
        if(password == password1){
            system.debug('Logged in successfully');
        }else{
            system.debug('Incorrect login credentials');
        }
    }
}