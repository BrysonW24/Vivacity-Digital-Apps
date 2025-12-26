# Google Cloud Platform (GCP) Deployment Guide

**Comprehensive End-to-End Guide for Deploying Apps on Google Cloud**

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [GCP vs AWS vs Azure](#gcp-vs-aws-vs-azure)
3. [Architecture Overview](#architecture-overview)
4. [Account Setup](#account-setup)
5. [Service Selection & Costs](#service-selection--costs)
6. [Development Environment](#development-environment)
7. [Deployment Pipeline](#deployment-pipeline)
8. [Production Infrastructure](#production-infrastructure)
9. [Client Handover](#client-handover)
10. [Monitoring & Maintenance](#monitoring--maintenance)

---

## Executive Summary

**GCP Key Strengths**:
- Best for data & AI workloads
- Superior cloud storage (Google Cloud Storage)
- Strong Kubernetes support (GKE)
- BigQuery for analytics
- Google's ecosystem integration

**GCP Key Weaknesses**:
- Steeper learning curve
- Fewer pre-built templates than AWS
- Less ecosystem tooling

**Target Audience**: Apps needing analytics, data processing, AI/ML
**Estimated Timeline**: 2-4 weeks from account to production
**Monthly Cost Estimate**: $40-180 for small apps (20% cheaper than AWS)

---

## GCP vs AWS vs Azure Comparison

| Feature | AWS | GCP | Azure |
|---------|-----|-----|-------|
| **Ease of Use** | Medium | Hard | Easy |
| **Price** | Moderate | 20% cheaper | 10% more |
| **Data/Analytics** | Good | Excellent | Good |
| **AI/ML** | Good | Excellent | Good |
| **Kubernetes** | EKS | GKE (best) | AKS |
| **Serverless** | Lambda | Cloud Functions | Functions |
| **Database** | RDS | Cloud SQL | SQL Database |
| **File Storage** | S3 | GCS | Blob Storage |
| **Learning Curve** | Medium | Hard | Easy |

**Choose GCP if**:
- You need advanced analytics (BigQuery)
- You want Kubernetes/GKE
- You prefer Google tools ecosystem
- You need AI/ML capabilities
- Cost is critical (20% cheaper)

**Choose AWS if**:
- You want most documentation/community
- You need traditional infrastructure
- You want widest tool selection
- Team familiar with AWS

**Choose Azure if**:
- Using Microsoft stack (SQL Server, Office)
- Enterprise Windows/enterprise focus
- Team familiar with Azure
- Want easiest learning curve

---

## Architecture Overview

### Typical Small App Stack on GCP

```
┌─────────────────────────────────────────────────┐
│              Client Application                  │
│       (Web, Mobile, Desktop - via API)           │
└────────────────────┬────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────┐
│         Cloud Load Balancer + CDN                │
│      (Entry point, caching, DDoS protection)     │
└────────────────────┬────────────────────────────┘
                     │
        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
    ┌─────────┐ ┌────────┐  ┌──────────┐
    │ Cloud   │ │Compute │  │ App      │
    │Function │ │Engine  │  │ Engine   │
    └─────────┘ └────────┘  └──────────┘
        │            │            │
        └────────────┼────────────┘
                     │
┌────────────────────▼────────────────────────────┐
│              Cloud SQL Database                  │
│         (PostgreSQL / MySQL / MariaDB)            │
└─────────────────────────────────────────────────┘
        │                           │
        ▼                           ▼
    ┌──────────┐             ┌──────────┐
    │Google    │             │MemoryStore│
    │Cloud     │             │ (Redis)   │
    │Storage   │             └──────────┘
    │(GCS)     │
    └──────────┘
```

---

## Account Setup

### Phase 1: Create GCP Account (1-2 hours)

#### Step 1: Create Google Cloud Account

1. **Visit Google Cloud Console**: https://console.cloud.google.com
2. **Click "Create Account"** or **Sign in with Google Account**
3. **Provide Billing Information**:
   - Credit/debit card (required, even for free tier)
   - Billing address
   - Phone verification

4. **Create Project**:
   - Project name: "MyApp Production"
   - Organization: (optional, for teams)
   - Billing account: Select or create

5. **Enable APIs**:
   - Cloud Functions API
   - Cloud SQL API
   - Cloud Storage API
   - Cloud Pub/Sub API

**Cost**: Free tier includes:
- 2 million API calls/month
- 5 GB storage
- 300 credit for first year

#### Step 2: Secure Your Account

```bash
# Enable 2FA
1. Go to Google Account settings
2. Enable 2-Step Verification
3. Configure authenticator app

# Create Service Account (for deployment)
1. Go to IAM & Admin → Service Accounts
2. Create new service account
3. Grant roles: Editor (for testing)
4. Create JSON key file (save securely)
5. Download credentials JSON

# Create limited service account for production
1. Create new service account
2. Assign only necessary roles (Principle of Least Privilege)
3. Example: Cloud Function invoker, Cloud SQL client
```

#### Step 3: Set Up Billing Alerts

```bash
1. Go to Billing → Budgets & Alerts
2. Create budget: $100-200/month
3. Set alert threshold: 80%
4. Confirm email for notifications
```

---

## Service Selection & Costs

### Recommended GCP Services for Small Apps

| Service | Purpose | Small App Cost | Why? |
|---------|---------|----------------|------|
| **Cloud Load Balancer** | API endpoint | $18/M | Pay-per-LB, auto-scaling |
| **Cloud Functions** | App code | $0-15/M | Free tier: 2M requests/month |
| **Cloud SQL** | Database | $10-40/M | Managed, automated backups |
| **GCS** | File storage | $0.020/GB | Cheaper than S3 |
| **Cloud CDN** | CDN | $0.085/GB | Similar to CloudFront |
| **Cloud Monitoring** | Monitoring | Free | 150MB/day included |
| **Cloud DNS** | DNS | $0.40/month | Cheap domain management |
| **Pub/Sub** | Messaging | $0-5/M | Free for small volume |

### Cost Breakdown (Small App)

```
Monthly Cost Estimate for 10K Monthly Users:
─────────────────────────────────────
Cloud Functions:    $10
Cloud SQL (db-f1):  $15
GCS:                $0.50
Cloud CDN:          $2
Cloud Load Balancer:$18
Cloud Monitoring:   Free
Cloud DNS:          $0.40
Backup storage:     $1
─────────────────────────────────────
Total:            ~$47/month (30% cheaper than AWS)

Growth scenario (100K users):
Cloud Functions:   $80
Cloud SQL (db-g1): $40
GCS:               $4
Cloud CDN:         $15
Cloud Load Balancer:$18
─────────────────────────────────────
Total:           ~$157/month
```

### Service Alternatives

**Serverless (Cloud Functions + Load Balancer)** ← RECOMMENDED
- Cost: $40-150/month
- Scaling: Automatic
- Best for: APIs, microservices

**Traditional (Compute Engine + Cloud SQL)**
- Cost: $30-100/month
- Scaling: Manual or instance groups
- Best for: Long-running services

**Containerized (GKE + Cloud SQL)**
- Cost: $50-200/month (includes 3 nodes)
- Scaling: Automatic
- Best for: Complex microservices, Kubernetes

**Recommendation**: Start with Cloud Functions

---

## Development Environment

### Phase 1: Install gcloud CLI

```bash
# macOS
brew install --cask google-cloud-sdk

# Windows
# Download: https://cloud.google.com/sdk/docs/install-sdk

# Linux
curl https://sdk.cloud.google.com | bash
exec -l $SHELL

# Initialize
gcloud init
# - Choose project
# - Set default region (us-central1)
# - Set default compute zone (us-central1-a)
```

### Phase 2: Configure Credentials

```bash
# Authenticate
gcloud auth login

# Set project
gcloud config set project PROJECT_ID

# Create service account key
gcloud iam service-accounts create deployment --display-name="Deployment"
gcloud iam service-accounts keys create key.json \
  --iam-account=deployment@PROJECT_ID.iam.gserviceaccount.com

# Store in environment
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/key.json"
```

### Phase 3: Install Development Tools

```bash
# Cloud Functions Framework (Python)
pip install functions-framework

# Cloud Code for IDE (VS Code)
# Install extension: Google Cloud Code

# Docker (for local testing)
docker --version

# kubectl (for GKE)
gcloud components install kubectl
```

---

## Deployment Pipeline

### Phase 1: Create Cloud Functions

#### Simple HTTP Function

```yaml
# Create: main.py
import functions_framework
from flask import jsonify

@functions_framework.http
def my_app(request):
    request_json = request.get_json()
    name = request_json.get('name', 'World')
    return jsonify(f'Hello {name}!')
```

```bash
# Deploy
gcloud functions deploy my-app \
  --runtime python39 \
  --trigger-http \
  --allow-unauthenticated \
  --region us-central1 \
  --entry-point my_app

# Get function URL
gcloud functions describe my-app --region us-central1

# Test
curl https://us-central1-PROJECT_ID.cloudfunctions.net/my-app \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"name":"App"}'
```

### Phase 2: Set Up Cloud SQL Database

```bash
# Create instance
gcloud sql instances create my-app-db \
  --database-version POSTGRES_14 \
  --tier db-f1-micro \
  --region us-central1 \
  --backup

# Create database
gcloud sql databases create my_app \
  --instance=my-app-db

# Create user
gcloud sql users create admin \
  --instance=my-app-db \
  --password=[STRONG_PASSWORD]

# Get connection name
gcloud sql instances describe my-app-db \
  --format='value(connectionName)'
```

### Phase 3: Set Up Cloud Storage

```bash
# Create bucket
gsutil mb gs://my-app-bucket-unique-name

# Enable versioning
gsutil versioning set on gs://my-app-bucket-unique-name

# Set lifecycle (delete old versions after 90 days)
gsutil lifecycle set lifecycle.json gs://my-app-bucket-unique-name
```

### Phase 4: Configure Cloud Load Balancer

```bash
# Create backend service
gcloud compute backend-services create my-app-backend \
  --global \
  --protocol HTTP

# Create URL map
gcloud compute url-maps create my-app-lb \
  --default-service=my-app-backend

# Create HTTP proxy
gcloud compute target-http-proxies create my-app-proxy \
  --url-map=my-app-lb

# Create global forwarding rule
gcloud compute forwarding-rules create my-app-rule \
  --global \
  --target-http-proxy=my-app-proxy \
  --address=my-app-ip \
  --ports=80
```

### Phase 5: Deploy with Cloud Run

```yaml
# Create: Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 app:app
```

```bash
# Build and push to Container Registry
gcloud builds submit --tag gcr.io/PROJECT_ID/my-app

# Deploy to Cloud Run
gcloud run deploy my-app \
  --image gcr.io/PROJECT_ID/my-app \
  --platform managed \
  --region us-central1 \
  --memory 512Mi \
  --allow-unauthenticated \
  --set-env-vars DB_HOST=127.0.0.1,DB_NAME=my_app
```

---

## Production Infrastructure

### High Availability Setup

```
┌──────────────────────────────────────────────────┐
│        Cloud DNS (Global load balancing)          │
└──────────────────────┬───────────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
    ┌────────┐    ┌────────┐    ┌────────┐
    │us-central│  │us-east │   │europe- │
    │  Cloud   │  │  Cloud │   │  Cloud │
    │  Run     │  │  Run   │   │  Run   │
    └────┬────┘  └────┬───┘   └────┬───┘
         │            │             │
         └────────────┼─────────────┘
                      │
        ┌─────────────┴─────────────┐
        ▼                           ▼
    ┌────────────┐          ┌────────────┐
    │Cloud SQL   │◄────────►│Cloud SQL   │
    │Primary     │          │Read Replica│
    │(us-central)│          │(us-east)   │
    └────────────┘          └────────────┘
```

### Auto-Scaling Configuration

```bash
# Cloud Functions auto-scale automatically (no config needed)

# Cloud Run auto-scaling
gcloud run services update my-app \
  --min-instances=1 \
  --max-instances=10 \
  --memory=512Mi \
  --cpu=1 \
  --region=us-central1

# Instance Group for Compute Engine
gcloud compute instance-groups managed create my-app-group \
  --base-instance-name=my-app \
  --template=my-app-template \
  --size=3 \
  --zone=us-central1-a

# Auto-scaling policy
gcloud compute autoscaling-policies create my-app-policy \
  --scale-based-on-cpu \
  --cpu-target=0.6 \
  --min-num-replicas=2 \
  --max-num-replicas=10
```

### Backup & Disaster Recovery

```bash
# Enable automated backups for Cloud SQL
gcloud sql instances patch my-app-db \
  --backup-start-time=03:00 \
  --retained-backups-count=30

# Create on-demand backup
gcloud sql backups create \
  --instance=my-app-db \
  --description="Pre-production backup"

# Cross-region replication (read replica)
gcloud sql instances create my-app-db-replica \
  --master-instance-name=my-app-db \
  --region=us-east1 \
  --tier=db-f1-micro

# GCS bucket replication
gsutil -m cp -r gs://my-app-bucket/* gs://my-app-backup-bucket/
```

### Logging & Monitoring

```bash
# View Cloud Functions logs
gcloud functions logs read my-app --limit 50

# Create monitoring alert
gcloud alpha monitoring policies create \
  --notification-channels=CHANNEL_ID \
  --display-name="High Error Rate" \
  --condition-display-name="Error Rate > 5%" \
  --condition-threshold-value=5

# View metrics
gcloud monitoring time-series list \
  --filter='resource.type="cloud_function"'

# Create custom dashboard
gcloud monitoring dashboards create --config-from-file=dashboard.yaml
```

---

## Client Handover

### Documentation Package

**Create Operations Manual with**:
1. Architecture diagram
2. Service access credentials
3. Deployment procedures
4. Monitoring setup
5. Troubleshooting guide
6. Cost tracking
7. Security procedures
8. Escalation contacts

### Training Timeline

```
Week 1: Architecture & Console Navigation
- Day 1: Overview of GCP services used
- Day 2: Console walkthrough
- Day 3: Cloud Monitoring dashboard
- Day 4: Logs & debugging
- Day 5: Q&A

Week 2: Hands-On Operations
- Day 1: Client deploys update (supervised)
- Day 2: Client responds to alert (supervised)
- Day 3: Backup/restore procedure
- Day 4: Disaster recovery walkthrough
- Day 5: Final Q&A
```

### Support Structure

**First 30 Days** (Included):
- 5 hours/week support
- Slack/email for questions
- Bi-weekly check-ins

**Ongoing** (Optional):
- $X/month for 4 hours/week
- 24-hour response time
- Quarterly optimization reviews

---

## Cost Optimization for GCP

### Reduce Monthly Costs

| Strategy | Savings | How |
|----------|---------|-----|
| **Committed Use Discounts** | 30-37% | Commit to 1-3 year usage |
| **Preemptible VMs** | 70% | Use for non-critical work |
| **Sustained-use Discounts** | 25-30% | Automatic for long-running |
| **Storage Classes** | 50% | Archive old data |
| **Reserved Cloud SQL** | 30-37% | Reserve instances |
| **GCS Lifecycle** | 40% | Move to cheaper storage class |
| **CDN Bypass** | 30% | Cache at edge, reduce origin |

### GCP Cost vs AWS (Monthly)

```
Same workload on AWS vs GCP:
                    AWS        GCP      Savings
────────────────────────────────────────────
Storage            $3.00      $1.00    67%
Database           $30.00     $15.00   50%
Functions/Compute  $20.00     $10.00   50%
CDN                $3.00      $2.00    33%
────────────────────────────────────────────
Total             $56.00     $28.00   50%

(20-50% cheaper on GCP for similar workloads)
```

---

## Troubleshooting

### Common Issues

**Cloud Function Timeout**
```bash
# Increase timeout
gcloud functions deploy my-app \
  --timeout=540s \
  --memory=512MB
```

**Database Connection Errors**
```bash
# Check Cloud SQL auth proxy
cloud_sql_proxy -instances=PROJECT:REGION:INSTANCE=tcp:5432

# Verify IP authorization
gcloud sql instances describe my-app-db \
  --format='value(ipAddresses[0].ipAddress)'
```

**High Latency**
```bash
# Check logs
gcloud functions logs read my-app --limit=100 --format=json

# Monitor performance
gcloud monitoring read \
  --filter='resource.type="cloud_function"' \
  --filter='metric.type="cloudfunctions.googleapis.com/execution_times"'
```

---

## Deployment Checklist

```
Pre-Launch
─────────────────────────────────
Infrastructure:
  ☐ All GCP services created
  ☐ Cloud SQL backup tested
  ☐ GCS bucket configured
  ☐ Load balancer working

Security:
  ☐ IAM roles configured
  ☐ Service account secured
  ☐ Firewall rules set
  ☐ No hardcoded secrets

Code & Testing:
  ☐ Code reviewed
  ☐ Tests passing
  ☐ Load tested
  ☐ Security scanned

Monitoring:
  ☐ Alerts configured
  ☐ Logging enabled
  ☐ Dashboard created
  ☐ Quotas reviewed

Launch Day
─────────────────────────────────
  ☐ Final security check
  ☐ Team on standby
  ☐ Backup created
  ☐ Deploy to production
  ☐ Monitor for 1 hour
  ☐ Verify all functionality
```

---

## Quick Reference Commands

```bash
# Project management
gcloud config set project PROJECT_ID
gcloud projects list

# Cloud Functions
gcloud functions deploy FUNCTION_NAME
gcloud functions logs read FUNCTION_NAME
gcloud functions delete FUNCTION_NAME

# Cloud SQL
gcloud sql instances list
gcloud sql databases list --instance=INSTANCE_NAME
gcloud sql backups list --instance=INSTANCE_NAME

# Cloud Storage
gsutil ls
gsutil cp file.txt gs://bucket/
gsutil versioning set on gs://bucket/

# Cloud Run
gcloud run deploy SERVICE_NAME
gcloud run services list
gcloud run logs read SERVICE_NAME

# Monitoring
gcloud monitoring dashboards list
gcloud monitoring policies list
```

---

## GCP Advantages Over AWS

✅ **Better Data Analytics** (BigQuery)
✅ **Superior Kubernetes** (GKE)
✅ **Cheaper Storage** (50% less than S3)
✅ **Better AI/ML** (TensorFlow, Vertex AI)
✅ **Simpler Pricing** (committed discounts built-in)
✅ **Better for startups** (generous free tier)

---

## When to Use GCP

- ✅ Data-heavy applications
- ✅ Analytics/BI requirements
- ✅ Kubernetes/container focus
- ✅ AI/ML integration needed
- ✅ Cost is critical
- ✅ Google tools ecosystem

---

**Last Updated**: November 30, 2025
**Comparable to**: AWS_DEPLOYMENT_GUIDE.md
**Recommended For**: Data & analytics applications
