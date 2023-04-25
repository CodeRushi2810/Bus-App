public class createRoute {
    public static void createRoute(){
        
        //List<Bus_Stop__c> routesToDelete = [SELECT Id FROM Bus_Stop__c];
        //delete routesToDelete;
        List<Bus_Stop__c> myUpdate = [SELECT Id,Distance_From_Previous_Stop__c, Stop_Number__c FROM Bus_Stop__c WHERE Stop_Number__c = 1];
        
        for(Bus_Stop__c stop1 : myUpdate){
            stop1.Distance_From_Previous_Stop__c = 0;
        }
        update myUpdate;
            
            /*
        for(decimal i = 1 ; i<=5 ; i++){
           		Bus_Stop__c bus = new Bus_Stop__c();
            	bus.Stop_Number__c = i;
            	bus.Name = 'Stop '+i;
                bus.Bus_Id__c = busId;
                
            insert bus;
        }
*/
    }
}