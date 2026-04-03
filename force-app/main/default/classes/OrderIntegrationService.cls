public with sharing class OrderIntegrationService {

    /**
     * @description Architect Concept: Event-Driven Outbound Integration
     * Publishes Platform Events so Salesforce does not wait for a synchronous HTTP fallback.
     */
    public static void publishERPNotification(List<Order> readyOrders) {
        List<ERP_Notification__e> notifications = new List<ERP_Notification__e>();
        
        for(Order ord : readyOrders) {
            notifications.add(new ERP_Notification__e(Order_Id__c = ord.Id));
        }

        if(!notifications.isEmpty()) {
            List<Database.SaveResult> results = EventBus.publish(notifications);
            
            // Architect Concept: Integration Error Handling & Custom Logging
            List<Integration_Log__c> logsToInsert = new List<Integration_Log__c>();
            
            for(Integer i=0; i<results.size(); i++) {
                Database.SaveResult sr = results[i];
                if(!sr.isSuccess()) {
                    Integration_Log__c log = new Integration_Log__c();
                    log.Direction__c = 'Outbound';
                    log.Error_Message__c = sr.getErrors()[0].getMessage();
                    log.Payload__c = JSON.serialize(notifications[i]);
                    logsToInsert.add(log);
                }
            }
            
            if(!logsToInsert.isEmpty()) {
                insert logsToInsert;
            }
        }
    }
}
