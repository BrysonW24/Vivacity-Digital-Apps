# AWS Cloud Deployment Guide for Small Apps

**Comprehensive End-to-End Guide for Deploying Apps on AWS**

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Architecture Overview](#architecture-overview)
3. [AWS Account Setup](#aws-account-setup)
4. [Service Selection & Costs](#service-selection--costs)
5. [Development Environment](#development-environment)
6. [Deployment Pipeline](#deployment-pipeline)
7. [Production Infrastructure](#production-infrastructure)
8. [Client Handover](#client-handover)
9. [Monitoring & Maintenance](#monitoring--maintenance)
10. [Cost Optimization](#cost-optimization)

---

## Executive Summary

This guide provides a complete roadmap for deploying a small app on AWS from account creation through client handover. The approach balances cost-effectiveness, scalability, and operational simplicity.

**Target Audience**: Small apps (1K-100K users), startups, MVPs
**Estimated Timeline**: 2-4 weeks from account to production
**Monthly Cost Estimate**: $50-200 for small apps (varies by usage)

---

## Architecture Overview

### Typical Small App Stack

```
┌─────────────────────────────────────────────────────┐
│                  Client Application                  │
│          (Web, Mobile, Desktop - via API)            │
└────────────────────┬────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────┐
│              API Gateway + CloudFront                │
│        (Entry point, caching, DDoS protection)       │
└────────────────────┬────────────────────────────────┘
                     │
        ┌────────────┼────────────┐
        │            │            │
        ▼            ▼            ▼
    ┌────────┐  ┌────────┐  ┌──────────┐
    │ Lambda │  │   EC2  │  │  Fargate │
    │ (Node) │  │(optional)│  │(optional)│
    └────────┘  └────────┘  └──────────┘
        │            │            │
        └────────────┼────────────┘
                     │
┌────────────────────▼────────────────────────────────┐
│                   RDS Database                       │
│           (PostgreSQL / MySQL / Aurora)              │
└─────────────────────────────────────────────────────┘
        │                           │
        ▼                           ▼
    ┌──────────┐             ┌──────────┐
    │   S3     │             │ElastiCache│
    │(storage) │             │ (Redis)   │
    └──────────┘             └──────────┘
```

---

## AWS Account Setup

### Phase 1: Account Creation (1-2 hours)

#### Step 1: Create AWS Account

1. **Visit AWS Signup**: https://aws.amazon.com
2. **Click "Create an AWS Account"**
3. **Provide Required Information**:
   - Email address (use a business/organizational email)
   - Password (strong, 12+ characters)
   - AWS Account Name (e.g., "MyApp Production")
   - Country/Address
   - Payment method (credit card required)

4. **Verify Identity**:
   - Receive verification code via SMS or phone call
   - Enter verification code

5. **Choose Support Plan**:
   - **Basic** (Free): Good for learning, limited support
   - **Developer** ($29/month): Recommended for development
   - **Business** ($100/month+): For critical production apps

**Recommended**: Start with **Basic** plan

#### Step 2: Secure Your Account

```bash
# Set up MFA (Multi-Factor Authentication)
1. Go to AWS Console → Account
2. Click "Security Credentials"
3. Enable MFA for root account
4. Use authenticator app (Google Authenticator, Authy)

# Create IAM Users (don't use root!)
1. Go to IAM Service
2. Create new user: "dev-user" with programmatic access
3. Assign policy: "PowerUserAccess" or custom policies
4. Save Access Key ID and Secret Access Key
5. Never share these credentials
```

#### Step 3: Set Up Billing Alerts

```bash
1. Go to AWS Console → Billing
2. Click "Budgets" → "Create Budget"
3. Set monthly budget ($100-500 for small apps)
4. Set alert threshold (e.g., 80% of budget)
5. Confirm email for alerts
```

### Phase 2: IAM & Access Control (1 hour)

#### Create Production Access Roles

```bash
# User: DevOps Engineer (can deploy)
- Policy: EC2, RDS, S3, CloudWatch full access
- Add MFA requirement

# User: Developer (read-only monitoring)
- Policy: CloudWatch, CloudTrail (view-only)
- Can't make infrastructure changes

# User: Client (view-only dashboard)
- Policy: CloudWatch dashboard access only
- Limited to specific resources
```

**Best Practice**: Never use root account credentials

---

## Service Selection & Costs

### Recommended Services for Small Apps

| Service | Purpose | Small App Cost | Why? |
|---------|---------|----------------|------|
| **API Gateway** | API endpoint | $3.50/M | Pay-per-request, auto-scaling |
| **Lambda** | App code | $0-20/M | Free tier: 1M requests, 400K GB-seconds |
| **RDS** | Database | $15-50/M | Managed, automated backups |
| **S3** | File storage | $1-5/M | Pay-per-GB, highly reliable |
| **CloudFront** | CDN | $0.085/GB | Edge location caching |
| **CloudWatch** | Monitoring | $10/M | Essential for production |
| **Route 53** | DNS | $0.50/month | Cheap domain management |
| **SNS/SQS** | Messaging | $0-5/M | Decouples systems |

### Cost Breakdown (Small App)

```
Monthly Cost Estimate for 10K Monthly Users:
─────────────────────────────────────
API Gateway:        $5
Lambda:            $20
RDS (db.t3.micro): $30
S3:                $2
CloudFront:        $3
CloudWatch:        $10
Route 53:          $0.50
Backup storage:    $2
─────────────────────────────────────
Total:            ~$72/month

Growth scenario (100K users):
API Gateway:       $30
Lambda:           $150
RDS (db.t3.small):$50
S3:               $15
CloudFront:       $20
CloudWatch:       $15
Route 53:         $0.50
─────────────────────────────────────
Total:           ~$280/month
```

### Alternative: Serverless vs. Managed Instances

**Serverless (Lambda + API Gateway + RDS)**
- Cost: $50-200/month
- Scaling: Automatic
- Ops: Minimal
- Best for: APIs, microservices, event-driven

**Traditional (EC2 + RDS)**
- Cost: $30-100/month (can scale higher)
- Scaling: Manual or auto-scaling groups
- Ops: More hands-on
- Best for: Long-running services, containers

**Containerized (ECS/Fargate + RDS)**
- Cost: $50-150/month
- Scaling: Automatic
- Ops: Docker expertise needed
- Best for: Microservices, complex apps

**Recommendation for Small App**: Start with Serverless (Lambda)

---

## Development Environment

### Phase 1: Configure AWS CLI & Tools

#### Install AWS CLI

```bash
# macOS
brew install awscli

# Windows
# Download from: https://aws.amazon.com/cli/

# Linux
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verify installation
aws --version
```

#### Configure AWS CLI Credentials

```bash
# Run configuration
aws configure

# You'll be prompted for:
AWS Access Key ID: [paste from IAM user]
AWS Secret Access Key: [paste from IAM user]
Default region name: us-east-1
Default output format: json
```

#### Install SAM CLI (Serverless Application Model)

```bash
# macOS
brew install aws-sam-cli

# Windows / Linux
# Download from: https://aws.amazon.com/serverless/sam/

# Verify
sam --version
```

### Phase 2: Set Up Version Control Integration

#### Create CodeCommit Repository (AWS Git)

```bash
# Alternative: Use GitHub or GitLab (recommended)

# If using CodeCommit:
aws codecommit create-repository \
  --repository-name my-app \
  --repository-description "My App Backend"
```

#### Set Up CI/CD Pipeline

```bash
# Using GitHub + GitHub Actions:
1. Push code to GitHub
2. Create .github/workflows/deploy.yml
3. Configure AWS credentials in GitHub secrets
4. Pipeline automatically builds and deploys

# Using AWS CodePipeline:
1. Create CodeCommit repo or connect GitHub
2. CodeBuild: Build stage
3. CodeDeploy: Deploy stage
4. Lambda: Auto-execute on changes
```

### Phase 3: Local Development Setup

```bash
# Project structure
my-app/
├── lambda/              # Serverless functions
│   ├── api/
│   └── auth/
├── database/           # Database migrations
├── tests/             # Unit & integration tests
├── infrastructure/    # CloudFormation/SAM templates
│   ├── template.yaml  # SAM template
│   └── parameters.json
├── docs/             # API documentation
└── README.md

# Install dependencies
npm install
pip install -r requirements.txt  # if using Python

# Run locally
sam local start-api  # Start Lambda functions locally
npm test            # Run tests
```

---

## Deployment Pipeline

### Phase 1: Build Infrastructure

#### Create VPC (Virtual Private Cloud)

```bash
# Create VPC with public/private subnets
aws ec2 create-vpc --cidr-block 10.0.0.0/16

# Create subnets (public for API Gateway, private for RDS)
aws ec2 create-subnet \
  --vpc-id vpc-xxx \
  --cidr-block 10.0.1.0/24 \
  --availability-zone us-east-1a

# Create security groups (firewall rules)
aws ec2 create-security-group \
  --group-name lambda-sg \
  --description "Lambda security group"
```

#### Set Up RDS Database

```bash
# Create RDS instance
aws rds create-db-instance \
  --db-instance-identifier my-app-db \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --master-username admin \
  --master-user-password [STRONG_PASSWORD] \
  --allocated-storage 20 \
  --backup-retention-period 7 \
  --storage-encrypted

# Note: Save endpoint, username, password securely
```

#### Create S3 Bucket

```bash
# Create bucket for application files
aws s3 mb s3://my-app-bucket-unique-name

# Enable versioning (keep old versions)
aws s3api put-bucket-versioning \
  --bucket my-app-bucket-unique-name \
  --versioning-configuration Status=Enabled

# Set up lifecycle (delete old backups after 90 days)
aws s3api put-bucket-lifecycle-configuration \
  --bucket my-app-bucket-unique-name \
  --lifecycle-configuration file://lifecycle.json
```

### Phase 2: Deploy Application

#### Deploy with SAM

```bash
# Create CloudFormation stack
sam build
sam deploy --guided

# SAM will prompt you for:
- Stack name (e.g., my-app-dev)
- Region (e.g., us-east-1)
- Confirm changes
- Capabilities (S3 bucket for artifacts)

# Outputs will show:
- API endpoint URL
- Lambda function names
- Deployment status
```

#### Alternative: Deploy Containerized App (ECS/Fargate)

```bash
# Create Docker image
docker build -t my-app:latest .

# Push to Amazon ECR (Elastic Container Registry)
aws ecr create-repository --repository-name my-app
docker tag my-app:latest [AWS_ID].dkr.ecr.us-east-1.amazonaws.com/my-app:latest
docker push [AWS_ID].dkr.ecr.us-east-1.amazonaws.com/my-app:latest

# Create ECS task and service
aws ecs create-service \
  --cluster my-app \
  --service-name my-app-service \
  --task-definition my-app:1 \
  --desired-count 2
```

### Phase 3: Configure Custom Domain

```bash
# Register domain (or use existing)
# Option 1: Register with Route 53
aws route53domains register-domain \
  --domain-name myapp.com \
  --duration-in-years 1

# Option 2: Use existing registrar and point to Route 53

# Create hosted zone
aws route53 create-hosted-zone \
  --name myapp.com \
  --caller-reference unique-id

# Create DNS record for API Gateway
aws route53 change-resource-record-sets \
  --hosted-zone-id Z123456 \
  --change-batch file://dns-changes.json
```

#### DNS Configuration Example

```json
{
  "Changes": [
    {
      "Action": "CREATE",
      "ResourceRecordSet": {
        "Name": "api.myapp.com",
        "Type": "CNAME",
        "TTL": 300,
        "ResourceRecords": [
          {
            "Value": "abc123.execute-api.us-east-1.amazonaws.com"
          }
        ]
      }
    }
  ]
}
```

### Phase 4: Set Up HTTPS/SSL

```bash
# Request SSL certificate with ACM (AWS Certificate Manager)
aws acm request-certificate \
  --domain-name myapp.com \
  --subject-alternative-names www.myapp.com api.myapp.com

# Verify domain ownership:
1. Receive verification email
2. Click verification link
3. Certificate issued (usually 5-30 minutes)

# Attach to API Gateway:
1. API Gateway → Custom domains
2. Create custom domain mapping
3. Select ACM certificate
4. Point DNS CNAME to CloudFront endpoint
```

---

## Production Infrastructure

### High Availability Setup

```
┌──────────────────────────────────────────────────┐
│         Route 53 (DNS + Health Checks)            │
└──────────────────────┬───────────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        ▼              ▼              ▼
    ┌────────┐    ┌────────┐    ┌────────┐
    │us-east │    │us-west │    │eu-west │
    │  (API  │    │  (API  │    │  (API  │
    │Gateway)│    │Gateway)│    │Gateway)│
    └────┬───┘    └────┬───┘    └────┬───┘
         │             │             │
    ┌────▼───┐    ┌────▼───┐    ┌────▼───┐
    │Lambda  │    │Lambda  │    │Lambda  │
    │(app)   │    │(app)   │    │(app)   │
    └────┬───┘    └────┬───┘    └────┬───┘
         │             │             │
         └──────────────┼──────────────┘
                        │
            ┌───────────┴───────────┐
            ▼                       ▼
        ┌────────────┐      ┌────────────┐
        │RDS Primary │      │RDS Read    │
        │ (us-east)  │◄────►│ Replica    │
        └────────────┘      │ (us-west)  │
                            └────────────┘
```

### Auto-Scaling Configuration

```bash
# For Lambda (automatic, no config needed)
# API Gateway automatically scales with demand

# For EC2 (if using instances)
aws autoscaling create-auto-scaling-group \
  --auto-scaling-group-name my-app-asg \
  --launch-configuration my-app-lc \
  --min-size 2 \
  --max-size 10 \
  --desired-capacity 3 \
  --availability-zones us-east-1a us-east-1b

# Scale policies
aws autoscaling put-scaling-policy \
  --auto-scaling-group-name my-app-asg \
  --policy-name scale-up \
  --policy-type TargetTrackingScaling \
  --target-tracking-configuration file://policy.json
```

### Backup & Disaster Recovery

```bash
# RDS automated backups
aws rds modify-db-instance \
  --db-instance-identifier my-app-db \
  --backup-retention-period 30 \
  --preferred-backup-window "03:00-04:00" \
  --preferred-maintenance-window "mon:04:00-mon:05:00"

# Cross-region replication
aws rds create-db-instance-read-replica \
  --db-instance-identifier my-app-db-replica \
  --source-db-instance-identifier my-app-db \
  --db-instance-class db.t3.micro \
  --availability-zone us-west-2a

# S3 cross-region replication
aws s3api put-bucket-replication \
  --bucket my-app-bucket \
  --replication-configuration file://replication.json

# Enable AWS Backup for all resources
aws backup create-backup-vault --backup-vault-name my-app-vault
```

### Logging & Monitoring

```bash
# Enable CloudWatch Logs for Lambda
# (automatically enabled when creating Lambda functions)

# Create custom CloudWatch dashboard
aws cloudwatch put-dashboard \
  --dashboard-name my-app-dashboard \
  --dashboard-body file://dashboard.json

# Set up CloudWatch alarms
aws cloudwatch put-metric-alarm \
  --alarm-name high-error-rate \
  --alarm-description "Alert on high error rate" \
  --metric-name Errors \
  --namespace AWS/Lambda \
  --statistic Sum \
  --period 300 \
  --threshold 10 \
  --comparison-operator GreaterThanThreshold \
  --alarm-actions arn:aws:sns:us-east-1:xxx:alerts
```

---

## Client Handover

### Phase 1: Prepare Handover Documentation (1-2 weeks before)

#### Create Infrastructure Diagram
```
Document all components:
- Architecture diagram
- Data flow
- Security groups
- IAM roles
- Backup procedures
```

#### Create Operations Manual

**Document**:
1. **System Overview**
   - Architecture
   - Technology stack
   - Service interactions

2. **Access & Credentials**
   - AWS Console login (test account)
   - API credentials (for integrations)
   - Database admin access
   - SSH keys for servers

3. **Deployment Procedures**
   - How to deploy updates
   - Rollback procedures
   - Version control setup

4. **Monitoring & Alerts**
   - How to view logs
   - How to respond to alerts
   - Performance metrics to track

5. **Troubleshooting Guide**
   - Common issues
   - Resolution steps
   - Who to contact

6. **Cost Management**
   - Monthly budget
   - Cost breakdown
   - How to optimize costs
   - Reserved instance recommendations

7. **Security Procedures**
   - Password management
   - Access control
   - Backup verification
   - Disaster recovery testing

#### Create Admin Dashboard/Portal

```bash
# Example: CloudWatch Dashboard for client monitoring
1. Create read-only AWS IAM user for client
2. Set up CloudWatch dashboard with:
   - Current user count
   - API response times
   - Error rates
   - Database performance
   - Cost trends
3. Provide URL and credentials
4. Document how to interpret metrics
```

### Phase 2: Training & Knowledge Transfer (1-2 weeks)

#### Schedule Hands-On Training Sessions

```
Week 1:
- Day 1: Architecture overview & team Q&A
- Day 2: AWS Console walkthrough & dashboard reading
- Day 3: Common tasks (deploy, scale, monitor)
- Day 4: Troubleshooting procedures
- Day 5: Q&A and documentation review

Week 2:
- Day 1: Let client perform deployment
- Day 2: Client responds to simulated alert
- Day 3: Client performs backup restore test
- Day 4: Disaster recovery walkthrough
- Day 5: Final questions & escalation procedures
```

#### Create Video Tutorials

Record screen captures showing:
1. How to log in to AWS Console
2. How to view application logs
3. How to deploy new version
4. How to check performance metrics
5. How to respond to alerts
6. How to get support

### Phase 3: Transition & Support (1-4 weeks)

#### Transition Timeline

```
Week 1: Dual Support
- You monitoring actively
- Client reads logs and dashboards
- You make most changes

Week 2: Guided Support
- Client makes simple changes (with your review)
- You handle complex deployments
- Client escalates issues to you

Week 3: Client-Led Support
- Client leads most operations
- You review and approve changes
- Client handles routine monitoring

Week 4+: Limited Support
- Client operates independently
- You available for emergencies
- Monthly check-ins for optimization
```

#### Support Structure

**For First 30 Days** (Included):
- 5 hours/week of support
- Slack/email for questions
- Bi-weekly 30-min check-ins

**Ongoing Support** (Optional):
- $X/month for 4 hours/week
- 24-hour response time
- Quarterly optimization reviews
- Security updates included

### Phase 4: Hand Over Credentials & Access

#### Credential Package

Create secure document with:
```
1. AWS Console Login
   - Username: [client-user]
   - Temporary password: [secure]
   - MFA setup instructions

2. Database Access
   - Endpoint: [rds-endpoint]
   - Username: admin
   - Password: [secure]
   - Tools to connect: [instructions]

3. API Credentials
   - API Key: [secure]
   - Secret: [secure]
   - Rate limits: [details]

4. SSH Access (if applicable)
   - Private key: [secure file]
   - Server IPs: [list]
   - User accounts: [list]

5. Third-party Services
   - Service names
   - Usernames/API keys
   - Access URLs
```

**Important**: Use encrypted email or secure file sharing (not plain text)

#### Access Control Handover

```bash
# Create read-only user for client ops team
aws iam create-user --user-name client-ops
aws iam attach-user-policy \
  --user-name client-ops \
  --policy-arn arn:aws:iam::aws:policy/CloudWatchReadOnlyAccess

# Create limited deploy user (with your approval)
aws iam create-user --user-name client-deploy
# Attach custom policy limiting to specific resources

# Keep admin user (for emergency access)
# Client can request changes, you execute
```

#### Document Access Matrix

| Role | What They Can Do | What They Can't Do |
|------|-----------------|-------------------|
| **Client Ops** | Read logs, view metrics | Create/delete resources |
| **Client Deploy** | Deploy with approval | Modify infrastructure |
| **You (Support)** | Everything | Access client data |

### Phase 5: Establish Support & SLA

#### Create Service Level Agreement

```
Response Times:
- Critical issues: 1 hour
- High issues: 4 hours
- Normal: 24 hours
- Low: 48 hours

Availability SLA:
- Target: 99.5% uptime
- Planned maintenance: 2 hours/month
- Emergency maintenance: as needed

Escalation Path:
1. Support team (first response)
2. Senior engineer (technical issues)
3. Account manager (billing/accounts)
4. Director (legal/major incidents)
```

#### Create Incident Response Plan

```
When issue occurs:
1. Alert triggered → Notify on-call engineer
2. Investigation → Identify root cause
3. Communication → Update client every 15 min
4. Resolution → Fix and verify
5. Post-mortem → Document and improve

Example critical incident response:
- Detection: CloudWatch alarm
- Notification: Slack + SMS + Email
- Investigation: Check logs, metrics, recent changes
- Communication: Email to client with ETA
- Resolution: Scale up, fix bug, rollback deployment
- Follow-up: Root cause analysis meeting
```

---

## Monitoring & Maintenance

### Daily Monitoring Tasks

```bash
# Check CloudWatch dashboard
aws cloudwatch get-dashboard \
  --dashboard-name my-app-dashboard

# Review error logs
aws logs tail /aws/lambda/my-app-api --follow

# Check RDS performance
aws cloudwatch get-metric-statistics \
  --namespace AWS/RDS \
  --metric-name DatabaseConnections \
  --start-time 2024-01-01T00:00:00Z \
  --end-time 2024-01-01T23:59:59Z \
  --period 300 \
  --statistics Average
```

### Weekly Maintenance Tasks

```bash
# Review cost trends
1. AWS Console → Cost Explorer
2. Check current month spending
3. Compare to previous months
4. Identify cost spikes

# Review security
1. Check CloudTrail logs
2. Review IAM access
3. Verify MFA enabled
4. Check security group rules

# Performance review
1. Check API latency trends
2. Database query times
3. Lambda execution duration
4. Memory utilization
```

### Monthly Optimization Tasks

```bash
# Cost optimization
- Right-size instances
- Consider reserved instances
- Check for unused resources
- Review data transfer costs

# Performance optimization
- Review slow queries
- Check Lambda memory allocation
- Optimize database indexes
- Review cache hit rates

# Security audit
- Rotate credentials
- Review access logs
- Update dependencies
- Check for vulnerabilities
```

### Scaling Procedures

**Auto-Scaling is Automatic for**:
- Lambda functions
- API Gateway
- DynamoDB (if used)

**Manual Scaling for**:
- EC2 instances (adjust auto-scaling group)
- RDS database (upgrade instance class)
- ElastiCache (add nodes)

```bash
# When to scale
- CPU > 70% consistently → scale up
- Traffic patterns change → adjust thresholds
- New features require more compute → plan upgrade
- Database queries slow → add read replicas

# How to scale
1. Increase desired capacity
2. Monitor metrics
3. Verify performance improves
4. If too high, decrease and test again
```

---

## Cost Optimization

### Reduce Monthly Costs

| Strategy | Savings | Implementation |
|----------|---------|-----------------|
| Reserved Instances | 30-40% | Commit 1-3 years for EC2/RDS |
| Spot Instances | 70% | Use for non-critical workloads |
| S3 Lifecycle | 50% | Archive old data |
| Compute Savings Plans | 30% | Commit to compute capacity |
| Reserved Capacity | 50% | RDS reserved instances |
| CloudFront | 40% | Cache more at edge |
| Auto-shutdown | 20% | Shut down non-prod at night |

### Cost Monitoring

```bash
# Set up AWS Budgets alerts
1. AWS Console → Budgets
2. Create monthly budget
3. Set alert at 80% threshold
4. Receive email when approaching limit

# Use Cost Explorer
1. AWS Console → Cost Explorer
2. Filter by service
3. Identify largest expenses
4. Review trends over time

# Automated cost optimization
aws ce get-cost-and-usage \
  --time-period Start=2024-01-01,End=2024-01-31 \
  --granularity MONTHLY \
  --metrics BlendedCost \
  --group-by Type=DIMENSION,Key=SERVICE
```

### Small App Cost Targets

```
Development:     $10-50/month (use free tier, dev instances)
Staging:         $20-100/month (replicate production, smaller)
Production:      $50-200/month (redundancy, backups)

Annual budget: $600-3,600

With reserved instances:
Development:     $5-20/month
Staging:         $10-50/month
Production:      $30-120/month
Annual: $540-2,040
```

---

## Troubleshooting Guide

### Common Issues & Solutions

**Lambda Function Timeout**
```
Cause: Function takes too long
Solution:
1. Increase timeout: 3s → 30s → 300s
2. Optimize code (cache DB connections, use libraries)
3. Increase memory allocation
```

**Database Connection Errors**
```
Cause: Connection pool exhausted
Solution:
1. Check security group allows access
2. Increase max connections in RDS
3. Use connection pooling in app
4. Close connections properly
```

**High API Latency**
```
Cause: Slow response times
Solution:
1. Check Lambda duration (CloudWatch)
2. Check database query time (RDS Performance Insights)
3. Enable CloudFront caching
4. Optimize code hot paths
```

**Out of Disk Space**
```
Cause: S3 or EBS full
Solution:
1. Review S3 storage (S3 console)
2. Set up lifecycle to archive old files
3. Delete unnecessary logs (CloudWatch)
4. Expand EBS volume if needed
```

**Unexpected Cost Spike**
```
Cause: Usage increased or misconfigured service
Solution:
1. Check Cost Explorer for anomalies
2. Review CloudWatch metrics
3. Check for runaway Lambda executions
4. Review data transfer charges
```

---

## Deployment Checklist

Use this before going to production:

```
Pre-Launch (1 week before)
─────────────────────────────────
Infrastructure:
  ☐ All AWS resources created and tested
  ☐ Database backed up
  ☐ S3 versioning enabled
  ☐ Backups automated
  ☐ High availability configured

Security:
  ☐ SSL certificates valid
  ☐ Security groups configured correctly
  ☐ IAM policies follow least privilege
  ☐ No hardcoded secrets in code
  ☐ CloudTrail logging enabled

Code & Testing:
  ☐ Code review completed
  ☐ All tests passing (unit + integration)
  ☐ Load testing completed
  ☐ Security scanning done
  ☐ Dependencies up to date

Documentation:
  ☐ Operations manual complete
  ☐ Architecture diagram updated
  ☐ Runbook for common issues
  ☐ Contact/escalation info documented
  ☐ Disaster recovery plan tested

Monitoring:
  ☐ CloudWatch dashboard set up
  ☐ Alarms configured
  ☐ Log aggregation working
  ☐ Metrics collection validated
  ☐ Alert recipients configured

Launch Day
─────────────────────────────────
  ☐ Team on standby
  ☐ Backup completed
  ☐ Final security scan
  ☐ DNS cutover planned
  ☐ Rollback plan ready

  ☐ Deploy to production
  ☐ Monitor error rates (first 1 hour)
  ☐ Verify functionality
  ☐ Check performance metrics
  ☐ Confirm client access working

Post-Launch (First week)
─────────────────────────────────
  ☐ Daily monitoring and checks
  ☐ Respond to issues immediately
  ☐ Review logs for anomalies
  ☐ Monitor cost trends
  ☐ Collect client feedback
  ☐ Document issues found
  ☐ Make optimizations
  ☐ Celebrate launch! 🎉
```

---

## Quick Reference Commands

```bash
# View account info
aws sts get-caller-identity

# List all EC2 instances
aws ec2 describe-instances --query 'Reservations[].Instances[].[InstanceId,State.Name]'

# List all RDS databases
aws rds describe-db-instances --query 'DBInstances[].[DBInstanceIdentifier,DBInstanceStatus]'

# Check S3 bucket size
aws s3 ls s3://bucket-name --recursive --human-readable --summarize

# View Lambda function logs
aws logs tail /aws/lambda/function-name --follow

# Deploy Lambda function
aws lambda update-function-code \
  --function-name my-function \
  --zip-file fileb://deployment.zip

# Create RDS snapshot
aws rds create-db-snapshot \
  --db-instance-identifier my-db \
  --db-snapshot-identifier my-db-snapshot

# Check service health
aws health describe-events --filter eventTypeCategories=issue
```

---

## Next Steps

1. **Week 1**: Create AWS account, set up IAM, configure CLI
2. **Week 2-3**: Deploy application, configure domain, set up monitoring
3. **Week 4**: Prepare documentation, plan training
4. **Week 5+**: Train client, transition support, ongoing optimization

---

## Additional Resources

- **AWS Documentation**: https://docs.aws.amazon.com/
- **AWS Well-Architected Framework**: https://aws.amazon.com/architecture/well-architected/
- **Pricing Calculator**: https://calculator.aws/
- **AWS Support**: https://console.aws.amazon.com/support/
- **AWS Forums**: https://forums.aws.amazon.com/

---

**Last Updated**: November 30, 2025
**Status**: Production Ready
**Review Schedule**: Quarterly
