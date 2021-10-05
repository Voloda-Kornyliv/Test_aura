({
    okClick : function(component, event, helper) {
        var resultsToast = $A.get("e.force:showToast");
        resultsToast.setParams({
            "title": "Delete ALL Lead records",
            "message": "Starting the deletion of all Lead records This may take a while. You will receive an email once the deletion has finished"
        });
        resultsToast.fire();
        console.log(10);
        var action = component.get("c.DeleteRecords"); 
        console.log(12);
        action.setCallback(this, function(response) { 
            var state = response.getState(); 
            if (state === "SUCCESS") { 
                console.log("SUCCESS");
            } 
            else { 
                console.log("FAILED");
            } 
        }); 
        $A.enqueueAction(action);
        $A.get("e.force:closeQuickAction").fire();
    },
    cancelClick: function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    }
})
