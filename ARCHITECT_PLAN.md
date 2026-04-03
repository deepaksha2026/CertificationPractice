# Salesforce Architect Certification Plan

Based on your current certifications (**Admin, Platform App Builder, PD1, and PD2**), you are in a fantastic position to achieve the Salesforce Architect credentials. Your PD2 certification, in particular, demonstrates a strong level of programmatic expertise that will serve as a solid foundation for the technical components of the architect path.

Salesforce has two main paths leading up to the ultimate **Certified Technical Architect (CTA)**:
1. **Application Architect**
2. **System Architect**

Here is a structured plan to achieve these architect credentials.

---

## Path 1: Salesforce Application Architect

The Application Architect path focuses on data models, sharing, and declarative functionality. Since you already hold Platform App Builder and PD1, you are exactly halfway there!

### Remaining Requirements
1. **Salesforce Data Architect**
   - **Focus:** Large data volumes (LDV), data modeling, database design, and data migration.
   - **Study Strategy:** Learn about Skinny Tables, indexing, PK Chunking, and Master-Data management strategies.
2. **Salesforce Sharing and Visibility Architect**
   - **Focus:** Complex sharing models, security, implicit/explicit sharing, Account teams, and territory management.
   - **Study Strategy:** Review the Salesforce Sharing Architecture guide heavily. Understand the impact of role hierarchies and sharing rules on performance.

### Suggested Order
1. Take **Sharing and Visibility Architect** first. It aligns closely with your Admin and App Builder experience, just at a much larger and more complex scale.
2. Take **Data Architect** next.

*(Once you pass these two, you will automatically be awarded the **Application Architect** credential!)*

---

## Path 2: Salesforce System Architect

The System Architect path is geared toward off-platform integrations, identity management, and governance. You already have the required PD1 certification for this track.

### Remaining Requirements
1. **Development Lifecycle and Deployment Architect**
   - **Focus:** CI/CD, environment management (sandboxes), ALM (Application Lifecycle Management), and branching strategies.
   - **Study Strategy:** With your PD2 experience, you already know deployment via CLI and Metadata API. Focus on governance models, Center of Excellence (CoE), and testing strategies.
2. **Integration Architect**
   - **Focus:** API integration patterns (REST/SOAP, Bulk, Streaming API), event-driven architectures (Platform Events, Change Data Capture), and integration security.
   - **Study Strategy:** Familiarize yourself with the Salesforce Integration Patterns guide. Know exactly when to use Request-Reply vs. Fire-and-Forget, etc.
3. **Identity and Access Management (IAM) Architect**
   - **Focus:** SSO, OAuth flows (Web Server, JWT, User-Agent), SAML, Connected Apps, and multi-factor authentication (MFA).
   - **Study Strategy:** This is often considered one of the hardest. Deep dive into every single OAuth 2.0 flow and SAML implementation.

### Suggested Order
1. **Development Lifecycle & Deployment** (Easiest bridge from PD2).
2. **Integration Architect** (Uses your deep platform knowledge).
3. **IAM Architect** (Typically the steepest learning curve).

*(Once you pass these three, you will automatically be awarded the **System Architect** credential!)*

---

## Phase 3: Certified Technical Architect (CTA)

Once you hold both the Application Architect and System Architect credentials, you become eligible for the **Certified Technical Architect (CTA) Review Board exam**.

### Action Items for the CTA
- **Scenario Practice:** The CTA requires you to read a massive business scenario in 2-3 hours and build an end-to-end architecture (data model, system landscape, sharing model, identity flows, and governance).
- **Presentation Skills:** You must present this to a board of master architects and defend your solutions during Q&A.
- **Mock Boards:** Participating in mock review boards is essential for success.

---

## 📅 Recommended Next Steps and Timeline
- **Month 1-2:** Study for and pass **Sharing and Visibility Architect**. 
- **Month 3-4:** Study for and pass **Data Architect** -> *Receive Application Architect.*
- **Month 5-6:** Study for and pass **Development Lifecycle & Deployment Architect**.
- **Month 7-8:** Study for and pass **Integration Architect**.
- **Month 9-10:** Study for and pass **Identity and Access Management Architect** -> *Receive System Architect.*

> [!TIP]
> **Trailhead Resources:** Start by completing the "Architect Trailmixes" on Trailhead for each specific certification. They provide curated links to the most important official documentation and architectural reference guides.
