/**
 * Created by lakshmip on 1/7/2019.
 */
({

    ShowDealAction : function(component,event,helper){

        component.set("v.Columns", [
            {label:"Action", fieldName:"Action__c", type:"picklist"},
            {label:"Contact", fieldName:"Contact__c", type:"Lookup"},
            {label:"Deal", fieldName:"Deal__c", type:"Lookup"},
            {label:"Deal Action Name", fieldName:"Name", type:"AutoNumber"},
            {label:"Deal Date", fieldName:"Deal_Date__c", type:"Date"},

        ]);

        var action = component.get("c.getDealActions");
        action.setParams({
            recordId: component.get("v.recordId")
        });
        action.setCallback(this,function(data){
            component.set("v.Deal_Action",data.getReturnValue());
        });
        $A.enqueueAction(action);
    }

})