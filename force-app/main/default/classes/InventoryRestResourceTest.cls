@isTest
private class InventoryRestResourceTest {
    
    @isTest
    static void testUpdateInventorySuccess() {
        // Architect Concept: Mocking the RestRequest and RestResponse contexts
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();
        
        req.requestURI = '/services/apexrest/InventoryUpdate/';
        req.httpMethod = 'POST';
        // Simulate an arbitrary JSON Payload arriving from the legacy ERP
        req.requestBody = Blob.valueOf('{"orderId": "ORD-123", "status": "Shipped", "stock": 500}');
        
        RestContext.request = req;
        RestContext.response = res;
        
        Test.startTest();
        String result = InventoryRestResource.updateInventory();
        Test.stopTest();
        
        // Assert API cleanly responded
        System.assertEquals(200, res.statusCode, 'Expected 200 HTTP OK Status.');
        System.assert(result.contains('Success'), 'Expected successful response JSON string.');
    }

    @isTest
    static void testUpdateInventoryFailureLogger() {
        // By explicitly failing to map the RestContext variables, we inject a NullPointerException 
        // which forces our custom Integration_Log__c logic to process.
        
        Test.startTest();
        String result = InventoryRestResource.updateInventory();
        Test.stopTest();
        
        // Architect Validation: Ensure our Custom Logging captured the failure cleanly
        List<Integration_Log__c> generatedLogs = [SELECT Id, Direction__c, Error_Message__c FROM Integration_Log__c];
        
        System.assertEquals(1, generatedLogs.size(), 'Exactly one Integration Log should be tracked due to the crash.');
        System.assertEquals('Inbound', generatedLogs[0].Direction__c, 'Logging direction must correlate to Inbound REST failures.');
        System.assertNotEquals(null, generatedLogs[0].Error_Message__c, 'Stack trace should be preserved.');
    }
}
