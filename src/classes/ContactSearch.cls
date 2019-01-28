/**
 * Created by lakshmip on 12/3/2018.
 */

public with sharing class ContactSearch {

    public static list<Contact> searchForContacts(String lastName, String MailPostalCode)
    {
        List<Contact> cnt = [Select Name from Contact
                             Where  LastName = :lastName
                             And    MailingPostalCode = :MailPostalCode];
        return cnt;
    }
}