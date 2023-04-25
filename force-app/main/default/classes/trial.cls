public class trial {
    public static void myMethod(){
        
            List<Position__c> accList = [Select Name from Position__c];
        
            for(integer i=0; i<accList.size(); i++){
            System.debug(accList[i].Name);
            }
    }
}