/**
 * Created by lakshmip on 12/4/2018.
 */

@isTest
public with sharing class TestRestrictContactByName {

    @isTest static void TestContactNameInvalid(){
        contact con = new contact(firstName = 'Lakshmi Priya', Lastname= 'INVALIDNAME');
        Test.startTest();
        Database.SaveResult result = Database.insert(con,false);
        Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals(' The Last Name "INVALIDNAME" is not allowed for DML',result.getErrors()[0].getMessage());
    }

}