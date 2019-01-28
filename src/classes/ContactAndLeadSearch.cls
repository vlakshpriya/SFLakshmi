/**
 * Created by lakshmip on 12/3/2018.
 */

public with sharing class ContactAndLeadSearch {
    public static list<list<SObject>> searchContactsAndLeads (String searchName)
    {
        List<List<sObject>> searchList = [FIND :searchName IN NAME FIELDS
                RETURNING Contact(Name),Lead(FirstName)];
        return searchList;
    }

}