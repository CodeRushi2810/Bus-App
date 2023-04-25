public class SendConfirmationEmail {
    Public String journeyId{get;set;}
    @AuraEnabled
    public static String sendEmail() {
        
        //GeneratePDf
        PageReference pdfPage = Page.TicketInvoicePDF;
        Blob pdfBlob = pdfPage.getContentAsPDF();
        String fileName = 'BusTicket.pdf';
        
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setFileName(fileName);
        attach.setBody(pdfBlob);
        
        //Send Email
        String toAddress = UserInfo.getUserEmail();
        String orgWideEmailId = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'unicorn.bus999@gmail.com' LIMIT 1].Id;
        
        String subject = 'Ticket Invoice';
        String body = 'Here is the ticket invoice of your recent booking';
        
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[] {toAddress});
        email.setSubject(subject);
        email.setPlainTextBody(body);
        email.setOrgWideEmailAddressId(orgWideEmailId);
        email.setFileAttachments(new Messaging.EmailFileAttachment[] {attach});
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
        
        if (results[0].isSuccess()) {
            return 'Success';
        } else {
            return 'Error';
        }        
    }
}