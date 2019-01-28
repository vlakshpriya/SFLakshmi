/**
 * Created by lakshmip on 12/18/2018.
 */

@IsTest
private class DealActionTriggerHandlerTest {
    @TestSetup static void setup(){

        insert DMLForDealViewer.CreateContacts();
        insert DMLForDealViewer.CreateDeals();
    }

    @IsTest
    static void testInsertAccepted() {

        Test.startTest();
        insert DMLForDealViewer.CreateDealActions('Accepted');
        Test.stopTest();

        List<Contact> ConTest = [SELECT Id,Deals_Accepted__c,Deals_Rejected__c FROM Contact ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(1,ConTest[i].Deals_Accepted__c);
            System.assertEquals(0,ConTest[i].Deals_Rejected__c);
        }

        List<Deal__c> DealIns = [SELECT Id,Acceptances__c,Rejections__c FROM Deal__c ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(1,DealIns[i].Acceptances__c);
            System.assertEquals(0,DealIns[i].Rejections__c);
        }

    }

    @IsTest
    static void testInsertRejected() {

        Test.startTest();
        insert DMLForDealViewer.CreateDealActions('Rejected');
        Test.stopTest();

        List<Contact> ConTest = [SELECT Id,Deals_Accepted__c,Deals_Rejected__c FROM Contact ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,ConTest[i].Deals_Accepted__c);
            System.assertEquals(1,ConTest[i].Deals_Rejected__c);
        }

        List<Deal__c> DealIns = [SELECT Id,Acceptances__c,Rejections__c FROM Deal__c ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,DealIns[i].Acceptances__c);
            System.assertEquals(1,DealIns[i].Rejections__c);
        }

    }

    @IsTest
    static void testUpdateAcpAction(){

        insert DMLForDealViewer.CreateDealActions('Accepted');

        List<Deal_Action__c> DealActionQ = [SELECT Id,Action__c FROM Deal_Action__c ];
        for(Integer i=0;i<200;i++){
            DealActionQ[i].Action__c = 'Rejected';
        }
        Test.startTest();
        update DealActionQ;
        Test.stopTest();

        List<Contact> ConTest = [SELECT Id,Deals_Accepted__c,Deals_Rejected__c FROM Contact ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,ConTest[i].Deals_Accepted__c);
            System.assertEquals(1,ConTest[i].Deals_Rejected__c);
        }

        List<Deal__c> DealIns = [SELECT Id,Acceptances__c,Rejections__c FROM Deal__c ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,DealIns[i].Acceptances__c);
            System.assertEquals(1,DealIns[i].Rejections__c);
        }

    }

    @IsTest
    static void testUpdateRejAction(){

        insert DMLForDealViewer.CreateDealActions('Rejected');

        List<Deal_Action__c> DealActionQ = [SELECT Id,Action__c FROM Deal_Action__c ];
        for(Integer i=0;i<200;i++){
            DealActionQ[i].Action__c = 'Accepted';
        }
        Test.startTest();
        update DealActionQ;
        Test.stopTest();

        List<Contact> ConTest = [SELECT Id,Deals_Accepted__c,Deals_Rejected__c FROM Contact ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(1,ConTest[i].Deals_Accepted__c);
            System.assertEquals(0,ConTest[i].Deals_Rejected__c);
        }

        List<Deal__c> DealIns = [SELECT Id,Acceptances__c,Rejections__c FROM Deal__c ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(1,DealIns[i].Acceptances__c);
            System.assertEquals(0,DealIns[i].Rejections__c);
        }

    }

    @IsTest
    static void TestUpdateContact() {

        insert DMLForDealViewer.CreateDealActions('Accepted');

        Contact ToUpd = [SELECT Id FROM Contact WHERE FirstName = 'Test2' LIMIT 1];

        Deal_Action__c DealUpd = [SELECT Id,Contact__c FROM Deal_Action__c
                                    WHERE Id !=:ToUpd.Id LIMIT 1];

        Id OldConId = DealUpd.Contact__c;
        DealUpd.Contact__c = ToUpd.Id;
        Test.startTest();
        update DealUpd;
        Test.stopTest();

        Contact oldCon = [SELECT Deals_Accepted__c,Deals_Rejected__c FROM Contact WHERE Id =:OldConId  LIMIT 1];
        System.assertEquals(0,oldCon.Deals_Accepted__c);
        System.assertEquals(0,oldCon.Deals_Rejected__c);

        Contact newCon = [SELECT Deals_Accepted__c,Deals_Rejected__c FROM Contact WHERE FirstName='Test2' LIMIT 1];
        System.assertEquals(2,newCon.Deals_Accepted__c);
        System.assertEquals(0,newCon.Deals_Rejected__c);

    }

    @IsTest
    static void TestUpdateDeal() {

        insert DMLForDealViewer.CreateDealActions('Rejected');

        Deal__c ToUpd = [SELECT Id FROM Deal__c WHERE Name = 'Test2Deal' LIMIT 1];

        Deal_Action__c DealUpd = [SELECT Id,Deal__c FROM Deal_Action__c
        WHERE Id !=:ToUpd.Id LIMIT 1];

        Id OldDealId = DealUpd.Deal__c;
        DealUpd.Deal__c = ToUpd.Id;
        Test.startTest();
        update DealUpd;
        Test.stopTest();

        Deal__c oldDeal = [SELECT Acceptances__c,Rejections__c FROM Deal__c WHERE Id =:OldDealId  LIMIT 1];
        System.assertEquals(0,oldDeal.Acceptances__c);
        System.assertEquals(0,oldDeal.Rejections__c);

        Deal__c newDeal = [SELECT Acceptances__c,Rejections__c FROM Deal__c WHERE Name='Test2Deal' LIMIT 1];
        System.assertEquals(0,newDeal.Acceptances__c);
        System.assertEquals(2,newDeal.Rejections__c);

    }

    @IsTest
    static void TestDeleteAccepted(){

        insert DMLForDealViewer.CreateDealActions('Accepted');

        List<Deal_Action__c> DealActionQ = [SELECT Id,Action__c FROM Deal_Action__c ];
        for(Integer i=0;i<200;i++){
            DealActionQ[i].Action__c = 'Accepted';
        }
        Test.startTest();
        delete DealActionQ;
        Test.stopTest();

        List<Contact> ConTest = [SELECT Id,Deals_Accepted__c,Deals_Rejected__c FROM Contact ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,ConTest[i].Deals_Accepted__c);
            System.assertEquals(0,ConTest[i].Deals_Rejected__c);
        }

        List<Deal__c> DealIns = [SELECT Id,Acceptances__c,Rejections__c FROM Deal__c ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,DealIns[i].Acceptances__c);
            System.assertEquals(0,DealIns[i].Rejections__c);
        }

    }

    @IsTest
    static void TestDeleteRejected(){

        insert DMLForDealViewer.CreateDealActions('Rejected');

        List<Deal_Action__c> DealActionQ = [SELECT Id,Action__c FROM Deal_Action__c ];
        for(Integer i=0;i<200;i++){
            DealActionQ[i].Action__c = 'Rejected';
        }
        Test.startTest();
        delete DealActionQ;
        Test.stopTest();

        List<Contact> ConTest = [SELECT Id,Deals_Accepted__c,Deals_Rejected__c FROM Contact ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,ConTest[i].Deals_Accepted__c);
            System.assertEquals(0,ConTest[i].Deals_Rejected__c);
        }

        List<Deal__c> DealIns = [SELECT Id,Acceptances__c,Rejections__c FROM Deal__c ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,DealIns[i].Acceptances__c);
            System.assertEquals(0,DealIns[i].Rejections__c);
        }

    }

    @IsTest
    static void TestUndeleteAccepted(){

        insert DMLForDealViewer.CreateDealActions('Accepted');

        List<Deal_Action__c> DealActionQ = [SELECT Id,Action__c FROM Deal_Action__c ];
        for(Integer i=0;i<200;i++){
            DealActionQ[i].Action__c = 'Accepted';
        }
        delete DealActionQ;
        Test.startTest();
        undelete DealActionQ;
        Test.stopTest();

        List<Contact> ConTest = [SELECT Id,Deals_Accepted__c,Deals_Rejected__c FROM Contact ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(1,ConTest[i].Deals_Accepted__c);
            System.assertEquals(0,ConTest[i].Deals_Rejected__c);
        }

        List<Deal__c> DealIns = [SELECT Id,Acceptances__c,Rejections__c FROM Deal__c ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(1,DealIns[i].Acceptances__c);
            System.assertEquals(0,DealIns[i].Rejections__c);
        }

    }

    @IsTest
    static void TestUndeleteRejected(){

        insert DMLForDealViewer.CreateDealActions('Rejected');

        List<Deal_Action__c> DealActionQ = [SELECT Id,Action__c FROM Deal_Action__c ];
        for(Integer i=0;i<200;i++){
            DealActionQ[i].Action__c = 'Rejected';
        }
        delete DealActionQ;
        Test.startTest();
        undelete DealActionQ;
        Test.stopTest();

        List<Contact> ConTest = [SELECT Id,Deals_Accepted__c,Deals_Rejected__c FROM Contact ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,ConTest[i].Deals_Accepted__c);
            System.assertEquals(1,ConTest[i].Deals_Rejected__c);
        }

        List<Deal__c> DealIns = [SELECT Id,Acceptances__c,Rejections__c FROM Deal__c ];
        for(Integer i=0;i<200;i++){
            System.assertEquals(0,DealIns[i].Acceptances__c);
            System.assertEquals(1,DealIns[i].Rejections__c);
        }

    }

}