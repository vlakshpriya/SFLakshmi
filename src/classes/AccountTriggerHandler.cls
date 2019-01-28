/**
 * Created by lakshmip on 1/16/2019.
 */

public with sharing class AccountTriggerHandler {

    public static void CreateAccounts(List<Account> AccountList){
        for(Account acct:AccountList){
            if(acct.ShippingState != acct.BillingState){
                acct.ShippingState = acct.BillingState;
            }
        }
    }

}