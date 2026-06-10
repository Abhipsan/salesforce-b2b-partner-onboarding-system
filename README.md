# Automated B2B Lead Routing & Partner Onboarding System

## Project Overview

This project is a Salesforce-based enterprise CRM solution that automates partner registration, lead scoring, approval workflows, regional lead assignment, and partner onboarding for a global manufacturing company.

The system eliminates manual partner processing, reduces duplicate records, improves response times, and provides secure role-based access for regional managers.

---

## Business Problem

The company receives thousands of partner applications from different regions.

Manual processing caused:

- Delayed onboarding
- Duplicate partner records
- Inefficient lead assignment
- Security and visibility issues
- Poor response times

This solution automates the complete partner onboarding lifecycle.

---

## Technology Stack

- Salesforce CRM
- Apex
- Apex Triggers
- Lightning Web Components (LWC)
- SOQL
- Salesforce Flows
- REST API Integration
- Permission Sets
- Sharing Rules
- Git & GitHub
- Salesforce CLI

---

## Key Features

### Partner Registration Wizard (LWC)

- Responsive registration form
- Real-time duplicate validation
- Dynamic field handling
- Apex integration

### Automated Lead Scoring

Lead score calculated using:

- Company Size
- Annual Revenue
- Region

### Regional Lead Assignment

Applications are automatically assigned to the correct Regional Manager.

### Approval Workflow Automation

Salesforce Flow automatically:

- Approves partner applications
- Creates Partner Accounts
- Updates status
- Sends notifications

### ERP Integration

Approved partner records are sent to an external ERP system through REST API callouts.

### Security Model

Implemented:

- Profiles
- Permission Sets
- Sharing Rules
- Field-Level Security
- Role Hierarchy

Regional managers can only access data for their assigned territory.

---

## Custom Objects

### Partner_Application__c

Stores incoming partner applications.

### Partner_Account__c

Stores approved partner information.

### Regional_Manager__c

Stores territory assignment information.

### Partner_Document__c

Stores partner documents.

### Lead_Scoring__c

Stores lead scoring information.

---

## Architecture

See:

Docs/architecture-diagram/system-architecture.png

---

## Trigger Framework

Implemented a bulkified Apex Trigger Framework to:

- Prevent duplicate applications
- Score leads
- Assign regional managers
- Handle bulk record processing

---

## Flow Automation

Record-Triggered Flow automates:

- Approval process
- Partner Account creation
- Status updates
- Notifications

---

## REST API Integration

Apex HTTP callouts send approved partner data to a mock ERP endpoint.

Example payload:

```json
{
  "companyName": "Global Tech Ltd",
  "email": "global@test.com",
  "region": "Asia",
  "status": "Approved"
}
```

---

## Reports & Dashboards

Implemented dashboards for:

- Partner Approval Analytics
- Region-wise Partner Count
- Pending Approvals
- Lead Score Analysis

---

## Testing

Implemented Apex Test Classes for:

- Trigger Framework
- Lead Scoring Logic
- Assignment Logic
- REST Callouts

Coverage includes:

- Positive Scenarios
- Negative Scenarios
- Bulk Data Processing

---

## Screenshots

Screenshots available in:

Docs/Screenshots/

---

## Project Structure

```text
salesforce-b2b-partner-onboarding-system
│
├── Docs
│   ├── Screenshots
│   ├── architecture-diagram
│   └── setup-guide
│
├── force-app
│   └── main
│       └── default
│           ├── classes
│           ├── lwc
│           ├── objects
│           ├── triggers
│           ├── flows
│           └── permissionsets
│
├── README.md
└── sfdx-project.json
```

---

## Setup Instructions

1. Clone repository
2. Authorize Salesforce Org
3. Deploy metadata
4. Assign Permission Sets
5. Activate Flows
6. Configure Named Credentials (optional)
7. Execute test classes

---

## Concepts Demonstrated

- Bulkification
- Governor Limits
- Trigger Framework Pattern
- Apex Best Practices
- SOQL Optimization
- LWC ↔ Apex Communication
- REST API Integration
- Salesforce Security Model
- Asynchronous Processing

---

## Resume Description

Developed an enterprise-level Salesforce Partner Onboarding System using Apex, LWC, SOQL, Flows, and REST APIs to automate lead routing, partner approvals, regional assignment, and onboarding workflows. Implemented secure role-based access, asynchronous processing, trigger framework architecture, and real-time validations to improve operational efficiency and automate partner management processes.