public class TicketInvoicePDFController {
   public Passenger_Journey__c passengerJourneyDetails { get; set; }
    
    public TicketInvoicePDFController(){
        passengerJourneyDetails = [SELECT Id, Name, Bus_Id__r.Name,Passenger_Id__r.Name, Total_Fare__c, Source_City__c, Destination_City__c, Journey_Date__c,
                                   Booking_Date__c, Bus_Itinerary__c, Pickup_Point__r.Name, Drop_Point__r.Name, Start_Time__c, End_Time__c, Journey_Duration__c		
                                   FROM Passenger_Journey__c WHERE Id = 'a0F5g000003DKkLEAW'];
    }
}