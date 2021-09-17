({
    handleSuccess : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "variant": "success",
            "title": "Customer_Report__c",
            "message": "Record ID: " + event.getParam("id")
        });
        toastEvent.fire();
        //Return to view records
        var urlEvent = $A.get("e.force:navigateToURL");
        let urlString = window.location.href;
        let baseURL = urlString.substring(0, urlString.indexOf("/s"));
        urlEvent.setParams({
          "url": baseURL+"/lightning/o/Customer_Report__c/list?filterName=Recent"
        });
        urlEvent.fire();
    },
    handleLoad: function (cmp, event, helper) {
        var record = event.getParam("recordUi");
        var fieldNames = Customer_Report__c.keys(record.fields);
        component.set("v.fields", fieldNames);
    }
})