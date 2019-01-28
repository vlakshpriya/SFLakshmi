/**
 * Created by lakshmip on 1/7/2019.
 */

public with sharing class DealViewerController {

    @AuraEnabled
    public static List<wrapperClass> getDeals(Id recordId){

        List<wrapperClass> WrapList = new List<wrapperClass>();
        List<Deal__c> DealsList = new List<Deal__c>([SELECT Id,Name,Valid_Through__c,Available_Deals__c FROM Deal__c
                                                    WHERE Available_Deals__c > 0 AND Valid_Through__c >= TODAY
                                                    AND Id NOT IN (SELECT Deal__c FROM Deal_Action__c
                                                    WHERE Contact__c = :recordId)]);
        for(Deal__c Deal: DealsList){
            wrapperClass wrapper = new wrapperClass();
            wrapper.DealId = Deal.Id;
            wrapper.DealName = Deal.Name;
            wrapper.AvailableDeals = Deal.Available_Deals__c;
            wrapper.ValidThrough = Deal.Valid_Through__c;
            WrapList.add(wrapper);
            wrapper.status = 'Available';
        }
        return WrapList;

    }

    @AuraEnabled
    public static Deal_Action__c createDealActions(Id recordId,Id DealId,String Action){

        Deal_Action__c dealAction = new Deal_Action__c();
        dealAction.Contact__c = recordId;
        dealAction.Deal__c = DealId;
        dealAction.Action__c = Action;
        insert dealAction;
        return dealAction;

    }

    public class wrapperClass{

        @AuraEnabled public String DealId{get;set;}
        @AuraEnabled public String DealName{get;set;}
        @AuraEnabled public Decimal AvailableDeals{get;set;}
        @AuraEnabled public Datetime ValidThrough{get;set;}
        @AuraEnabled public String status{get;set;}
    }

}