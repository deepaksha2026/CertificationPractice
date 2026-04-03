# Sprint 1 Walkthrough: Data Modeling & Sharing

We have successfully generated the foundational Data and Sharing Architecture components for the Global B2B Order Management System. These artifacts simulate scenarios frequently encountered in the Salesforce Architect exams.

## What Was Built

### 1. The `Shipment__c` Custom Object
- **Path:** `force-app/main/default/objects/Shipment__c`
- **Architect Concept:** We established a strict **Private** sharing model (OWD) inside the XML metadata. 
- **Relationships:**
  - `Order__c` (Lookup): Linking it via lookup rather than Master-Detail allows us to explicitly manage the sharing visibility un-coupled from the Order's visibility.
  - `Driver__c` (Lookup to User): This establishes the assignment field used by our Apex algorithms to dynamically calculate share access.

### 2. Large Data Volume Processing (`OrderDataMigrationBatch.cls`)
- **Path:** `force-app/main/default/classes/OrderDataMigrationBatch.cls`
- **Architect Concept:** Designed a structural representation for handling Large Data Volumes (LDV).
- Simulated off-platform data archiving to external systems to mitigate Salesforce storage constraints. In a real-world scenario, this is combined with **Salesforce Connect** or **Bulk API V2 / PK Chunking** strategies. 

### 3. Apex Managed Sharing (`ShipmentSharingService.cls`)
- **Path:** `force-app/main/default/classes/ShipmentSharingService.cls`
- **Architect Concept:** Implemented programmatic capability to bypass strict Private OWD restrictions based on custom logic.
- We insert `Shipment__Share` objects associated with the user referenced in `Driver__c`, assigning them automatic `Edit` access securely via system mode.

### 4. Code Validation & Test Assertions (`ShipmentSharingServiceTest.cls`)
- **Path:** `force-app/main/default/classes/ShipmentSharingServiceTest.cls`
- Integrated automated tests simulating external driver interactions and verifying that the platform securely generates the correct underlying Share mapping.

---

## 🚦 Next Steps: Validation

Because we're developing locally via Salesforce DX, these components exist conceptually on your local machine.

To officially test the architecture inside Salesforce, please run this terminal command in your workspace to deploy these components to your authenticated Sandbox/Scratch org:

```bash
sf project deploy start --test-level RunLocalTests
```

This will deploy the Data Object, build the relations, and automatically fire the Unit Tests to ensure your Data and Sharing Architecture is solid!

---

## 🛠️ Post-Deployment Action Items (Manual Verification)

Once your deployment `sf project deploy start` succeeds, log into your Salesforce Org and perform these manual validation steps to truly cement your learning:

1. **Verify OWD (Organization-Wide Defaults):**
   - Navigate to **Setup** -> **Sharing Settings**.
   - Verify that the Default Internal Access and Default External Access for the `Shipment` object is set to **Private**.

2. **Assign Permissions (FLS):**
   - Ensure your System Administrator profile (and the mock Driver profile) has **Field-Level Security** visibility to the `Order__c` and `Driver__c` lookup fields on the Shipment object. 

3. **Verify Execution of LDV Batch:**
   - Open the **Developer Console**.
   - Execute the batch manually via Anonymous Apex: `Database.executeBatch(new OrderDataMigrationBatch());`
   - Check **Navigation** -> **Apex Jobs** to witness the asynchronous execution log processing. 

4. **Verify Apex Managed Sharing Execution:**
   - Create a dummy `User` and a test `Shipment` record in the UI, assigning the dummy User in the `Driver__c` field.
   - Run the Apex Managed sharing method from the Developer console explicitly, or observe your system logs.
   - Run this SOQL query in the Dev Console to prove the Architect pattern worked: 
     `SELECT ParentId, UserOrGroupId, AccessLevel, RowCause FROM Shipment__Share` 
   - You should see a manual share record granting Edit access!
