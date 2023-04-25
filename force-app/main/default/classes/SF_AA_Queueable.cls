public class SF_AA_Queueable implements Queueable{

    private List<Account> accList;
    private Id parentAccId;

    public SF_AA_Queueable(List<Account> accRecords, Id id){
        this.accList = accRecords;
        this.parentAccId = id;
    }

    public void execute(QueueableContext context){
        for(Account acc : accList){
            acc.ParentId = parentAccId;
        }

        update accList;
    }
}

//How to implement!!

/*  

List<Account> accList = [SELECT Name FROM Account WHERE Name LIKE 'Account%'];

Id parentId = [SELECT Id FROM Account WHERE Name = 'Royal Dogs'][0].Id;

SF_AA_Queueable updateJob = new SF_AA_Queueable(accList, parentId);

Id jobId = System.enqueJob(updateJob);

*/