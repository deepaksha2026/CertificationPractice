@isTest
private class ShipmentSharingServiceTest {
    
    @testSetup
    static void setupTestData() {
        // Setup Account and Order
        Account acc = new Account(Name='Global Logistics Partner');
        insert acc;

        Order testOrder = new Order(
            AccountId = acc.Id, 
            EffectiveDate = Date.today(), 
            Status = 'Draft'
        );
        insert testOrder;

        // Create standard User to act as the Driver
        Profile p = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1];
        User mockDriver = new User(
            Alias = 'mdriv', 
            Email='mockdriver@universallogistics.com', 
            EmailEncodingKey='UTF-8', 
            LastName='MockDriver', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', 
            UserName='mockdriver' + DateTime.now().getTime() + '@universallogistics.com.architect'
        );
        insert mockDriver;
    }

    @isTest
    static void testApexManagedSharingForDriver() {
        // Extract setup data
        User mockDriver = [SELECT Id FROM User WHERE LastName='MockDriver' LIMIT 1];
        Order ord = [SELECT Id FROM Order LIMIT 1];
        
        // Create Shipment
        Shipment__c testShipment = new Shipment__c(
            Order__c = ord.Id,
            Driver__c = mockDriver.Id
        );
        
        Test.startTest();
        // Since we are not writing a Trigger in this Sprint, we manually call the Service class
        // In a real Architect scenario, we abstract logic to a Service or Domain layer
        insert testShipment;
        ShipmentSharingService.grantDriverAccess(new List<Shipment__c>{testShipment});
        Test.stopTest();
        
        // ARCHITECT CONCEPT: Validate Data Visibility
        // Query the Sharing Object to ensure a manual rule was created
        List<Shipment__Share> shares = [
            SELECT Id, UserOrGroupId, AccessLevel, RowCause 
            FROM Shipment__Share 
            WHERE ParentId = :testShipment.Id 
              AND UserOrGroupId = :mockDriver.Id
        ];
        
        System.assertEquals(1, shares.size(), 'A share record should have been created for the Driver.');
        System.assertEquals('Edit', shares[0].AccessLevel, 'Driver should have read/write (Edit) access.');
        System.assertEquals('Manual', shares[0].RowCause, 'RowCause should be Manual for custom objects without defined reasons.');
    }
}
