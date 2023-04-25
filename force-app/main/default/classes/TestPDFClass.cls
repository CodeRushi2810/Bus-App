public without sharing class TestPDFClass { 
    
    public List<String> myList {get;set;}
    public List<Journey_Traveller_Details__c> travelerList {get;set;}
    
    public Passenger_Journey__c journey{get;set;}
    public String pickupPoint{get;set;}
    public String dropPoint{get;set;}
    public String passengerJourneyId{get;set;}
    
    public String ticketId{get;set;}
    public String barcodeUrl{get;set;}
    
    public String busName{get;set;}
    public Bus__c bus{get;set;}
    
    public TestPDFClass(){
        
        //travelerList = [SELECT Id, Name, Traveller_Name__c, Traveller_Age__c, Traveller_Gender__c, Seat_Details__c FROM Journey_Traveller_Details__c
          //              WHERE Passenger_Journey__c =: 'a0F5g000003DMr2EAG'];
        
        //ticketId = 'a0F5g000003DLwfEAG';
        //barcodeUrl = 'https://barcode.tec-it.com/barcode.ashx?data='+ticketId+'&code=Code128&dpi=96&dataseparator=';
        
        passengerJourneyId  = ApexPages.CurrentPage().getparameters().get('id');
        
        if(passengerJourneyId != null && String.isNotBlank(passengerJourneyId)){
            journey = [SELECT Id, Name, Bus_Id__r.Name, Total_Fare__c, Source_City__c, Destination_City__c, Journey_Date__c,
                       Booking_Date__c, Pickup_Point__r.Name, Drop_Point__r.Name, Start_Time__c, End_Time__c,
                       Journey_Duration__c FROM Passenger_Journey__c WHERE Id =:passengerJourneyId];
            ticketId = journey.Id;
            barcodeUrl = 'https://barcode.tec-it.com/barcode.ashx?data='+ticketId+'&code=Code128&dpi=96&dataseparator=';
            
            pickupPoint = journey.Pickup_Point__r.Name;
            dropPoint = journey.Drop_Point__r.Name;
            
            busName = journey.Bus_Id__r.Name;
            
            bus = [SELECT Id, Name, Type__c, Bus_Number__c FROM Bus__c WHERE Name =: busName];

			travelerList = [SELECT Id, Name, Traveller_Name__c, Traveller_Age__c, Traveller_Gender__c, Seat_Details__c FROM Journey_Traveller_Details__c
                        WHERE Passenger_Journey__c =: passengerJourneyId];	
            barcodeUrl = 'https://barcode.tec-it.com/barcode.ashx?data='+ticketId+'&code=Code128&dpi=96&dataseparator=';
        }
    }
    
    @AuraEnabled
    public static String sendPdf(String journeyId) {
        PageReference pdf = new pagereference('/apex/TestVFPage?id='+journeyId);
        pdf.getParameters().put('id', journeyId);
        
        Blob body;
        try {
            // returns page as a PDF
            body = pdf.getContent();
        } catch (Exception e) {
            body = Blob.valueOf('data');
        }
        
        //insert content version
        ContentVersion CV = new ContentVersion();
        CV.Title = 'TicketInvoice.pdf';
        CV.PathOnClient = 'TicketInvoice.pdf';
        CV.VersionData = body;
        CV.FirstPublishLocationId = journeyId;
        insert CV;
        
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('TicketInvoice.pdf');
        attach.Body = body;
        
        User currentUser = [SELECT Alias FROM User WHERE Id = :UserInfo.getUserId()];
        String loggedInUserAlias = currentUser.Alias;
        
        String toAddress = UserInfo.getUserEmail();
        String orgWideEmailId = [SELECT Id FROM OrgWideEmailAddress WHERE Address = 'unicorn.bus999@gmail.com' LIMIT 1].Id;
        //String link = 'https://horizontaldigital-c-dev-ed.my.site.com/unicornBusService/s/detail/'+journeyId;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {toAddress});
        mail.setSubject('Bus Ticket Booking Confirmation');
        //mail.setHtmlBody('Here is your E-Ticket for your journey.');
        mail.setHtmlBody('<html><body><h2>Booking Confirmation - Bus Ticket</h2><h3>Dear '+loggedInUserAlias+'</h3><p>Congratulations! Your bus ticket has been booked successfully.</p><p>Thank you for choosing our services, and we look forward to serving you on your upcoming journey.</p><p>You can view the booking details from the site using this link : </p><a href="https://horizontaldigital-c-dev-ed.my.site.com/unicornBusService/s/detail/'+journeyId+'">View Booking</a><p>Best regards,</p><h3>UNICORN BUS</h3></body></html>');
                                  
        mail.setOrgWideEmailAddressId(orgWideEmailId);
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {attach}); 
        // Send the email
        //Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        
        Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        if (results[0].isSuccess()) {
            System.debug('Email sent successfully.');
            return 'Email sent Successfully with PDF.';
        } else {
            System.debug('Email failed to send: ' + results[0].getErrors()[0].getMessage());
            return 'Email failed to send: ' + results[0].getErrors()[0].getMessage();
        }
    }
}