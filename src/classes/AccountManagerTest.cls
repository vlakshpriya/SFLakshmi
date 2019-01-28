/**
 * Created by lakshmip on 12/7/2018.
 */

@IsTest
private class AccountManagerTest {
    private static testMethod void testGetAccount(){
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI = 'https://na35.salesforce.com/services/apexrest/Accounts/'+recordId+'/Contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
    }
    static Id createTestRecord(){
        Account TestAcc = new Account(
                Name='Test record');
        insert TestAcc;
        Contact TestCon= new Contact(
                LastName='Test',
                AccountId = TestAcc.Id);
        return TestAcc.Id;
    }
}