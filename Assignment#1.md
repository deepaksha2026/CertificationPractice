# 🏗️ Assignment #1: Global Enterprise B2B Order Management System

## 🎯 The Scenario
"Universal Logistics" is a massive global B2B supplier. They receive thousands of orders per day from their partners. Their current Salesforce org is hitting governor limits, partners are seeing orders they shouldn't, and integration with their legacy ERP system is failing under heavy load. 

As the newly hired Architect, you need to redesign and rebuild the solution. 

## 🏗️ Technical Pillars to Implement

### 1. Data Architecture
- **Large Data Volumes (LDV):** Orders and Order Line Items will accumulate millions of records.
- **Implementation:** 
  - Design a robust Data Model around `Account`, `Order`, and custom `Shipment__c`.
  - Simulate moving old Order data off-platform and using **External Objects (Salesforce Connect)** to surface archived data without storing it in Salesforce.
  - Implement **PK Chunking** or **Bulk API V2** batch scripts to demonstrate handling massive data migrations.

### 2. Sharing and Visibility Architecture
- **Complex Visibility:** Partners should only see their own accounts, but regional managers need visibility across their territories, and specialized support reps need access based on the specific product lines.
- **Implementation:**
  - Implement **Account Teams** and **Enterprise Territory Management**.
  - Write **Apex Managed Sharing** for `Shipment__c` records so they are automatically shared with the specific driver assigned, despite strict OWDs.
  - Create a **Partner Community (Experience Cloud)** with external sharing models and Sharing Sets.

### 3. Integration Architecture
- **ERP Synchronization:** When an order is "Ready to Ship", the system needs to notify the external ERP.
- **Implementation:**
  - Build an Event-Driven integration using **Platform Events** (Fire-and-Forget) to decouple Salesforce from the ERP.
  - Build a custom **REST API** endpoint inside Salesforce to allow the ERP to push immediate inventory updates back into Salesforce.
  - Build robust retry mechanisms, error handling frameworks, and Governor Limit protections.

### 4. Identity & Access Management (IAM)
- **External Partner Login:** Partners shouldn't need a separate Salesforce password.
- **Implementation:**
  - Configure a **Connected App** to simulate an external system authenticating into Salesforce using the **OAuth 2.0 JWT Bearer Flow**.
  - Document and configure **Single Sign-On (SSO)** using SAML 2.0 (we can use a free developer Identity Provider like Auth0 or Okta) for the Experience Cloud Partner site.

### 5. Development Lifecycle & Deployment
- **Implementation:**
  - Modularize the codebase into **Unlocked Packages** instead of massive "Happy Soup" deployments.
  - Setup a mock **GitHub Actions** or Bitbucket Pipelines YAML file to demonstrate automated CI/CD when committing to the main branch.
  - Implement Apex test coverage with mock callouts and assert statements to simulate enterprise-grade testing frameworks.

---

## 🚦 Sprints

1. **Sprint 1: Data Modeling & Sharing Patterns** (Building the Data & Sharing foundations)
2. **Sprint 2: Platform Events & REST Callouts** (Integration patterns)
3. **Sprint 3: Connected Apps & Identity** (IAM implementations)
4. **Sprint 4: CI/CD & Formatting the Workspace** (Dev Lifecycle implementations)
