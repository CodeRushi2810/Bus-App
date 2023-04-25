public without sharing class ProvideFeedback {
    @auraEnabled(cacheable=false)
    public static string insertFeedback(Id busId, string title, string feedback){
        
        Id userId = UserInfo.getUserId();
        User currentUser = [SELECT Id, AccountId FROM User WHERE Id =: userId];
        userId = currentUser.AccountId;
        
        Bus_Review__c review = new Bus_Review__c();
        
        review.Bus__c = busId;
        review.Name = title;
        review.Feedback__c = feedback;
        review.Ratings__c = '5';
        review.Passenger_Name__c = userId;
        
        Database.SaveResult result = Database.insert(review, false);
        
        if (result.isSuccess()) {
                System.debug('Review submitted successfully');
                return 'Feedback received';
            } 
            else {
                for (Database.Error err : result.getErrors()) {
                    System.debug('Error message: ' + err.getMessage());
                } 
                return 'Feedback insertion failed';
            }
    }
}