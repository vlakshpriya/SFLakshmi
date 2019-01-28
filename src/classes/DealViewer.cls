/**
 * Created by lakshmip on 12/12/2018.
 */

public with sharing class DealViewer {

    public static void AfterInsert(List<Deal_Action__c> DealActionList){

        /***************Fetching List of Contact IDs********************/
        List<Id> contactId = new List<Id>();
        List<Id> DealId = new List<Id>();
        for(Deal_Action__c dealAct: DealActionList){
            contactId.add(dealAct.Contact__c);
            DealId.add(dealAct.Deal__c);
        }
        Map<Id,Contact> relatedConMap = new Map<Id, Contact>([SELECT Id,Deals_Accepted__c,Deals_Rejected__c FROM Contact
                                                                WHERE Id IN :contactId]);

        Map<Id,Deal__c> relatedDealMap = new Map<Id, Deal__c>([SELECT Id,Acceptances__c,Rejections__c FROM Deal__c
                                                                WHERE Id IN :DealId]);


        /***************Fields to Update in Contact Object********************/
        List<Contact> conToUpd = new List<Contact>();
        List<Deal__c> DealToUpd = new List<Deal__c>();

        for(Deal_Action__c dealAct: DealActionList){

            /***************Fetching related contact for every DealAction********************/
            Contact con = relatedConMap.get(dealAct.Contact__c);
            Deal__c deal = relatedDealMap.get(dealAct.Deal__c);

            /***************Checking Whether the Action is Accepted********************/
            if (dealAct.Action__c == 'Accepted') {

                if (con.Deals_Accepted__c == null || deal.Acceptances__c == null ){
                    System.debug('Checking DealsAccepted is null');
                    con.Deals_Accepted__c = 0;
                    deal.Acceptances__c = 0;
                }
                con.Deals_Accepted__c = con.Deals_Accepted__c + 1;
                deal.Acceptances__c = deal.Acceptances__c + 1;
                conToUpd.add(con);
                DealToUpd.add(deal);
            }

            /***************Checking Whether the Action is Rejected********************/
            if (dealAct.Action__c == 'Rejected' || deal.Rejections__c == null) {

                if ((con.Deals_Rejected__c == null)) {
                    System.debug('Checking DealsRejected is null');
                    con.Deals_Rejected__c = 0;
                    deal.Rejections__c = 0;
                }
                con.Deals_Rejected__c = con.Deals_Rejected__c + 1;
                deal.Rejections__c = deal.Rejections__c + 1;
                conToUpd.add(con);
                DealToUpd.add(deal);
            }
        }

        update conToUpd;
        update DealToUpd;

    }

}