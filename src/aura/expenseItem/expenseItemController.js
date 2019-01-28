/**
 * Created by lakshmip on 1/7/2019.
 */
({
    doInit : function(component, event, helper) {
        var mydate = component.get("v.expense.Date__c");
        if(mydate){
            component.set("v.formatdate", new Date(mydate));
        }
    }, 
})