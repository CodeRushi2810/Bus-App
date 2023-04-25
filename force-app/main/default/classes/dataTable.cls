public class dataTable {
	@auraEnabled(cacheable = true)
    
    public static List<Account> accList(String searchKeys){
        if(searchKeys != null && searchKeys != ''){
            string key = '%'+searchKeys+'%';
            List<Account> searchAccList = [SELECT Id, Name FROM Account WHERE Name Like: key];
            return searchAccList;
        }
        else{
        	List<Account> acc = [SELECT Id, Name FROM Account];
            	if(!acc.isEmpty()){
            		return acc;    
            	}
            return null;
        }           
    }
}