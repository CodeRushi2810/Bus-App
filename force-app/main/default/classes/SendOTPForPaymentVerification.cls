public class SendOTPForPaymentVerification {
    @AuraEnabled
    public static Integer sendOTP() {
        
        //Send Email
        String toAddress = UserInfo.getUserEmail();
        String orgWideEmailId = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'unicorn.bus999@gmail.com' LIMIT 1].Id;
        String subject = 'Your OTP for Payment';
        
        User currentUser = [SELECT Alias FROM User WHERE Id = :UserInfo.getUserId()];
        String loggedInUserAlias = currentUser.Alias;
        
        Integer OTP = Integer.valueOf((Math.random() * 9000) + 1000);
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] {toAddress});
        email.setSubject(subject);
        email.setHtmlBody('<html><body><h1>Dear '+loggedInUserAlias+',</h1><p>As part of our enhanced security measures, we are requesting a One-Time Password (OTP) for your payment verification.</p><h3>Your OTP is : <strong>'+OTP+'</strong></h3><p>Please enter this OTP withing 3 minutes to complete your payment.</p><p>If you did not initiate this request, please contact our customer support immediately.</p><br><p>Thank you for your cooperation.</p><br><p>Unicorn Bus</p></body></html>');
        email.setOrgWideEmailAddressId(orgWideEmailId);
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        
        if (results[0].isSuccess()) {
            return OTP;
        } else {
            return null;
        }
    }
}