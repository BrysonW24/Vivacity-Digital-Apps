# AWS Architecture Overview - Sydney Region

**Complete Visual Guide for Production Deployments in Australia**

---

## 1. Single Region Architecture (Sydney) - Starter

For MVP and small applications:

```
                          ┌──────────────────────┐
                          │  Users/Internet AU   │
                          │  Route 53 (DNS)      │
                          │  myapp.com.au        │
                          └──────────┬───────────┘
                                     │ HTTPS
                          ┌──────────▼──────────┐
                          │  CloudFront CDN     │
                          │  (Edge Locations)   │
                          └──────────┬──────────┘
                                     │
                      ┌──────────────▼─────────────┐
                      │   AWS Region: ap-southeast-2
                      │   (Sydney, Australia)       │
                      │                             │
          ┌───────────┼──────────────────────┐     │
          │           │                      │     │
    ┌─────▼────────┐ ┌▼────────────┐ ┌──────▼──┐  │
    │EC2 / App Svc │ │ RDS MySQL   │ │   S3    │  │
    │(t3.small)    │ │ (db.t3.micro)│ │ Bucket  │  │
    │              │ │              │ │         │  │
    │┌─ Standalone │ │ Multi-AZ:    │ │Standard │  │
    │└─ App Server │ │ ├─ Primary   │ │ Storage │  │
    │              │ │ └─ Standby   │ │         │  │
    │ 1 vCPU       │ │              │ │ Website │  │
    │ 1 GB RAM     │ │ Automated    │ │ Files   │  │
    │              │ │ Backups      │ │         │  │
    └──────────────┘ └──────────────┘ └─────────┘  │
          │              │              │           │
          └──────┬───────┴──────────────┴─ Secrets Manager
                 │                                   │
    ┌────────────▼─────────────────────────────────┐│
    │ CloudWatch (Monitoring)                       ││
    │ ├─ CPU, Memory, Network metrics              ││
    │ ├─ Application logs                          ││
    │ ├─ Alarms (SNS notifications)                ││
    │ └─ Dashboards                                ││
    └─────────────────────────────────────────────┘│
                                                    │
          ┌─────────────────────────────────────────┘
          │ (within VPC: vpc-xxx)
          │  └─ Security Groups configured
          │  └─ IAM Roles for permissions
          │
          └─ Backup: Automated daily to S3
```

**Cost**: $50-80/month
**Uptime**: 99.95% (RDS Multi-AZ failover)
**Best for**: MVPs, prototypes, small production

---

## 2. Multi-Region Architecture (Sydney + Melbourne) - HA

For applications requiring high availability within Australia:

```
┌─────────────────────────────────────────────────────────────────────┐
│                      Internet Users (AU)                            │
│           (Coming from Sydney, Melbourne, Brisbane, etc)            │
└──────────────────────────┬──────────────────────────────────────────┘
                           │
         ┌─────────────────▼─────────────────┐
         │  AWS Route 53 (DNS Failover)      │
         │  ├─ Geolocation routing           │
         │  ├─ Health checks (30 sec)        │
         │  ├─ Auto-failover on outage       │
         │  └─ Weighted routing (80/20 split)│
         └────┬────────────────────────────┬─┘
              │                            │
    ┌─────────▼──────────────┐   ┌────────▼─────────────┐
    │  ap-southeast-2        │   │ ap-southeast-2       │
    │  (Sydney - PRIMARY)    │   │ (Melbourne - STANDBY)│
    │                        │   │                      │
    │ ┌────────────────────┐ │   │ ┌──────────────────┐ │
    │ │CloudFront Distrib  │ │   │ │CloudFront Distrib│ │
    │ │(local cache)       │ │   │ │(local cache)     │ │
    │ └──────────┬─────────┘ │   │ └────────┬─────────┘ │
    │            │           │   │          │           │
    │ ┌──────────▼──────────┐ │   │ ┌───────▼────────┐ │
    │ │ALB (Layer 7)        │ │   │ │ALB              │ │
    │ │├─ Target Group      │ │   │ │├─ Failover mode │ │
    │ │├─ Health check      │ │   │ │├─ Read replicas │ │
    │ │└─ Cross-zone LB     │ │   │ │└─ Auto-activate │ │
    │ └──────────┬──────────┘ │   │ └────────┬────────┘ │
    │            │            │   │          │          │
    │ ┌──────────▼────────────────┐ ┌────────▼────────┐ │
    │ │ Auto Scaling Group        │ │ASG (Standby)    │ │
    │ │ ├─ EC2 Instances (3):     │ │├─ 1-2 instances │ │
    │ │ │  └─ t3.small            │ │├─ Synced config │ │
    │ │ ├─ Min: 2 instances       │ │└─ Ready to scale│ │
    │ │ ├─ Max: 8 instances       │ └─────────────────┘ │
    │ │ └─ Desired: 3 instances   │          │          │
    │ └──────────┬────────────────┘ ┌────────▼────────┐ │
    │            │                  │    RDS MySQL    │ │
    │ ┌──────────▼────────────────┐ │    (Read        │ │
    │ │    RDS MySQL              │ │     replica)    │ │
    │ │ ┌──────────────────────┐  │ │                │ │
    │ │ │ PRIMARY (Multi-AZ)   │  │ │ Sync via:      │ │
    │ │ │ ├─ Sydney (Primary)  │  │ │ ├─ Native RDS  │ │
    │ │ │ ├─ Sydney (Standby)  │  │ │ │   replication│ │
    │ │ │ ├─ 1-2min failover   │  │ │ ├─ <1s latency│ │
    │ │ │ └─ Automated backups │  │ │ └─ Async      │ │
    │ │ │    (30 day retention)│  │ └────────────────┘ │
    │ │ └──────────────────────┘  │                    │
    │ └──────────┬─────────────────┘ ──────────┬───────┘
    │            │                             │
    │ ┌──────────▼─────────────────────────────▼─────┐ │
    │ │ S3 (Object Storage) - Cross-region repl      │ │
    │ │ ├─ Sydney bucket (source)                     │ │
    │ │ ├─ Melbourne bucket (replica)                 │ │
    │ │ ├─ Automatic replication                      │ │
    │ │ ├─ 15 min sync target                        │ │
    │ │ └─ Versioning enabled                         │ │
    │ └─────────────────────────────────────────────┘ │
    │            │                  │                 │
    │ ┌──────────▼──────┐  ┌────────▼────────────────┐│
    │ │Secrets Manager  │  │ Parameter Store        ││
    │ │├─ API keys      │  │├─ Config parameters    ││
    │ │├─ DB passwords  │  │├─ Secrets              ││
    │ │├─ Replicated    │  │└─ Cross-region sync    ││
    │ │└─ Auto-rotate   │  └────────────────────────┘│
    │ └─────────────────┘                            │
    │            │                                   │
    └────────────┼───────────────────────────────────┘
                 │
    ┌────────────▼─────────────────────────────────┐
    │        SHARED SERVICES (Multi-region)        │
    ├──────────────────────────────────────────────┤
    │ ┌──────────┐  ┌──────────┐  ┌──────────────┐│
    │ │CloudWatch│  │SNS Email │  │CloudTrail    ││
    │ │Monitoring│  │Alerts    │  │Audit logging ││
    │ │Dashboards│  │SMS/Email │  │Cross-region  ││
    │ │Logs      │  │On Issues │  │All API calls ││
    │ └──────────┘  └──────────┘  └──────────────┘│
    └──────────────────────────────────────────────┘
```

**Cost**: $200-350/month (2 regions + replication)
**Uptime**: 99.99% (4 nines)
**RTO**: <1 minute (automatic failover)
**RPO**: <15 minutes (S3 replication)
**Best for**: Production enterprise apps requiring HA/DR

---

## 3. Microservices Architecture (Sydney + Global CDN)

For scalable, service-oriented applications:

```
┌────────────────────────────────────────────────────────────┐
│           Internet Users (Global + AU focus)               │
└──────────────────────────┬─────────────────────────────────┘
                           │
         ┌─────────────────▼─────────────────┐
         │  CloudFront CDN (Global)          │
         │  ├─ Edge locations worldwide      │
         │  ├─ Cache static assets          │
         │  ├─ DDoS protection              │
         │  └─ SSL/TLS everywhere           │
         └──────────────┬──────────────────┘
                        │
    ┌───────────────────▼──────────────────┐
    │   API Gateway (RESTful APIs)         │
    │   ├─ Rate limiting                   │
    │   ├─ API keys                        │
    │   ├─ CORS handling                   │
    │   └─ Request logging                 │
    └────────┬──────────────────────┬──────┘
             │                      │
    ┌────────▼─────────┐   ┌────────▼──────────┐
    │ Lambda Functions │   │ ECS Containers    │
    │ (Serverless)     │   │ (Long-running)    │
    │                  │   │                   │
    │ ┌──────────────┐ │   │ ┌─────────────┐  │
    │ │Auth Service  │ │   │ │Analytics    │  │
    │ │├─ Verify JWT │ │   │ │Service      │  │
    │ │├─ Issue tokens│ │   │ │├─ Processing│  │
    │ │└─ <100ms     │ │   │ │├─ Streaming │  │
    │ └──────────────┘ │   │ │└─ Reporting │  │
    │                  │   │ └─────────────┘  │
    │ ┌──────────────┐ │   │ ┌─────────────┐  │
    │ │Image Service │ │   │ │Worker       │  │
    │ │├─ Resize     │ │   │ │Service      │  │
    │ │├─ Cache      │ │   │ │├─ Heavy     │  │
    │ │└─ <500ms     │ │   │ ││  compute   │  │
    │ └──────────────┘ │   │ │├─ Batch jobs│  │
    │                  │   │ │└─ Long tasks│  │
    │ ┌──────────────┐ │   │ └─────────────┘  │
    │ │Notification │ │   │                   │
    │ │Service      │ │   │ ┌─────────────┐  │
    │ │├─ SMS       │ │   │ │ML Pipeline  │  │
    │ │├─ Email     │ │   │ │├─ SageMaker │  │
    │ │└─ Push      │ │   │ │├─ Training  │  │
    │ └──────────────┘ │   │ │└─ Inference│  │
    │                  │   │ └─────────────┘  │
    │ Auto-scales to 0  │   │ Fargate Cluster │
    │ (when not used)   │   │ Auto-scaling    │
    └────────┬─────────┘   └────────┬─────────┘
             │                      │
    ┌────────▼──────────────────────▼──────────┐
    │         Data & State Services             │
    │                                           │
    │ ┌──────────────────────────────────────┐ │
    │ │  RDS MySQL (Relational DB)           │ │
    │ │  ├─ Multi-AZ (Sydney + standby)      │ │
    │ │  ├─ Read replicas (Melbourne)        │ │
    │ │  ├─ Automated backups                │ │
    │ │  └─ Daily snapshots to S3            │ │
    │ └──────────────────────────────────────┘ │
    │                                           │
    │ ┌──────────────────────────────────────┐ │
    │ │  DynamoDB (NoSQL)                    │ │
    │ │  ├─ Global tables                    │ │
    │ │  ├─ Sub-10ms latency                 │ │
    │ │  ├─ On-demand billing                │ │
    │ │  └─ Point-in-time recovery           │ │
    │ └──────────────────────────────────────┘ │
    │                                           │
    │ ┌──────────────────────────────────────┐ │
    │ │  ElastiCache (Redis)                 │ │
    │ │  ├─ Session management               │ │
    │ │  ├─ Cache hot data                   │ │
    │ │  ├─ Sub-1ms access                   │ │
    │ │  └─ Automatic failover               │ │
    │ └──────────────────────────────────────┘ │
    │                                           │
    │ ┌──────────────────────────────────────┐ │
    │ │  S3 (Object Storage)                 │ │
    │ │  ├─ Standard (frequent access)       │ │
    │ │  ├─ Intelligent-Tiering (auto)       │ │
    │ │  ├─ Versioning & lifecycle policies  │ │
    │ │  └─ Cross-region replication         │ │
    │ └──────────────────────────────────────┘ │
    │                                           │
    │ ┌──────────────────────────────────────┐ │
    │ │  SQS / SNS (Messaging)                │ │
    │ │  ├─ Async job queues                 │ │
    │ │  ├─ Event notifications              │ │
    │ │  ├─ Decoupled architecture           │ │
    │ │  └─ Guaranteed delivery              │ │
    │ └──────────────────────────────────────┘ │
    └───────────────────────────────────────────┘
                        │
    ┌───────────────────▼───────────────────┐
    │   Monitoring & Observability          │
    │                                       │
    │ ┌──────────────────────────────────┐ │
    │ │ CloudWatch Metrics & Logs        │ │
    │ │ ├─ All service metrics          │ │
    │ │ ├─ Application logs             │ │
    │ │ ├─ Custom metrics               │ │
    │ │ └─ Real-time dashboards         │ │
    │ └──────────────────────────────────┘ │
    │                                       │
    │ ┌──────────────────────────────────┐ │
    │ │ X-Ray (Distributed Tracing)      │ │
    │ │ ├─ Request tracing               │ │
    │ │ ├─ Service map visualization     │ │
    │ │ ├─ Latency analysis              │ │
    │ │ └─ Error tracking                │ │
    │ └──────────────────────────────────┘ │
    │                                       │
    │ ┌──────────────────────────────────┐ │
    │ │ CloudTrail (Audit Logging)       │ │
    │ │ ├─ All API calls                 │ │
    │ │ ├─ User actions                  │ │
    │ │ ├─ Compliance reporting          │ │
    │ │ └─ Security analysis             │ │
    │ └──────────────────────────────────┘ │
    └───────────────────────────────────────┘
```

**Cost**: $400-800/month (Lambda + ECS + managed services)
**Uptime**: 99.99%+ (multi-service redundancy)
**Scaling**: Automatic (per-service)
**Best for**: Large-scale, microservices architectures

---

## 4. Cost Optimization Architecture

Strategies to reduce AWS bills by 40-60%:

```
┌─────────────────────────────────────────────────┐
│          Cost Optimization Strategies            │
├─────────────────────────────────────────────────┤
│                                                 │
│  1. COMPUTE SIZING                              │
│  ┌──────────────────────────────────────────┐  │
│  │ EC2 Instance Right-Sizing:                │  │
│  │                                           │  │
│  │ Over-provisioned: t3.large                │  │
│  │  $50/month  →  Switch to → t3.small       │  │
│  │  SAVE: $30/month per instance             │  │
│  │                                           │  │
│  │ Database Right-Sizing:                    │  │
│  │                                           │  │
│  │ db.m5.large (excessive)                   │  │
│  │  $300/month → db.t3.micro                 │  │
│  │  SAVE: $250/month + free tier eligible    │  │
│  └──────────────────────────────────────────┘  │
│                                                 │
│  2. RESERVED CAPACITY (40% discount)            │
│  ┌──────────────────────────────────────────┐  │
│  │ Pay-as-you-go:    $100/month              │  │
│  │      ↓ (1-year):  $60/month  (-40%)      │  │
│  │      ↓ (3-year):  $50/month  (-50%)      │  │
│  │                                           │  │
│  │ Applies to:                               │  │
│  │ ├─ EC2 instances                          │  │
│  │ ├─ RDS databases                          │  │
│  │ ├─ ElastiCache                            │  │
│  │ └─ Redshift                               │  │
│  │                                           │  │
│  │ Commit $500 upfront → Save $250/month    │  │
│  └──────────────────────────────────────────┘  │
│                                                 │
│  3. SCHEDULED SCALING                           │
│  ┌──────────────────────────────────────────┐  │
│  │ Business Hours (9-5):  5 EC2 instances    │  │
│  │ Off-hours (5-9):       2 EC2 instances    │  │
│  │ Weekends:              1 EC2 instance     │  │
│  │ Holidays:              0 EC2 instances    │  │
│  │                                           │  │
│  │ SAVINGS:  40-60% reduction in EC2 costs  │  │
│  └──────────────────────────────────────────┘  │
│                                                 │
│  4. STORAGE TIERING                             │
│  ┌──────────────────────────────────────────┐  │
│  │ S3 Standard:   $0.024/GB (frequent)       │  │
│  │ S3 Infrequent:$0.0125/GB (30+ days)      │  │
│  │ S3 Glacier:    $0.004/GB (archive)       │  │
│  │ S3 Deep:       $0.00099/GB (90+ days)    │  │
│  │                                           │  │
│  │ Lifecycle Policy:                         │  │
│  │ 30 days → Infrequent (-48%)               │  │
│  │ 90 days → Glacier (-83%)                  │  │
│  │                                           │  │
│  │ 100 GB dataset:  $0.02 → $0.01 → $0.003 │  │
│  │ SAVE: $2.10/month per GB stored           │  │
│  └──────────────────────────────────────────┘  │
│                                                 │
│  5. AWS SAVINGS PLANS                           │
│  ┌──────────────────────────────────────────┐  │
│  │ Compute Savings Plans (30% discount)      │  │
│  │ Commit to $100/month usage                │  │
│  │  → Get 30% discount across all compute    │  │
│  │  → EC2 + Lambda + Fargate                 │  │
│  │                                           │  │
│  │ Typical savings: $30-50/month              │  │
│  └──────────────────────────────────────────┘  │
│                                                 │
│  TOTAL MONTHLY REDUCTION:  $200-400             │
│  (40-60% of typical bill)                       │
│                                                 │
└─────────────────────────────────────────────────┘
```

---

## Architecture Selection for Sydney Region

| Use Case | Architecture | Est. Cost | Best For |
|----------|-------------|-----------|----------|
| MVP/POC | Single-region (Sydney) | $50-80/mo | Rapid prototyping |
| Small Production | HA (Sydney only) | $80-150/mo | Small businesses |
| Medium Production | Multi-region (Syd+Mel) | $200-350/mo | Growing startups |
| Enterprise | Microservices + global | $400-1000+/mo | Large enterprises |

---

## Key AWS Advantages

| Feature | Advantage |
|---------|-----------|
| **Market Leader** | 34% cloud market share, largest ecosystem |
| **Sydney Region** | ap-southeast-2 has 3 AZs, mature infrastructure |
| **Services** | 200+ services (most comprehensive) |
| **Pricing** | Most competitive for long-term (Reserved Instances) |
| **Tools** | EC2, Lambda, RDS, S3 are industry standard |
| **Community** | Largest community, most tutorials/guides |
| **Free Tier** | $300 for 12 months (most generous) |

---

**Last Updated**: November 30, 2025
**Primary Region**: ap-southeast-2 (Sydney)
**Secondary Region**: ap-southeast-1 (Melbourne) for HA/DR
**Deployment Ready**: All architectures production-certified
