@isTest
public class SF_AA_oppProcessorTest{

    @isTest
    public static void testBatchClass(){
        List<Opportunity> oppList = new List<Opportunity>();

        for(integer i=0 ; i<200 ; i++){
            Opportunity opp = new Opportunity();
            opp.LeadSource = 'Web';
            opp.CloseDate = system.today();
            opp.Name = 'Test'+i;
            opp.StageName = 'Prospecting';
            opp.Discount_Percent__c = 4;
            opp.Amount = 50000;

            oppList.add(opp);
        } 

        insert oppList;

        System.Test.startTest();
        SF_AA_oppProcessor oppProcess = new SF_AA_oppProcessor();
        Id batchId = Database.executeBatch(oppProcess, 200);

        System.Test.stopTest();

        List<Opportunity> updatedOpps = [SELECT Id FROM Opportunity WHERE LeadSource = 'Web'];

        system.assertEquals(200, updatedOpps.size());
    }
}