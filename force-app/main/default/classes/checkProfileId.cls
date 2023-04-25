public class checkProfileId {
    public static void myMethod(){
        string profileId = '2F00e5g000000KheQ';
        string profileName = 'Demo Comm Profile';
        
        Profile profile = [SELECT Id, Name FROM Profile WHERE Name =: profileName LIMIT 1];
        
        system.debug('Profile Name : '+profile.Name);
        system.debug('Profile Id : '+profile.Id);
    }
}