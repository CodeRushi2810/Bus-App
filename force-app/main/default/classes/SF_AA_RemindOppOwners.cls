global class SF_AA_RemindOppOwners implements Schedulable{

    global void execute (SchedulableContext ctx) {
         
        List<Opportunity> oppList = [SELECT Id, Name, OwnerId, CloseDate FROM Opportunity WHERE IsClosed=False AND CloseDate < TODAY];
    
        SF_AA_Scheduled.myMethod(oppList);
    }
}

//How to implement!!

/*

SF_AA_RemindOppOwners reminder = new SF_AA_RemindOppOwners();

//Creating accronym

Seconds Minutes Hours DayOfMonth Month DayOfWeek Year

String sch = '0 0 0 2 1 ? 2023';
String jobId = system.schedule('Remind Opp Owner', sch, reminder)
*/