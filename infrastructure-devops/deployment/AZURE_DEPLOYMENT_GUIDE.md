# Microsoft Azure Deployment Guide

**Comprehensive End-to-End Guide for Deploying Apps on Microsoft Azure**

---

## Executive Summary

**Azure Key Strengths**:
- Easiest learning curve
- Best for Microsoft stack integration
- Enterprise-focused features
- Hybrid cloud capabilities
- Strong Windows/SQL Server support

**Azure Key Weaknesses**:
- Slightly more expensive than AWS/GCP
- Complex pricing model
- Smaller open-source community

**Target Audience**: Enterprise apps, Microsoft-stack companies, teams new to cloud
**Estimated Timeline**: 2-4 weeks from account to production
**Monthly Cost Estimate**: $60-250 for small apps (10% more than AWS)

---

## Azure vs AWS vs GCP

| Feature | AWS | GCP | Azure |
|---------|-----|-----|-------|
| **Learning Curve** | Medium | Hard | Easy |
| **Enterprise Ready** | Yes | Yes | Best |
| **Windows/SQL** | Good | Fair | Best |
| **Free Trial** | $300 (12m) | $300 (3m) | $200 (1m) |
| **Pricing** | Baseline | -20% | +10% |
| **Ease of Migration** | Good | Fair | Best |
| **Microsoft Integration** | Fair | Poor | Best |
| **Global Reach** | Excellent | Excellent | Excellent |

**Choose Azure if**:
- Using Microsoft stack (Windows, SQL Server, Office)
- Enterprise Windows environment
- Team new to cloud
- Need hybrid cloud
- Prefer easiest interface

---

## Account Setup

### Phase 1: Create Azure Account (1-2 hours)

#### Step 1: Sign Up

1. **Visit Azure Portal**: https://azure.microsoft.com
2. **Click "Start free"**
3. **Sign in with Microsoft Account** (or create new)
4. **Provide Information**:
   - Name, email, phone
   - Address
   - Credit/debit card

5. **Verify Identity**:
   - SMS or call verification
   - Email confirmation

6. **Accept Agreement**:
   - Review Azure agreement
   - Accept terms

**Includes**:
- $200 free credit (30 days)
- 12 months free services
- Always-free services

#### Step 2: Create Resource Group

```bash
# Resource groups organize resources
# Navigate to: All services → Resource groups → Create

# Or use Azure CLI
az group create \
  --name myapp-rg \
  --location eastus
```

#### Step 3: Configure Access Control

```bash
# Create service principal (for deployments)
az ad sp create-for-rbac \
  --name "myapp-deployer" \
  --role Contributor \
  --scopes /subscriptions/{subscriptionId}/resourceGroups/myapp-rg

# Create limited service accounts
# User 1: DevOps (full access)
# User 2: Developer (read-only monitoring)
# User 3: Client (view-only dashboard)
```

---

## Service Selection & Costs

### Recommended Azure Services

| Service | Purpose | Cost | Why? |
|---------|---------|------|------|
| **App Service** | Web app hosting | $12-80/M | Easy to use, auto-scaling |
| **Azure Functions** | Serverless code | $0-20/M | Pay-per-execution |
| **Azure SQL** | Database | $15-50/M | Managed, enterprise-ready |
| **Blob Storage** | File storage | $0.018/GB | Cheap, reliable |
| **Application Gateway** | Load balancer | $25/M | Full-featured |
| **Application Insights** | Monitoring | Free-$12/M | 5GB/month free |
| **Azure DNS** | DNS | $0.50/M | Integrated with Azure |

### Cost Comparison

```
Monthly Cost for 10K Users:
─────────────────────────────────
App Service (S1):    $65
Azure SQL (S0):      $15
Blob Storage:        $0.50
Application Gateway: $25
Application Insights:Free
Azure DNS:           $0.50
Backup:              $2
─────────────────────────────────
Total:             ~$108/month (10% more than AWS)

Free credits apply to all services for 12 months
```

---

## Development Environment

### Phase 1: Install Azure CLI

```bash
# macOS
brew install azure-cli

# Windows
# Download: https://aka.ms/installazurecliwindows

# Linux
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Verify
az --version
```

### Phase 2: Authenticate

```bash
# Login to Azure
az login

# This opens browser for authentication
# Then returns available subscriptions

# Set default subscription
az account set --subscription "SUBSCRIPTION_NAME"

# Verify
az account show
```

### Phase 3: Install Development Tools

```bash
# Azure Storage Explorer (GUI for Blob Storage)
# Download: https://azure.microsoft.com/products/storage/storage-explorer/

# Azure Data Studio (SQL client)
# Download: https://aka.ms/azuredatastudio

# VS Code Azure extensions
# Install: Azure Tools extension pack

# Docker (for containerized apps)
docker --version
```

---

## Deployment Pipeline

### Phase 1: Create Resource Group & App Service

```bash
# Create resource group
az group create \
  --name myapp-rg \
  --location eastus

# Create App Service Plan (shared hosting)
az appservice plan create \
  --name myapp-plan \
  --resource-group myapp-rg \
  --sku B1 \
  --is-linux

# Create Web App
az webapp create \
  --resource-group myapp-rg \
  --plan myapp-plan \
  --name myapp-web \
  --runtime "python:3.9"
```

### Phase 2: Deploy Application

#### Using Git

```bash
# Enable git deployment
az webapp deployment user set \
  --user-name deployuser \
  --password [SECURE_PASSWORD]

# Get git URL
az webapp deployment source config-local-git \
  --name myapp-web \
  --resource-group myapp-rg

# Push code
git remote add azure [git-url]
git push azure main

# View logs
az webapp log stream \
  --name myapp-web \
  --resource-group myapp-rg
```

#### Using Docker

```bash
# Create Container Registry
az acr create \
  --resource-group myapp-rg \
  --name myappregistry \
  --sku Basic

# Build image
az acr build \
  --registry myappregistry \
  --image myapp:latest \
  .

# Update Web App to use container
az webapp config container set \
  --name myapp-web \
  --resource-group myapp-rg \
  --docker-custom-image-name myappregistry.azurecr.io/myapp:latest \
  --docker-registry-server-url https://myappregistry.azurecr.io
```

### Phase 3: Set Up Database

```bash
# Create Azure SQL Server
az sql server create \
  --name myapp-server \
  --resource-group myapp-rg \
  --admin-user sqladmin \
  --admin-password [STRONG_PASSWORD] \
  --location eastus

# Create database
az sql db create \
  --server myapp-server \
  --name myapp-db \
  --resource-group myapp-rg \
  --service-objective S0

# Get connection string
az sql db show-connection-string \
  --server myapp-server \
  --name myapp-db \
  --client sqlcmd
```

### Phase 4: Configure Storage

```bash
# Create storage account
az storage account create \
  --name myappstg \
  --resource-group myapp-rg \
  --location eastus \
  --sku Standard_LRS

# Create blob container
az storage container create \
  --account-name myappstg \
  --name uploads

# Get storage key for app config
az storage account keys list \
  --account-name myappstg \
  --resource-group myapp-rg
```

### Phase 5: Configure Custom Domain & SSL

```bash
# Add custom domain
az webapp config hostname add \
  --resource-group myapp-rg \
  --webapp-name myapp-web \
  --hostname api.myapp.com

# Create managed SSL certificate
az webapp config ssl create \
  --resource-group myapp-rg \
  --name myapp-web \
  --certificate-name myapp-cert

# List certificates
az webapp config ssl list \
  --resource-group myapp-rg \
  --webapp-name myapp-web
```

---

## Production Infrastructure

### High Availability Setup

```
┌─────────────────────────────────────────────┐
│        Azure Traffic Manager                 │
│    (Global load balancing & failover)       │
└──────────────────────┬──────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
    ┌────────┐    ┌────────┐    ┌────────┐
    │East US │    │West US │    │Europe  │
    │App Svc │    │App Svc │    │App Svc │
    └────┬───┘    └────┬───┘    └────┬───┘
         │             │             │
         └─────────────┼─────────────┘
                       │
        ┌──────────────┼──────────────┐
        ▼                             ▼
    ┌────────────┐          ┌────────────┐
    │Azure SQL   │◄────────►│Azure SQL   │
    │Primary     │          │Read Replica│
    │(East US)   │          │(West US)   │
    └────────────┘          └────────────┘
```

### Auto-Scaling Configuration

```bash
# Create autoscale settings
az monitor autoscale-settings create \
  --resource-group myapp-rg \
  --resource myapp-plan \
  --resource-type "Microsoft.Web/serverfarms" \
  --name myapp-autoscale \
  --min-count 1 \
  --max-count 10 \
  --count 2

# Add scaling rule (CPU > 70%)
az monitor autoscale-settings rule create \
  --autoscale-name myapp-autoscale \
  --resource-group myapp-rg \
  --condition "Percentage CPU > 70 avg 5m" \
  --scale out 1
```

### Backup & Disaster Recovery

```bash
# Enable automated backup for SQL Database
az sql db backup-short-term-retention-policy update \
  --server myapp-server \
  --database myapp-db \
  --resource-group myapp-rg \
  --retention-days 30

# Create backup
az sql db backup create \
  --server myapp-server \
  --database myapp-db \
  --resource-group myapp-rg \
  --name pre-release-backup

# Enable blob storage backup
az storage account backup create \
  --account-name myappstg \
  --resource-group myapp-rg \
  --schedule Daily \
  --retention-days 30

# Create read replica database
az sql db replica create \
  --server myapp-server \
  --name myapp-db-replica \
  --resource-group myapp-rg
```

### Monitoring & Logging

```bash
# Enable Application Insights
az resource create \
  --resource-group myapp-rg \
  --resource-type "Microsoft.Insights/components" \
  --name myapp-insights \
  --properties '{"Application_Type":"web"}'

# Create alert
az monitor metrics alert create \
  --resource-group myapp-rg \
  --name high-error-rate \
  --description "Alert on high error rate" \
  --scopes /subscriptions/{subId}/resourceGroups/myapp-rg \
  --condition "total http 5xx > 100" \
  --window-size 5m \
  --evaluation-frequency 1m

# View application logs
az webapp log tail \
  --name myapp-web \
  --resource-group myapp-rg
```

---

## Client Handover

### Training Schedule

```
Week 1: Foundation & Navigation
- Day 1: Azure Portal overview
- Day 2: Resource navigation
- Day 3: Application Insights dashboard
- Day 4: Log viewing & diagnostics
- Day 5: Q&A

Week 2: Operations
- Day 1: Client deploys code
- Day 2: Client responds to alert
- Day 3: Backup/restore procedures
- Day 4: Disaster recovery
- Day 5: Escalation procedures
```

### Documentation Package

1. **Architecture Diagram**
   - Services used
   - Connections
   - Data flow

2. **Access Credentials**
   - Portal login
   - Connection strings
   - Storage keys
   - SQL credentials

3. **Operations Manual**
   - Deployment process
   - Monitoring procedures
   - Troubleshooting
   - Escalation contacts

4. **Cost Tracking**
   - Monthly budget
   - Cost breakdown
   - Optimization tips
   - Reserved instances info

---

## Cost Optimization

### Reduce Monthly Costs

| Strategy | Savings | How |
|----------|---------|-----|
| **Reserved Instances** | 38% | 1-3 year commitment |
| **Spot VMs** | 90% | Use for non-critical |
| **Hybrid Benefit** | 40% | Use existing licenses |
| **Auto-shutdown** | 30% | Shut down at night |
| **Storage Tiers** | 50% | Archive old data |
| **Commitment Discounts** | 17% | Commit to usage |

### Cost Alerts

```bash
# Create budget alert
az consumption budget create \
  --budget-name myapp-monthly \
  --category cost \
  --limit 200 \
  --time-period Monthly
```

---

## Troubleshooting

### Common Issues

**App Won't Deploy**
```bash
# Check logs
az webapp log tail --name myapp-web --resource-group myapp-rg

# Restart app
az webapp restart --name myapp-web --resource-group myapp-rg

# Check slot configuration
az webapp config appsettings list --name myapp-web --resource-group myapp-rg
```

**Database Connection Timeout**
```bash
# Check firewall rules
az sql server firewall-rule list --server myapp-server --resource-group myapp-rg

# Add IP to whitelist
az sql server firewall-rule create \
  --server myapp-server \
  --name allow-app \
  --start-ip-address 0.0.0.0 \
  --end-ip-address 255.255.255.255
```

**High Costs**
```bash
# Review resource usage
az monitor metrics list-definitions \
  --resource /subscriptions/{subId}/resourceGroups/myapp-rg

# Identify expensive resources
az consumption usage list --resource-group myapp-rg
```

---

## Quick Reference Commands

```bash
# Resource groups
az group list
az group create --name NAME --location LOCATION

# App Service
az webapp list
az webapp create --resource-group RG --plan PLAN --name NAME
az webapp deployment slot create --name NAME --resource-group RG --slot staging

# Database
az sql db list --server SERVER --resource-group RG
az sql db backup create --server SERVER --name DB --resource-group RG

# Storage
az storage account list
az storage blob list --container CONTAINER --account-name ACCOUNT

# Monitoring
az monitor autoscale-settings list --resource-group RG
az monitor metrics list-definitions --resource RESOURCE
```

---

## Azure Unique Features

### Azure Advantage
✅ **Hybrid Cloud** (on-prem + cloud)
✅ **Windows/SQL Server** (best support)
✅ **Enterprise Ready** (compliance, security)
✅ **License Portability** (use existing licenses)
✅ **Easy Migration** (tools & support)

### Deployment Slots
```bash
# Stage changes before production
az webapp deployment slot create \
  --name myapp-web \
  --slot staging \
  --resource-group myapp-rg

# Test in staging
# Then swap with production
az webapp deployment slot swap \
  --name myapp-web \
  --slot staging \
  --resource-group myapp-rg
```

### Application Insights
```bash
# Built-in APM (Application Performance Monitoring)
# Integrated with App Service
# No extra cost (5GB/month free)

# View performance
az monitor app-insights metrics show \
  --resource myapp-insights \
  --resource-group myapp-rg \
  --metric RequestsPerSecond
```

---

## When to Use Azure

- ✅ Microsoft stack (Windows, SQL Server, Office)
- ✅ Enterprise environments
- ✅ Teams new to cloud
- ✅ Hybrid cloud needs
- ✅ License portability important
- ✅ Need enterprise support

---

## Comparison Summary

| Aspect | AWS | GCP | Azure |
|--------|-----|-----|-------|
| **Cost** | Baseline | -20% | +10% |
| **Learning** | Medium | Hard | Easy |
| **Enterprise** | Excellent | Good | Best |
| **Community** | Largest | Medium | Growing |
| **Free Tier** | $300/12m | $300/3m | $200/1m |
| **Best For** | General | Data/AI | Microsoft |

---

**Last Updated**: November 30, 2025
**Comparable to**: AWS_DEPLOYMENT_GUIDE.md & GCP_DEPLOYMENT_GUIDE.md
**Recommended For**: Enterprise & Microsoft environments
