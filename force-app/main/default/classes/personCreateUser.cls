public class personCreateUser {
    
    public void createUser(string email , string FName , string LName , Id contactId , Id profileId ){
          
            string userEmail = email;
            string userFName = FName;
            string userLName = LName;
            string userProfileId = profileId;
            Id userContactId = contactId;
        
        	User newUser = new User();
        
        	newUser.Username = userEmail;
            newUser.LastName = userLName;
            newUser.FirstName = userFName;
        	newUser.Email = userEmail;
            newUser.Alias = userFName;
            newUser.CommunityNickname = userFName+userLName;
            newUser.ContactId = userContactId;
            newUser.LocaleSidKey = 'en_US';
            newUser.EmailEncodingKey = 'UTF-8';
            newUser.TimeZoneSidKey = 'America/Los_Angeles';
            newUser.ProfileId = userProfileId;
            newUser.LanguageLocaleKey = 'en_US';

			insert newUser;       
    }

}