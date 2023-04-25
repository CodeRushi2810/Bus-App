public class SF_DataTypes {
    
    Boolean a; //Primitive Variable
	Boolean b;
    
    Integer num1 = 31;
    Integer num2 = 69;
    Decimal value = 5.5;
    String company = 'Horizontal Digital';
    //ID myId = '00514SFD145';
    
    public void myMethod(){
        system.debug('I am in method');
        a = true;
        b = false;
        
        Integer total = num1+num2;
        
        system.debug('A = '+a);
        system.debug('B = '+b);
        system.debug('Total = '+total);
        system.debug('Price = '+value);
        system.debug('I work at ' + company);
        //system.debug('My ID is ' + myId);

    }
}