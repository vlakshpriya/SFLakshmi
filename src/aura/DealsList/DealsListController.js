/**
 * Created by lakshmip on 1/8/2019.
 */
({
    ShowDeals : function(component,event,helper){
debugger;
            component.set("v.Columns", [
                {label:"Deal ID", fieldName:"DealId", type:"text"},
                {label:"Deal Name", fieldName:"DealName", type:"text"},
                {label:"Valid Through", fieldName:"ValidThrough", type:"Date"},
                {label:"Available Deals", fieldName:"AvailableDeals", type:"number"},
                {label:"Status", fieldName:"status", type:"text"},
                {label:"Action",type:'button',typeAttributes:{
                           label: 'Accept',
                           name: 'Accept',
                           title: 'Accept',
                           disabled: false,
                           value: 'Accept'
                         }
                },
                {type:'button',typeAttributes:{
                            label: 'Reject',
                            name: 'Reject',
                            title: 'Reject',
                            disabled: false,
                            value: 'Reject'
                            }
                }
            ]); 

            var action = component.get("c.getDeals");
            action.setParams({
                recordId: component.get("v.recordId")
            });
            action.setCallback(this,function(data){
                component.set("v.data",data.getReturnValue());
            });
            $A.enqueueAction(action);

    },

    handleRowAction: function(component,event,helper){

        var action = event.getParam('action');
        var row =  event.getParam('row');
        if (action.name = 'Accept'){

            alert("Accept clicked");
            alert('Showing Details: ' + JSON.stringify(row));
            var result = component.get("c.createDealActions");
            result.setParams({
                recordId: component.get("v.recordId"),
                DealId : row.DealId,
                Action: action.name
            });
            result.setCallback(this,function(response){
                    row.status = 'Accepted'
                    alert(row.status);
                    component.set("v.response")
            });
            $A.enqueueAction(result);
        }

    }

})