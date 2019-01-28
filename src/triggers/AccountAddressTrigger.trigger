/**
 * Created by lakshmip on 12/4/2018.
 */

trigger AccountAddressTrigger on Account (before insert, before update) {

    for(Account acct : Trigger.new){
        if (acct.Match_Billing_Address__c == true && acct.BillingPostalCode != null) {
            acct.ShippingPostalCode = acct.BillingPostalCode;
        }
    }
}