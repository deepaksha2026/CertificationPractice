# Sprint 2 Implementation Plan: Integration Architecture

This sprint focuses on the **Salesforce Integration Architecture** domain. We will establish how our "Global Logistics" org communicates with their external, legacy ERP system handling inventory.

## 🎯 Technical Objectives

1. **Fire-and-Forget (Outbound Event-Driven Integration):** When an Order is marked "Ready to Ship," Salesforce shouldn't wait for the ERP to respond. It should broadcast an event asynchronously.
2. **REST API (Inbound Real-Time Updates):** The ERP needs to push live "Inventory Updates" directly back into Salesforce for Sales Reps to see.
3. **Error Logging:** Robust integration requires an architecture for recording dropped payloads or failures.

## 🏗️ Proposed Components

### 1. External System Notifier (Platform Event)
- **[NEW]** `ERP_Notification__e` 
  - A custom Platform Event object. 
  - Used to decouple Salesforce core transaction limits from the external HTTP callouts.

### 2. Custom Integration Error Logging (Data Architecture)
- **[NEW]** `Integration_Log__c`
  - A custom object to store API errors and retry payloads. This is a critical pattern tested extensively conceptually in the Integration Architect exam.

### 3. Outbound Publishing Engine (Apex)
- **[NEW]** `OrderIntegrationService.cls`
  - Service class responsible for publishing `ERP_Notification__e` safely.
  - Generates `Integration_Log__c` records if the `EventBus.publish()` method returns failures.

### 4. Inbound Endpoint (Apex REST API)
- **[NEW]** `InventoryRestResource.cls`
  - Exposed via `@RestResource(urlMapping='/InventoryUpdate/*')`.
  - Handles `HTTP POST` commands from the ERP to securely update stock values locally without burning standard REST API limits.
