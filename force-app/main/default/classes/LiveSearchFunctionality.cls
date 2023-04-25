public without sharing class LiveSearchFunctionality {
	 @AuraEnabled(cacheable=true)
    public static List<City__c> searchCities(String searchTerm) {
        List<City__c> cityList = [SELECT Id, Name FROM City__c WHERE Name LIKE : '%'+searchTerm+'%' LIMIT 10];
        for(City__c city : cityList){
            system.debug(city.Name);
        }
        if(!cityList.isEmpty()){
            return cityList;
        }
        else{
            return null;
        }
    }
}