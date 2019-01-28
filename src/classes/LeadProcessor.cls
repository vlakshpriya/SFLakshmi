/**
 * Created by lakshmip on 12/7/2018.
 */

global class LeadProcessor implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT LeadSource from Lead]);
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope){
        for(Lead Leads : scope){
            Leads.LeadSource = 'Dreamforce';
        }
        update scope;
    }

    global void finish(Database.BatchableContext bc){

    }
}