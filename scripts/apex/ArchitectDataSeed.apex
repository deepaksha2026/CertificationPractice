// 1. Query Existing Mock Driver User
User mockDriver = [SELECT Id FROM User WHERE FirstName = 'Deepak' AND LastName = 'Standard' LIMIT 1];

// Assign the Permission Set to the Mock Driver if they don't already have it
PermissionSet ps = [SELECT Id FROM PermissionSet WHERE Name = 'Logistics_App_Access' LIMIT 1];
List<PermissionSetAssignment> existingAsgmt = [
    SELECT Id FROM PermissionSetAssignment 
    WHERE AssigneeId = :mockDriver.Id AND PermissionSetId = :ps.Id
];
if(existingAsgmt.isEmpty()) {
    insert new PermissionSetAssignment(AssigneeId = mockDriver.Id, PermissionSetId = ps.Id);
}

// 2. Create an Account and Order for lookup
Account acc = new Account(Name='Global Logistics Enterprise');
insert acc;
Order testOrder = new Order(AccountId=acc.Id, Status='Draft', EffectiveDate=Date.today());
insert testOrder;

// 3. Create Shipment assigned to the Driver
Shipment__c newShipment = new Shipment__c(
    Order__c = testOrder.Id,
    Driver__c = mockDriver.Id
);
insert newShipment;

// 4. Architect Trigger Action 
// (Since we don't have a Trigger written yet, we call the Apex logic manually)
ShipmentSharingService.grantDriverAccess(new List<Shipment__c>{ newShipment });

// 5. Query and Print the expected Sharing result
List<Shipment__Share> shares = [
    SELECT ParentId, UserOrGroupId, AccessLevel, RowCause 
    FROM Shipment__Share 
    WHERE ParentId = :newShipment.Id 
      AND UserOrGroupId = :mockDriver.Id
];

System.debug('--- ARCHITECT SHARING RESULTS ---');
System.debug('Total Custom Share Records Generated: ' + shares.size());
if(!shares.isEmpty()) {
    System.debug('Driver Access Level Granted: ' + shares[0].AccessLevel);
}
