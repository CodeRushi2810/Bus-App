public class SF_SetMapList {

    public static void myList(){

        //We can store duplicate values inside the list

        // How to create a list?
        list<integer> firstList = new list<integer>{1,2,3,1,2,3,4,5}; //First way, this creates a variable of type list adn stores values inside it
        
        String[] secondList  = new List<String>(); //Second way, this only creates a variable of type list

        list<integer> thirdList = new integer[20]; //Third way, this code will make a list with capacity of holding 20 elements

        String[] forthList = new String[10]; //Forth way, this code will make a list with capacity of holding 10 elements

        // How to add values inside the list?
        thirdList[0]= 54;
        thirdList[1]= 44;
        thirdList.add(75);
        
        // How to get values from the list?
        system.debug(thirdList.get(0));
        system.debug(thirdList.get(1));
        system.debug(thirdList[2]);


        // How to get values from the list?
        integer sizeOfList = thirdList.size(); //This function will return the size of the list
        
        // How to remove values from the list?
        firstList.remove(5);


        //Set Function
        firstList.set(4, 69);
        //This function will set the value in the index number provided, if there is already a value present in that index, then it will overwrite it and add the new value.

        // Sort Function - Sorts the values in ascending order
        System.debug(firstList);
        firstList.sort();
        System.debug(firstList);

        // Clear Function - Clears all the values present in that list
        thirdList.clear();
        // isEmpty Function - Returns true or false
        firstList.isEmpty();
    }




    public static void mySets(){

        //We cannot store duplicate values inside the Sets

        // Initializing the Set
        Set<integer> id1 = new Set<Integer>(); //Only creates the set
        Set<integer> id2 = new Set<Integer>{1,2,3,4,5,6,7,8,9}; //Creating the set and adding values to it

        // Adding values to the set
        id1.add(45);
        id1.add(44);
        id1.add(45); //This wont get added as there is already a similar value present in the set

        system.debug(id1);
        
        system.debug(id2);
        

        //Adding values as SObjects
        Set<Account> sSet = new Set<Account>();

        Account a1 = new Account(Name = 'Walmart', NumberOfEmployees = 2000);
        Account a2 = new Account(Name = 'Amazon', NumberOfEmployees = 2000); //This will be added as all the fields are not same
        Account a3 = new Account(Name = 'Walmart', NumberOfEmployees = 2000); //This will not be added as all the fields are same
        Account a4 = new Account(Name = 'Meta', NumberOfEmployees = 4000);

        sSet.add(a1);
        sSet.add(a2);
        sSet.add(a3);
        sSet.add(a4);

        system.debug(sSet.size());

        //Methods of Sets
        Set<Integer> mySet = new Set<Integer>();
        //This will add all the values present in the list into the set
        //It will remove the duplicate values and also sort the values in ascending order
        list<integer> myList = new List<integer>{5,1,3,8,10,6,5,3};
                
        mySet.addall(myList);
        system.debug(mySet);
        
        // Contains method
        system.debug(mySet.contains(5)); //it will return true
        system.debug(mySet.contains(50)); //it will return false
        

        //containsAll method
        set<integer> test1 = new set<integer>{5,1,3,8,10,6,5,3};
        set<integer> test2 = new set<integer>{5,1,3,0,6,5,3};
        system.debug('Test:1 - '+mySet.containsAll(test1)); //Will return true as all the values are present
        system.debug('Test:2 - '+mySet.containsAll(test2)); //Will return false as all the values are not present
        
        //retainAll method - It will remove the values which are not present

        set<integer> R1 = new set<integer>{1,2,3,4,5};
        set<integer> R2 = new set<integer>{1,3,5,7,9};
        
        //clone method - creates a new set with all the values
        Set<Integer> cloned = R1.clone();
        
        //remove method - removes the targeted element
        R2.remove(1); //this will remove element 1 from the set
        

        //removeAll method - removes all the values from the set
        set<integer> R3 = new set<integer>{1,3,5,7,9};
        set<integer> R4 = new set<integer>{1,3,5,7,9,45,24,35};
        R3.removeAll(R4);

        //clear method - clears the whole set
        set<integer> R5 = new set<integer>{1,3,5,7,9,45,24,35};
        R5.clear();
        }
    




        public static void myMaps(){

            //How to initialize a map
            Map<integer,String> myMap = new Map<integer,String>();
            //How to add values to a map (Key, Value)
            myMap.put(1, 'Alex');
            myMap.put(2, 'Mike');
            myMap.put(3, 'Ron');
            
            system.debug(myMap);
            
            //If we try to add a value in a key which is already declared, then it will override the existing key value pair
            myMap.put(3, 'Ben');
            system.debug(myMap);
            
            // How to initialize and add value at the same time
            Map<integer,string> test = new Map<integer, string>{1=>'Rakesh', 2=>'Suresh', 3=>'Mahesh'};
            system.debug(test);
            
            //Methods of Map
            
            // putAll Method
            Map<integer,String> M1 = new Map<integer,String>{1=>'Mohan', 2=>'Rohan', 3=>'Sohan'};
            Map<integer,String> M2 = new Map<integer,String>();
            M2.putAll(M1);
            system.debug('This is M1'+M1);
            system.debug('This is M2'+M2);
 
        }
}