/**
 * Created by lakshmip on 12/20/2018.
 */
({
    packItem: function(component, event, helper)
    {
        let item = component.get("v.item");
        item.Packed__c = true;
        component.set("v.item", item);
        component.set("v.disabled", true)
    },
})