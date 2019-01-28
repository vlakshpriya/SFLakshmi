/**
 * Created by lakshmip on 12/11/2018.
 */

trigger DealActionTrigger on Deal_Action__c (before insert, before update, before delete, after insert,after delete, after undelete, after update ) {

    if (Trigger.isInsert) {

        if (Trigger.isBefore) {

        }
        else if (Trigger.isAfter) {

            DealActionTriggerHandler.afterInsert(Trigger.new);

        }
    }

    if (Trigger.isDelete) {

        if (Trigger.isBefore) {

        }
        else if (Trigger.isAfter) {

            DealActionTriggerHandler.afterDelete(Trigger.old);

        }
    }
    if (Trigger.isUndelete) {

        if (Trigger.isBefore) {

        }
        else if (Trigger.isAfter) {

            DealActionTriggerHandler.afterUnDelete(Trigger.new);

        }
    }

    if (Trigger.isUpdate) {

        if (Trigger.isBefore) {

        }
        else if (Trigger.isAfter) {

            DealActionTriggerHandler.afterUpdate(Trigger.new,Trigger.old);

        }
    }

}