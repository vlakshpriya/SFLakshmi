/**
 * Created by lakshmip on 12/17/2018.
 */

public class DealActionTriggerHandler {

    /*****************************AfterInsertMethod**************************************/
    public static void afterInsert(List<Deal_Action__c> DealActionList){

        AggregateContact(ContactIds(DealActionList));
        AggregateDeal(DealIds(DealActionList));

    }

    /*****************************AfterUpdateMethod**************************************/
    public static void afterUpdate(List<Deal_Action__c> DealActionList,List<Deal_Action__c> DealActionOldList){

        Set<Id> cIds = new Set<Id>();
        cIds.addAll(ContactIds(DealActionOldList));
        cIds.addAll(ContactIds(DealActionList));
        AggregateContact(cIds);


        Set<Id> dIds = new Set<Id>();
        dIds.addAll(DealIds(DealActionOldList));
        dIds.addAll(DealIds(DealActionList));
        AggregateDeal(dIds);

    }

    /*****************************AfterDeleteMethod**************************************/
    public static void afterDelete(List<Deal_Action__c> DealActionList){

        AggregateContact(ContactIds(DealActionList));
        AggregateDeal(DealIds(DealActionList));

    }

    /*****************************AfterUndeleteMethod**************************************/
    public static void afterUnDelete(List<Deal_Action__c> DealActionList){

        AggregateContact(ContactIds(DealActionList));
        AggregateDeal(DealIds(DealActionList));

    }

    /*****************************Fetching Set of ContactIds**************************************/
    public static Set<Id> ContactIds(List<Deal_Action__c> DealActionList){

        System.debug('Fetching Contact IDs');
        Set<Id> contactId = new Set<Id>();
        for(Deal_Action__c dealAct: DealActionList){
            if(dealAct!=null)
            {
                if(dealAct.Contact__c != null){
                    contactId.add(dealAct.Contact__c);
                }
            }
        }
        return contactId;

    }

    /*****************************Fetching Set of DealIds**************************************/
    public static Set<Id> DealIds(List<Deal_Action__c> DealActionList){

        System.debug('Fetching Deal IDs');
        Set<Id> dealId = new Set<Id>();
        for(Deal_Action__c dealAct: DealActionList){
            if(dealAct!=null)
            {
                if(dealAct.Deal__c != null){
                    dealId.add(dealAct.Deal__c);
                }
            }
        }
        return dealId;

    }

    /************Calculating Aggregate Contacts and updating Contact list***************************/
    public static void AggregateContact(Set<Id> ContactIds){

        System.debug('Inside Aggregate Contact');


        List<Contact> conResults = new List<Contact>();

        List<AggregateResult> results = [SELECT Contact__c,Action__c,COUNT(Id) countId
        FROM Deal_Action__c WHERE Contact__c IN :ContactIds
        GROUP BY Contact__c,Action__c];

        System.debug('AggregateResultContact' + results);

        Map<String,AggregateResult> ContactDealAction = new Map<String, AggregateResult>();

        for(AggregateResult ar : results) {
            ContactDealAction.put(ar.get('Contact__c')+''+ar.get('Action__c'),ar);
        }

        for(Id id : ContactIds){

            Contact con = new Contact();
            con.Id = id;

            AggregateResult ResultAcp = ContactDealAction.get(id+'Accepted');
            AggregateResult ResultRej = ContactDealAction.get(id+'Rejected');

            if(con.Deals_Accepted__c == null){
                con.Deals_Accepted__c = 0;
            }

            if(ResultAcp != null) {
                con.Deals_Accepted__c = (Decimal) ResultAcp.get('countId');
            }

            if(con.Deals_Rejected__c == null){
                con.Deals_Rejected__c = 0;
            }

            if(ResultRej!=null) {
                con.Deals_Rejected__c = (Decimal) ResultRej.get('countId');
            }

            conResults.add(con);
        }
        update conResults;

    }

    /************Calculating Aggregate Deal and updating Deal list***************************/
    public static void AggregateDeal(Set<Id> DealIds){

        System.debug('Inside Aggregate Deal');

        List<Deal__c> dealResults = new List<Deal__c>();

        List<AggregateResult> results = [SELECT Deal__c,Action__c,COUNT(Id) countId
        FROM Deal_Action__c WHERE Deal__c IN :DealIds
        GROUP BY Deal__c,Action__c];

        Map<String,AggregateResult> DealDealAction = new Map<String, AggregateResult>();

        for(AggregateResult ar : results) {
            DealDealAction.put(ar.get('Deal__c')+''+ar.get('Action__c'),ar);
        }

        for(Id id : DealIds){

            Deal__c deal = new Deal__c();
            deal.Id = id;

            AggregateResult ResultAcp = DealDealAction.get(id+'Accepted');
            AggregateResult ResultRej = DealDealAction.get(id+'Rejected');

            if(deal.Acceptances__c == null){
                deal.Acceptances__c = 0;
            }
            if(ResultAcp!=null) {
                deal.Acceptances__c = (Decimal) ResultAcp.get('countId');
            }

            if(deal.Rejections__c == null){
                deal.Rejections__c = 0;
            }
            if(ResultRej!=null) {
                deal.Rejections__c = (Decimal) ResultRej.get('countId');
            }

            dealResults.add(deal);
        }
        update dealResults;

    }

}