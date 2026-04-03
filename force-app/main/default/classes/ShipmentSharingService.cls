public with sharing class ShipmentSharingService {
    
    /**
     * @description Architect Concept: Apex Managed Sharing
     * Custom sharing logic to give Drivers Edit access to shipments they are assigned to,
     * overriding the strictly Private Organization-Wide Defaults.
     */
    public static void grantDriverAccess(List<Shipment__c> shipments) {
        List<Shipment__Share> sharesToInsert = new List<Shipment__Share>();
        
        for(Shipment__c shipment : shipments) {
            if(shipment.Driver__c != null) {
                // Create a new share record
                Shipment__Share driverShare = new Shipment__Share();
                driverShare.ParentId = shipment.Id;
                driverShare.UserOrGroupId = shipment.Driver__c;
                driverShare.AccessLevel = 'Edit';
                // Using standard Manual row cause as standard fallback for custom objects without defined Apex Sharing Reasons
                driverShare.RowCause = Schema.Shipment__Share.RowCause.Manual;
                
                sharesToInsert.add(driverShare);
            }
        }
        
        if(!sharesToInsert.isEmpty()) {
            // Architect Concept: Use Database methods with allOrNone = false for fault tolerance.
            Database.SaveResult[] results = Database.insert(sharesToInsert, false);
            for(Database.SaveResult sr : results) {
                if(!sr.isSuccess()) {
                    // Architect Concept: Logging to an ApplicationLog__c or Eventbus in real systems
                    System.debug('Error inserting share: ' + sr.getErrors()[0].getMessage());
                }
            }
        }
    }
}
