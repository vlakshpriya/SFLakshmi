/**
 * Created by lakshmip on 12/4/2018.
 */

trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    List<Task> AssignTask = new List<Task>();
    for(Opportunity opp : Trigger.new){
        if(opp.StageName == 'Closed Won') {
            Task t = New Task();
            t.Subject = 'Follow Up Test Task';
            t.WhatId = opp.Id;
            AssignTask.add(t);
        }
    }
    insert AssignTask;

}