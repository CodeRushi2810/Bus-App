public class UpdateDateTimeField {
    @InvocableMethod(label='Process Records' description='Process a list of records from Flow')
    public static void processRecords(List<FlowInput> flowInputs) {
        system.debug(flowInputs);
        // Process the records received from Flow
        List<Bus_Itinerary__c> recordsToUpdate = new List<Bus_Itinerary__c>();
        for (FlowInput flowInput : flowInputs) {
            Bus_Itinerary__c recordToUpdate = new Bus_Itinerary__c();
            recordToUpdate.Id = flowInput.recordId;
            recordToUpdate.Start_Date_Time__c = flowInput.startDateTime.addDays(1);
            recordToUpdate.End_Date_Time__c = flowInput.endDateTime.addDays(1);
            recordToUpdate.Journey_Date__c = flowInput.journeyDate.addDays(1);
            recordsToUpdate.add(recordToUpdate);
        }
        update recordsToUpdate;
    }

    // Wrapper class for input records from Flow
    public class FlowInput {
        @InvocableVariable(label='Record Id' description='Id of the record to update' required=true)
        public Id recordId;

        @InvocableVariable(label='Start Date Time' description='Value for Start Date Time' required=true)
        public DateTime startDateTime;

        @InvocableVariable(label='End Date Time' description='Value for End Date Time' required=true)
        public DateTime endDateTime;
        
        @InvocableVariable(label='Journey Date' description='Value for Journey Date' required=true)
        public Date journeyDate;

    }
}