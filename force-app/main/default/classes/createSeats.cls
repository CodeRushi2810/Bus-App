public class createSeats {
    public static void createSeats(){
                
        List<Seat__c> seatList = [SELECT Id FROM Seat__c WHERE Bus_Id__c = 'a035g00000BuICJAA3'];
                
        List<Bus_Itinerary_Seat__c> seatDetails = new List<Bus_Itinerary_Seat__c>();
        
        for(Seat__c seat : seatList){
            Bus_Itinerary_Seat__c mySeat = new Bus_Itinerary_Seat__c();
            mySeat.Seat__c = seat.Id;
            mySeat.Bus_Itinerary__c = 'a0N5g000005jTivEAE';
            mySeat.Status__c = 'Available';
            seatDetails.add(mySeat);
        }
		insert seatDetails;        
    }
}