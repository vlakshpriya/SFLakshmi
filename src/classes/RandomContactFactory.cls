/**
 * Created by lakshmip on 12/4/2018.
 */

public with sharing class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer NoOfContacts, String LastName){

        List<Contact> con = new List<Contact>();
        for(Integer i=0; i < NoOfContacts; i++){
            Contact c = new Contact(FirstName = 'Test '+i);
            con.add(c);
        }
        return con;
    }

}