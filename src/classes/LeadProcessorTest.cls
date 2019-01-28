/**
 * Created by lakshmip on 12/7/2018.
 */

@isTest
public class LeadProcessorTest {
    static testMethod void leadProcessorTrailTest(){
        List<Lead> leadList = new List<Lead>();
        for(integer i = 0; i<200; i++){
            Lead leads = new Lead();
            leads.FirstName = 'Harikumar';
            leads.LastName = 'Lakshmanan'+i;
            leads.Company = 'BNP';
            leadList.add(leads);
        }
        insert leadList;
        Test.startTest();
        LeadProcessor L = new LeadProcessor();
        Database.executeBatch(L);
        Test.stopTest();
    }

}