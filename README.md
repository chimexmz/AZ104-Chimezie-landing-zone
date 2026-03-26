# AZ-104 Real world project: Secure Landing Zone + Production Workload

## Overview of the project
This repository contains a real-world, end-to-end Azure Administrator (AZ-104) project.  
The goal is to design and deploy a secure Azure “landing zone” (governance + networking + identity) and host a production-style workload with monitoring, security, backup, and automation — using Infrastructure as Code (IaC) and GitHub Actions.

**Why this project matters:** It mirrors what Azure Administrators do in real organizations:
- Build secure foundations (RBAC, policies, networking)
- Deploy and operate workloads (compute, storage, database)
- Monitor, backup, and automate operations
- Apply cost controls and security best practices

---

## Architecture (High Level)
**Landing Zone + Workload** following a Hub-and-Spoke approach:

- **Governance:** Resource Groups, Tags, Policies, Locks, Budgets
- **Identity:** Entra ID (Azure AD) groups + RBAC assignments
- **Networking:** Hub VNet + Spoke VNet(s), NSGs, Bastion, Private Endpoints (optional)
- **Workload:** App Service (Web/API) + Azure SQL Database + Storage
- **Operations:** Log Analytics, Azure Monitor Alerts, App Insights, Diagnostic Settings
- **Protection:** Backup (Recovery Services Vault if VM is used), Key Vault for secrets
- **Automation:** Scheduled runbooks/scripts (start/stop non-prod, cleanup tasks)
- **CI/CD:** GitHub Actions for IaC validation + deployment (Dev/Prod)

> docs/diagrams/architecture.png

---

## What This Covers in AZ-104
This project intentionally maps to AZ‑104 objective areas:

### 1) Manage Azure identities & governance
- Entra ID groups/users (admin, reader, developer)
- RBAC assignments (least privilege)
- Azure Policy (tag enforcement, allowed locations, security restrictions)
- Resource locks + tagging strategy
- Cost Management: budgets + alerts

### 2) Implement and manage storage
- Storage Account configuration (replication, access tiers)
- Container + lifecycle management rules
- Secure access via RBAC/SAS (as applicable)
- Private Endpoint to Storage (optional)

### 3) Deploy and manage Azure compute
- App Service Plan + App Service deployment
- Deployment slots (staging → production swap)
- Managed identity for secure secret access
- Autoscale configuration (optional)

### 4) Configure and manage virtual networking
- Hub & Spoke VNets
- Subnets + NSGs
- VNet peering
- Bastion for secure admin access
- Private DNS + Private Endpoints (optional)

### 5) Monitor and maintain Azure resources
- Log Analytics Workspace
- Diagnostic Settings forwarding to Log Analytics
- Azure Monitor alerts (availability, failures, thresholds)
- Application Insights for app telemetry
- Backup configuration + restore test documentation (VM scenario)

---

## Repo Structure
```text
az104-contoso-capstone/
├─ README.md
├─ docs/
│  ├─ architecture.md
│  ├─ az104-coverage-checklist.md
│  ├─ runbooks.md
│  ├─ troubleshooting.md
│  └─ diagrams/
├─ infra/
│  ├─ bicep/                 # or terraform/
│  │  ├─ modules/
│  │  ├─ env/
│  │  │  ├─ dev/
│  │  │  └─ prod/
│  │  └─ main.bicep
│  └─ scripts/
│     ├─ deploy.ps1
│     ├─ destroy.ps1
│     └─ validate.ps1
├─ app/
│  ├─ src/                   # sample web/api (optional)
│  └─ deploy/
└─ .github/
   └─ workflows/
      ├─ validate.yml
      ├─ deploy-dev.yml
      └─ deploy-prod.yml

