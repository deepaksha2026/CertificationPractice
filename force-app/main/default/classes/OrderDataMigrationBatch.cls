public with sharing class OrderDataMigrationBatch implements Database.Batchable<sObject>, Database.Stateful {
    
    // Architect Concept: Large Data Volume (LDV) Processing 
    // This batch class demonstrates asynchronous approaches for heavy data manipulation.
    private Integer totalProcessed = 0;
    private Integer errorCount = 0;

    public Database.QueryLocator start(Database.BatchableContext bc) {
        // In an LDV scenario, we must ensure selective queries.
        // Assuming 'Status' is indexed or we leverage skinny tables.
        return Database.getQueryLocator([
            SELECT Id, Status 
            FROM Order 
            WHERE Status = 'Closed' 
              AND CreatedDate < LAST_N_DAYS:365
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Order> scope) {
        // Architect Concept: Off-platform Archiving. 
        // Here we simulate extracting old orders to an external ERP/Data Lake 
        // to reduce Salesforce storage limits, and replacing them with External Objects.
        
        for(Order o : scope) {
            // Dummy simulation
            totalProcessed++;
            if (o.Id == null) {
                errorCount++;
            }
        }
    }

    public void finish(Database.BatchableContext bc) {
        // Log telemetry
        System.debug('LDV Archiving Batch Processing Complete.');
        System.debug('Total Processed: ' + totalProcessed);
        System.debug('Errors Encountered: ' + errorCount);
    }
}
