/**
 * Created by lakshmip on 1/16/2019.
 */

public with sharing class AccountUtils {

    public static List<Account> accountsByState(String State){

        List<Account> AccountList = new List<Account>([SELECT Id,Name FROM Account WHERE BillingState = :State]);
        return AccountList;

    }

}