@RestResource(urlMapping='/InventoryUpdate/*')
global with sharing class InventoryRestResource {

    /**
     * @description Architect Concept: Custom Inbound REST Endpoint
     * Exposed endpoint to allow external systems to POST data directly into the org.
     */
    @HttpPost
    global static String updateInventory() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {
            // In a real scenario, this payload contains external ERP inventory status
            String payload = req.requestBody != null ? req.requestBody.toString() : '';
            
            // DML or Logic to apply updates to Order/Inventory objects goes here.
            
            res.statusCode = 200;
            return '{"status": "Success", "message": "Inventory locally synchronized."}';
            
        } catch(Exception e) {
            // Architect Concept: Centralized Inbound Error Logging
            Integration_Log__c log = new Integration_Log__c();
            log.Direction__c = 'Inbound';
            log.Error_Message__c = e.getMessage() + '\n' + e.getStackTraceString();
            log.Payload__c = req.requestBody != null ? req.requestBody.toString() : 'Blank Payload';
            insert log;
            
            // Return 500 status to ERP
            res.statusCode = 500;
            return '{"status": "Error", "message": "Failed to process payload. Log saved."}';
        }
    }
}
