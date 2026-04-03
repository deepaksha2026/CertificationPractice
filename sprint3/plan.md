# Sprint 3 Implementation Plan: Identity & Access Management (IAM)

This sprint dives deep into generally the hardest architectural credential: **Identity and Access Management**. We are going to establish how external legacy systems securely authenticate to our org without passwords, and how human partners log in via SSO.

## 🎯 Technical Objectives

1. **OAuth 2.0 JWT Bearer Flow (Machine-to-Machine):** When the external ERP system wants to hit our new `/InventoryUpdate/` REST endpoint, it cannot use a username and password (which breaks every 90 days and is insecure). We will architect a certificate-backed JWT flow.
2. **SAML 2.0 Single Sign-On (SSO):** Human partners accessing an Experience Cloud site shouldn't create new passwords. They should federate using an external Identity Provider (IdP).

## 🏗️ Proposed Components

### 1. Connected App Configuration (Metadata)
- **[NEW]** `force-app/main/default/connectedApps/Logistics_ERP_Integration.connectedApp-meta.xml`
  - A Connected App strictly configured to trust an uploaded X.509 Digital Certificate.
  - Used by the ERP to retrieve an Access Token seamlessly in the background.
  
### 2. IAM Implementation Playbook (Documentation)
Since Identity federation (SAML SSO) relies heavily on UI setups and third-party systems (like Auth0, Azure AD, or Okta), code cannot deploy the full solution alone. I will generate a granular **IAM Playbook** inside your workspace detailing exactly how to manually bridge Salesforce to a free Identity Provider for SAML 2.0.
