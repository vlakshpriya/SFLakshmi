/**
 * Created by lakshmip on 12/7/2018.
 */

@RestResource(UrlMapping='/Accounts/*/contacts')
global class AccountManager {
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substringBetween('Accounts/','/contacts');
        Account Result = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) FROM Account WHERE Id =: accountId];
        System.debug('Result is :' +Result);
        return Result;
    }
}