/**
 * Created by lakshmip on 1/16/2019.
 */

trigger AccountTrigger on Account (before insert, before update, before delete, after insert, after update, after delete, after undelete) {

    if(Trigger.isAfter && Trigger.isInsert){
        AccountHandler.CreateNewOpportunity(Trigger.new);
    }

    if(Trigger.isBefore && Trigger.isInsert){
        AccountTriggerHandler.CreateAccounts(Trigger.new);
    }
}