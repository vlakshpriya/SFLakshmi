/**
 * Created by lakshmip on 12/7/2018.
 */

global class DailyLeadProcessor implements Schedulable{
    global void execute(SchedulableContext sc){
        List<Lead> lstOfLead = [SELECT Id FROM Lead WHERE LeadSource = NULL LIMIT 200];

        List<Lead> lstOfUpdatedLead = new List<Lead>();
        if(!lstOfLead.isEmpty()){
            for(Lead ld : lstOfLead){
                ld.LeadSource = 'Dreamforce';
                lstOfUpdatedLead.add(ld);
            }

            update lstOfUpdatedLead;
        }
    }
}