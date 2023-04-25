public without sharing class InvocableClass {
    
    @InvocableMethod(label='Navigate to Page' description='Navigates the user to a specified page')
    public static void navigateToPage() {
        PageReference homePage = new PageReference('https://horizontaldigital-c-dev-ed.my.site.com/unicornBusService/s/myjourney');
        homePage.setRedirect(true);
    }
}