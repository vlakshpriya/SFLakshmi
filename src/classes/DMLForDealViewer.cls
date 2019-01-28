/**
 * Created by lakshmip on 12/18/2018.
 */

public with sharing class DMLForDealViewer {

    public static List<Contact>  CreateContacts() {

        List<Contact> conList = new List<Contact>();
        for (Integer i = 0; i < 200; i++) {
            Contact con = new Contact(FirstName = 'Test' + i, LastName = 'Contact');
            conList.add(con);
        }
        System.debug('Contact List' + conList);
        return conList;
    }
    public static List<Deal__c>  CreateDeals() {

        List<Deal__c> dealList = new List<Deal__c>();
        for (Integer i = 0; i < 200; i++) {
            Deal__c deal = new Deal__c(Name = 'Test' + i + 'Deal');
            dealList.add(deal);
        }
        System.debug('Deal List' + dealList);
        return dealList;

    }
    public static List<Deal_Action__c> CreateDealActions(String Action){

        List<Contact> conQ = [SELECT Id,FirstName,LastName FROM Contact ];
        List<Deal__c> dealQ = [SELECT Id, Name FROM Deal__c ];

        List<Deal_Action__c> DealActionList = new List<Deal_Action__c>();
        for(Integer i=0;i<200;i++)
        {
            Deal_Action__c da = new Deal_Action__c(
                    Action__c = Action,
                    Contact__c = conQ[i].Id,
                    Deal__c = dealQ[i].Id
            );
            DealActionList.add(da);
        }
        return DealActionList;

    }
}