public class SF_useSObjects{
    public static void myMethod(){
        
        List<Position__c> posList = new List<Position__c>(); //Created list for storing all Positions data

        posList = [Select Name, Status__c	FROM Position__c LIMIT 3]; //Written query to fetch the data and store it in the 'posList' List 
        
        Set<String> printPosi = new Set<String>(); //Created a set to store the position title
        Set<String> printStatus = new Set<String>();//Created a set to store the position status
        if(!posList.isEmpty()){ //Checking if the list is empty or not
            for(Position__c posi : posList){ //Using for loop, we can store the data from posList into posi one by one
                printPosi.add(posi.Name);    //Adding the name from posi into the set 'printPosi'
                printStatus.add(posi.Status__c); //Adding the Status from posi into the set 'printStatus'
            }
        }
        
        for (String val : printPosi){
            system.debug(val);
        }
        
    }
}