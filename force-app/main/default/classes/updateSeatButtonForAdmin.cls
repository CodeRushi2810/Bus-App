public class updateSeatButtonForAdmin {
    @AuraEnabled(cacheable = false)
    public static void insertSeatsIntoDatabase(){
        Id busId = 'a035g00000FAMANAA5';
        Id busItineraryId = 'a0N5g000005jUfJEAU';
        List<Seat__c> seatsToInsert = new List<Seat__c> ();
        
        for(integer i = 1 ; i <= 36 ; i++){
            Seat__c sleeperSeat = new Seat__c();
            sleeperSeat.Bus_Id__c = busId;
            sleeperSeat.Active__c = true;
            sleeperSeat.Seat_Number__c = i;
            if(i <= 24){
                sleeperSeat.Seat_Type__c = 'Sitting';
            }
            else{
                sleeperSeat.Seat_Type__c = 'Sleeper';
            }
            seatsToInsert.add(sleeperSeat);
        }
        insert seatsToInsert;
        
        List<Database.SaveResult> insertedSeats  = Database.insert(seatsToInsert, false);
        integer seatsCount = 0;
        for (Database.SaveResult result : insertedSeats) {
            if (result.isSuccess()) {
                seatsCount++;
            }
        }
        if(seatsCount == seatsToInsert.size()){
            system.debug('Seats of the bus Inserted successfully');
            
            List<Bus_Itinerary_Seat__c> seatItineraryList = new List<Bus_Itinerary_Seat__c> ();
            for(integer j = 1 ; j <=36 ; j++){
                Seat__c masterSeat = [SELECT Id, Seat_Number__c, Bus_Id__c FROM Seat__c WHERE Seat_Number__c =: j AND Bus_Id__c =: busId];
                Bus_Itinerary_Seat__c seat = new Bus_Itinerary_Seat__c();
                seat.Seat__c = masterSeat.Id;
                seat.Status__c = 'Available';
                seat.Bus_Itinerary__c = busItineraryId;
                seatItineraryList.add(seat);
            }            
            List<Database.SaveResult> saveSeatItinerary  = Database.insert(seatItineraryList, false);
            integer seatItineraryCount = 0;
            for (Database.SaveResult result : saveSeatItinerary) {
                if (result.isSuccess()) {
                    seatItineraryCount++;
                }
            }
            if(seatItineraryCount == seatItineraryList.size()){
                system.debug('Seats of the bus Inserted successfully');
            }
        }
    }
}