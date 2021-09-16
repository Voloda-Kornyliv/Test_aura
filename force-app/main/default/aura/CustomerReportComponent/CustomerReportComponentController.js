({
    handleSuccess : function(component, event, helper) {
        component.find('notifLib').showToast({
            "variant": "success",
            "title": "Customer_Report__c",
            "message": "Record ID: " + event.getParam("id")
        });
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
          "url": "https://resilient-goat-k8vmzv-dev-ed.lightning.force.com/lightning/o/Customer_Report__c/list?filterName=Recent"
        });
        urlEvent.fire();



    }
})