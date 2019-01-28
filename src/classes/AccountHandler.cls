/**
 * Created by lakshmip on 12/3/2018.
 */

public with sharing class AccountHandler
{
    public static Account insertNewAccount (String accountName)

    {
        Account acct = new Account(Name= accountName);

        try
        {
            insert acct;
        }
        catch(DmlException exc)
    {
        return null;
    }

    return acct;

    }

    public static void CreateNewOpportunity(List<Account> accts){

        List<Opportunity> opps = new List<Opportunity>();
        for(Account a :accts){
            Opportunity opp = new Opportunity();
            opp.Name = a.Name + 'Opportunity';
            opp.AccountId = a.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.Today().addmonths(1);
            opps.add(opp);
        }
        if(opps.size() > 0){
            insert opps;
        }

    }
}