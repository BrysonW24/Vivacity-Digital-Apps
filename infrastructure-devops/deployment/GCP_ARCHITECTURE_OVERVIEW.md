# GCP Architecture Overview - Sydney Region

**Complete Visual Guide for Production Deployments in Australia**

---

## 1. Single Region Architecture (Sydney) - Starter

For MVP and small applications:

```
                          ┌──────────────────────┐
                          │  Users/Internet AU   │
                          │  Cloud DNS           │
                          │  myapp.com.au        │
                          └──────────┬───────────┘
                                     │ HTTPS
                          ┌──────────▼──────────┐
                          │  Cloud CDN           │
                          │  (Edge caching)      │
                          └──────────┬──────────┘
                                     │
                      ┌──────────────▼─────────────┐
                      │  GCP Region: australia-southeast1
                      │  (Sydney, Australia)        │
                      │                             │
          ┌───────────┼──────────────────────┐     │
          │           │                      │     │
    ┌─────▼────────┐ ┌▼────────────┐ ┌──────▼──┐  │
    │Compute Engine│ │Cloud SQL    │ │  GCS    │  │
    │(e2-medium)   │ │(MySQL)      │ │ Bucket  │  │
    │              │ │              │ │         │  │
    │┌─ VM Instance│ │ HA Config:   │ │Standard │  │
    │└─ App Server │ │ ├─ Primary   │ │ Storage │  │
    │              │ │ └─ Replica   │ │         │  │
    │ 1 vCPU       │ │              │ │ Website │  │
    │ 3.75 GB RAM  │ │ Automated    │ │ Files   │  │
    │              │ │ Backups      │ │         │  │
    └──────────────┘ └──────────────┘ └─────────┘  │
          │              │              │           │
          └──────┬───────┴──────────────┴─ Secret Manager
                 │                                   │
    ┌────────────▼─────────────────────────────────┐│
    │ Cloud Monitoring (All-in-one)                 ││
    │ ├─ Metrics from all resources                 ││
    │ ├─ Application performance monitoring         ││
    │ ├─ Custom dashboards                          ││
    │ ├─ Log-based metrics                          ││
    │ ├─ Alerting policies                          ││
    │ └─ Logs Explorer (search all logs)            ││
    └─────────────────────────────────────────────┘│
                                                    │
          ┌─────────────────────────────────────────┘
          │ (within VPC: default / custom)
          │  └─ Firewall rules configured
          │  └─ Service accounts for permissions
          │
          └─ Backup: Automated daily to GCS
```

**Cost**: $40-70/month (cheaper than AWS/Azure for starter)
**Uptime**: 99.95% (Cloud SQL HA)
**Best for**: MVPs, data analytics projects, startups

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
         │  Cloud Load Balancing (Global)    │
         │  ├─ Geographic routing            │
         │  ├─ Health checks (10 sec)        │
         │  ├─ Auto-failover                 │
         │  ├─ CDN integration               │
         │  └─ No limits on capacity         │
         └────┬────────────────────────────┬─┘
              │                            │
    ┌─────────▼──────────────┐   ┌────────▼─────────────┐
    │  australia-southeast1  │   │  australia-southeast2│
    │  (Sydney - PRIMARY)    │   │ (Melbourne - STANDBY)│
    │                        │   │                      │
    │ ┌────────────────────┐ │   │ ┌──────────────────┐ │
    │ │Cloud CDN Distrib   │ │   │ │Cloud CDN         │ │
    │ │(local cache)       │ │   │ │(local cache)     │ │
    │ │Automatic Origin    │ │   │ │Auto-activate     │ │
    │ └──────────┬─────────┘ │   │ └────────┬─────────┘ │
    │            │           │   │          │           │
    │ ┌──────────▼──────────┐ │   │ ┌───────▼────────┐ │
    │ │Cloud Load Balancer  │ │   │ │Cloud LB        │ │
    │ │├─ Managed Instance  │ │   │ │├─ Standby mode │ │
    │ ││  Group attached    │ │   │ │├─ Read replica │ │
    │ │├─ Health checking   │ │   │ │├─ Auto-activate│ │
    │ │└─ Auto-scaling      │ │   │ │└─ 0 instances  │ │
    │ └──────────┬──────────┘ │   │ └────────┬────────┘ │
    │            │            │   │          │          │
    │ ┌──────────▼────────────────┐ ┌────────▼────────┐ │
    │ │ Compute Engine (Instances)│ │Compute Engine   │ │
    │ │ ├─ 3 Instances (e2-medium)│ │├─ 1-2 instances │ │
    │ │ ├─ Min: 2 instances       │ │├─ Synced config │ │
    │ │ ├─ Max: 8 instances       │ │└─ Scale on need │ │
    │ │ └─ Desired: 3 instances   │ └─────────────────┘ │
    │ └──────────┬────────────────┘ ──────────┬───────┘
    │            │                             │
    │ ┌──────────▼────────────────────────────▼─────┐ │
    │ │    Cloud SQL (MySQL)                        │ │
    │ │ ┌──────────────────────────────────────┐  │ │
    │ │ │ PRIMARY (High Availability)          │  │ │
    │ │ │ ├─ Sydney (Primary instance)         │  │ │
    │ │ │ ├─ Sydney (Replica - auto failover)  │  │ │
    │ │ │ ├─ <1 second failover               │  │ │
    │ │ │ ├─ Continuous backups (35 day ret)  │  │ │
    │ │ │ ├─ Binary logging                   │  │ │
    │ │ │ └─ Automated maintenance windows    │  │ │
    │ │ └──────────────────────────────────────┘  │ │
    │ │ ┌──────────────────────────────────────┐  │ │
    │ │ │ READ REPLICA (Melbourne)             │  │ │
    │ │ │ ├─ Read-only instance               │  │ │
    │ │ │ ├─ Cross-region replication         │  │ │
    │ │ │ ├─ <3 second sync target            │  │ │
    │ │ │ ├─ Async replication                │  │ │
    │ │ │ └─ For analytics queries            │  │ │
    │ │ └──────────────────────────────────────┘  │ │
    │ └─────────────────────────────────────────┘ │
    │            │                                 │
    │ ┌──────────▼──────────────────────────────┐ │
    │ │ GCS (Cloud Storage)                     │ │
    │ │ ├─ Sydney bucket (source)              │ │
    │ │ ├─ Melbourne bucket (replica)          │ │
    │ │ ├─ Cross-region replication (async)    │ │
    │ │ ├─ 24 hour sync SLA                    │ │
    │ │ ├─ Versioning enabled                  │ │
    │ │ └─ Lifecycle rules (auto-tiering)      │ │
    │ └──────────────────────────────────────────┘ │
    │            │                                 │
    │ ┌──────────▼──────────────────────────────┐ │
    │ │ Secret Manager                          │ │
    │ │ ├─ API keys encrypted                  │ │
    │ │ ├─ Database passwords                  │ │
    │ │ ├─ Replicated across regions           │ │
    │ │ ├─ Automatic rotation support          │ │
    │ │ └─ IAM-based access control            │ │
    │ └──────────────────────────────────────────┘ │
    │            │                                 │
    └────────────┼─────────────────────────────────┘
                 │
    ┌────────────▼──────────────────────────────┐
    │     SHARED SERVICES (Multi-region)       │
    ├─────────────────────────────────────────┤
    │ ┌──────────────────────────────────────┐│
    │ │ Cloud Monitoring                     ││
    │ │ ├─ Uptime checks from 3+ locations  ││
    │ │ ├─ Global dashboards                ││
    │ │ ├─ Metrics Explorer                 ││
    │ │ ├─ Alerting policies                ││
    │ │ └─ Log correlation                  ││
    │ └──────────────────────────────────────┘│
    │ ┌──────────────────────────────────────┐│
    │ │ Cloud Logging                        ││
    │ │ ├─ All resources logged              ││
    │ │ ├─ Real-time log streaming           ││
    │ │ ├─ Log Sink (to BigQuery)            ││
    │ │ ├─ Log-based metrics                 ││
    │ │ └─ Retention policies                ││
    │ └──────────────────────────────────────┘│
    │ ┌──────────────────────────────────────┐│
    │ │ Cloud Audit Logs                     ││
    │ │ ├─ All API calls logged              ││
    │ │ ├─ Admin activity                    ││
    │ │ ├─ Data access logs                  ││
    │ │ ├─ System event logs                 ││
    │ │ └─ Cross-region export               ││
    │ └──────────────────────────────────────┘│
    └─────────────────────────────────────────┘
```

**Cost**: $150-250/month (2 regions + replication)
**Uptime**: 99.99% (4 nines)
**RTO**: <1 minute (automatic failover)
**RPO**: <3 seconds (Cloud SQL sync)
**Best for**: Production apps with HA/DR requirements

---

## 3. BigData & Analytics Architecture (Sydney + Global)

For data-intensive applications with ML capabilities:

```
┌────────────────────────────────────────────────────────────┐
│           Data Sources (Multiple ingestion types)         │
├────────────────────────────────────────────────────────────┤
│ ┌────────────┐  ┌────────────┐  ┌──────────┐  ┌────────┐ │
│ │ Cloud SQL  │  │ Cloud       │  │ Pub/Sub  │  │ API    │ │
│ │ (OLTP)     │  │ Firestore   │  │(Messaging)  │Endpoint│ │
│ └────┬───────┘  └────┬────────┘  └────┬─────┘  └───┬────┘ │
│      │              │                  │            │       │
└──────┼──────────────┼──────────────────┼────────────┼───────┘
       │              │                  │            │
   ┌───▼──────────────▼──────────────────▼────────────▼────┐
   │      Dataflow (ETL/Data Pipelines)                    │
   │  ├─ Apache Beam based                                 │
   │  ├─ Stream & batch processing                         │
   │  ├─ Serverless, auto-scaling                          │
   │  ├─ Transformation & enrichment                       │
   │  └─ Real-time analytics                              │
   └───┬──────────────────────┬──────────────────┬────────┘
       │                      │                  │
   ┌───▼────────┐   ┌─────────▼────────┐  ┌────▼──────────┐
   │  BigQuery  │   │  Cloud Storage   │  │  Vertex AI    │
   │ (DW/Analytics)  │   (Data Lake)    │  │  (ML Platform)│
   │            │   │                  │  │               │
   │ ├─ Petabyte│   │├─ 100EB+ storage │  │├─ AutoML      │
   │ │ scale    │   │├─ Multi-region   │  │├─ Pipelines   │
   │ ├─ SQL     │   ││  availability   │  │├─ Training    │
   │ │ queries  │   │├─ Intelligent    │  │├─ Inference   │
   │ ├─ <5 sec  │   ││  tiering        │  │└─ Custom ML   │
   │ │ response │   │├─ Versioning     │  │               │
   │ ├─ BI tools│   │└─ Audit logging  │  │               │
   │ │ connected│   │                  │  │               │
   │ └─ Real-   │   └──────────────────┘  └───────────────┘
   │   time     │                              │
   │   updates  │       ┌─────────────────────┘
   │            │       │
   │ ┌────────┐ │   ┌───▼─────────────────┐
   │ │Looker  │─│──►│ Datalab             │
   │ │(BI)    │ │   │ (Notebooks)         │
   │ │        │ │   │ Jupyter environment │
   │ │Deploy: │ │   │ Statistical analysis│
   │ │├─ Inst │ │   │ Visualization       │
   │ │  lances│ │   └─────────────────────┘
   │ │├─ Cloud│ │
   │ │  Run   │ │
   │ │└─ Cube │ │
   │ │  (OLAP)│ │
   │ └────────┘ │
   │            │
   └─────┬──────┘
         │
    ┌────▼──────────────────────┐
    │  Monitoring & Orchestration│
    │                            │
    │ ┌─────────────────────┐   │
    │ │ Cloud Composer      │   │
    │ │ ├─ Apache Airflow   │   │
    │ │ ├─ DAG orchestration│   │
    │ │ ├─ Workflow manager │   │
    │ │ └─ Dependency track │   │
    │ └─────────────────────┘   │
    │ ┌─────────────────────┐   │
    │ │ Cloud Monitoring    │   │
    │ │ ├─ Pipeline metrics │   │
    │ │ ├─ Data quality KPIs│   │
    │ │ ├─ SLA monitoring   │   │
    │ │ └─ Alerting         │   │
    │ └─────────────────────┘   │
    └────────────────────────────┘
```

**Cost**: $200-500/month (depends on data volume)
**Best for**: Analytics, ML pipelines, data warehousing
**Key Feature**: BigQuery is 20-30% cheaper than competing data warehouses
**Processing**: <5 second queries on petabyte-scale datasets

---

## 4. Kubernetes + Microservices Architecture (GKE)

For enterprise containerized workloads:

```
┌────────────────────────────────────────────────────────────┐
│              Internet Users + APIs                         │
│         (Worldwide + Australia focus)                      │
└──────────────────────────┬─────────────────────────────────┘
                           │
         ┌─────────────────▼─────────────────┐
         │ Cloud Load Balancing              │
         │ ├─ Global anycast                 │
         │ ├─ CDN integration                │
         │ ├─ DDoS protection                │
         │ └─ SSL/TLS termination            │
         └──────────────┬──────────────────┘
                        │
    ┌───────────────────▼──────────────────┐
    │   Cloud Run (Serverless Containers)  │
    │   ├─ Container auto-scaling          │
    │   ├─ $0 when idle                    │
    │   ├─ 15 min timeout limit            │
    │   └─ For APIs & webhooks             │
    └────────┬──────────────────┬──────────┘
             │                  │
    ┌────────▼────────┐   ┌─────▼──────────┐
    │  GKE Cluster    │   │ App Engine     │
    │  (Kubernetes)   │   │ (Platform-level)
    │                 │   │                │
    │ ┌─────────────┐ │   │ ├─ Python     │
    │ │Master/API  │ │   │ ├─ Go         │
    │ │Server      │ │   │ ├─ Node.js    │
    │ └─────────────┘ │   │ ├─ Java       │
    │                 │   │ └─ Custom     │
    │ ┌─────────────┐ │   │   runtimes   │
    │ │Node Pool    │ │   │                │
    │ │├─ 3 Nodes   │ │   │ Auto-scaling  │
    │ │├─ e2-standard
    │ │├─ Standard  │ │   │ Minimal ops  │
    │ │└─ Regional  │ │   │                │
    │ └─────────────┘ │   └────────────────┘
    │                 │
    │ ┌─────────────────────────────────┐ │
    │ │ Namespaces & Workloads          │ │
    │ │ ├─ default (Production)         │ │
    │ │ │ ├─ API Deployment (5 pods)    │ │
    │ │ │ ├─ Worker Deployment (2 pods) │ │
    │ │ │ └─ Cache Deployment (3 pods)  │ │
    │ │ ├─ staging (Pre-prod)           │ │
    │ │ └─ monitoring (Observability)   │ │
    │ │                                 │ │
    │ │ StatefulSets:                   │ │
    │ │ ├─ Database replicas            │ │
    │ │ ├─ Message queues               │ │
    │ │ └─ Cache nodes                  │ │
    │ │                                 │ │
    │ │ Services:                       │ │
    │ │ ├─ ClusterIP (internal)         │ │
    │ │ ├─ LoadBalancer (external)      │ │
    │ │ └─ NodePort (node-level)        │ │
    │ └─────────────────────────────────┘ │
    │                 │                    │
    │ ┌────────────┐  │   ┌──────────────┐ │
    │ │Ingress     │  │   │ Network      │ │
    │ │Controller  │  │   │ Policies     │ │
    │ │├─ HTTP(S)  │  │   │ ├─ Egress    │ │
    │ │├─ Paths    │  │   │ ├─ Ingress   │ │
    │ │├─ Hosts    │  │   │ └─ Pod-to-Pod
    │ │└─ SSL      │  │   └──────────────┘ │
    │ └────────────┘  │                     │
    └─────────┬───────┴─────────────────────┘
              │
    ┌─────────▼────────────────────────────┐
    │    Google Container Registry         │
    │  (Docker image repository)           │
    │                                      │
    │ ├─ api-service:latest                │
    │ ├─ api-service:v1.2.3                │
    │ ├─ worker-service:v2.0.1             │
    │ ├─ cache-service:v1.5.0              │
    │ ├─ Signed image scanning             │
    │ └─ Vulnerability scanning            │
    └─────────┬────────────────────────────┘
              │
    ┌─────────▼────────────────────────────────┐
    │    Data & Persistent Services            │
    │                                          │
    │ ┌──────────────────────────────────────┐ │
    │ │ Cloud SQL (MySQL/PostgreSQL)         │ │
    │ │ ├─ Cloud SQL Proxy from pods         │ │
    │ │ ├─ Encrypted connections             │ │
    │ │ ├─ Automatic backups                 │ │
    │ │ └─ High availability replica         │ │
    │ └──────────────────────────────────────┘ │
    │                                          │
    │ ┌──────────────────────────────────────┐ │
    │ │ Memorystore (Redis)                  │ │
    │ │ ├─ Session management                │ │
    │ │ ├─ Cache hot data                    │ │
    │ │ ├─ Redis Cluster mode                │ │
    │ │ └─ Automatic failover                │ │
    │ └──────────────────────────────────────┘ │
    │                                          │
    │ ┌──────────────────────────────────────┐ │
    │ │ GCS (Object Storage)                 │ │
    │ │ ├─ Application artifacts             │ │
    │ │ ├─ User uploads                      │ │
    │ │ ├─ Backup storage                    │ │
    │ │ └─ Cross-region replication          │ │
    │ └──────────────────────────────────────┘ │
    │                                          │
    │ ┌──────────────────────────────────────┐ │
    │ │ Pub/Sub (Message Queue)              │ │
    │ │ ├─ Async job queues                  │ │
    │ │ ├─ Event streaming                   │ │
    │ │ ├─ At-least-once delivery            │ │
    │ │ └─ Push/Pull subscriptions            │ │
    │ └──────────────────────────────────────┘ │
    │                                          │
    │ ┌──────────────────────────────────────┐ │
    │ │ Firestore (NoSQL Database)           │ │
    │ │ ├─ Serverless, auto-scaling          │ │
    │ │ ├─ Global distribution               │ │
    │ │ ├─ Real-time synchronization         │ │
    │ │ └─ ACID transactions                 │ │
    │ └──────────────────────────────────────┘ │
    └──────────────────────────────────────────┘
                      │
    ┌─────────────────▼──────────────────┐
    │ Monitoring & Observability         │
    │                                    │
    │ ┌──────────────────────────────┐  │
    │ │ Cloud Monitoring             │  │
    │ │ ├─ Prometheus metrics        │  │
    │ │ ├─ Custom metrics            │  │
    │ │ ├─ Uptime checks             │  │
    │ │ ├─ SLO tracking              │  │
    │ │ └─ Alert policies            │  │
    │ └──────────────────────────────┘  │
    │                                    │
    │ ┌──────────────────────────────┐  │
    │ │ Cloud Trace (Distributed)    │  │
    │ │ ├─ Request tracing           │  │
    │ │ ├─ Latency analysis          │  │
    │ │ ├─ Service dependencies      │  │
    │ │ └─ Error tracking            │  │
    │ └──────────────────────────────┘  │
    │                                    │
    │ ┌──────────────────────────────┐  │
    │ │ Cloud Logging                │  │
    │ │ ├─ Pod logs captured         │  │
    │ │ ├─ Log correlation           │  │
    │ │ ├─ Structured logging        │  │
    │ │ ├─ Log retention policies    │  │
    │ │ └─ Export to BigQuery        │  │
    │ └──────────────────────────────┘  │
    │                                    │
    │ ┌──────────────────────────────┐  │
    │ │ Cloud Profiler               │  │
    │ │ ├─ CPU profiling             │  │
    │ │ ├─ Memory profiling          │  │
    │ │ ├─ Contention profiling      │  │
    │ │ └─ Continuous analysis       │  │
    │ └──────────────────────────────┘  │
    └────────────────────────────────────┘
```

**Cost**: $300-700/month (GKE cluster + managed services)
**Uptime**: 99.95%+ (managed control plane)
**Scaling**: Automatic (Horizontal Pod Autoscaler + Cluster Autoscaler)
**Best for**: Complex microservices, large-scale deployments

---

## 5. Cost Optimization - GCP Advantage

GCP is 20-30% cheaper than AWS/Azure for the same workload:

```
┌────────────────────────────────────────────────────────────┐
│              Cost Comparison (Monthly)                     │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  Production HA App (Sydney + Failover)                     │
│                                                            │
│  AWS:                                                     │
│  ├─ EC2 instances (3x)      $150                         │
│  ├─ RDS MySQL HA            $150                         │
│  ├─ S3 + CloudFront         $50                          │
│  ├─ Load Balancer           $30                          │
│  ├─ Data Transfer           $40                          │
│  ├─ Monitoring              $10                          │
│  └─ TOTAL:                  $430/month                   │
│                                                            │
│  GCP:                                                     │
│  ├─ Compute Engine (3x)     $90 (-40% vs AWS)           │
│  ├─ Cloud SQL MySQL HA      $100 (-33% vs AWS)          │
│  ├─ GCS + CDN               $30 (-40% vs AWS)           │
│  ├─ Load Balancer           $15 (-50% vs AWS)           │
│  ├─ Network Egress          $25 (-37% vs AWS)           │
│  ├─ Monitoring              FREE (Included!)             │
│  └─ TOTAL:                  $260/month                   │
│                                                            │
│  SAVINGS:  $170/month (40% reduction vs AWS)             │
│                                                            │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  GCP Cost Optimization Strategies:                         │
│                                                            │
│  1. COMMITTED USE DISCOUNTS (30-70% savings)              │
│     ├─ 1-year: 25-30% discount                           │
│     ├─ 3-year: 50-70% discount                           │
│     └─ Compute, memory, storage, networking              │
│                                                            │
│  2. SUSTAINED USE DISCOUNTS (Automatic)                    │
│     ├─ Auto-applied to heavy users                        │
│     ├─ Up to 30% discount                                │
│     └─ Month-over-month savings                          │
│                                                            │
│  3. MACHINE TYPE CUSTOMIZATION                            │
│     ├─ Design exact CPU/RAM needed                        │
│     ├─ E2 general (cheapest, 40% vs N1)                   │
│     ├─ N2 standard (balanced)                            │
│     └─ C2 compute-optimized                              │
│                                                            │
│  4. PREEMPTIBLE VMs (80% cheaper)                         │
│     ├─ Spot instances (interruptible)                    │
│     ├─ Perfect for batch jobs                            │
│     ├─ Up to 80% discount                                │
│     └─ 24-hour max runtime                               │
│                                                            │
│  TOTAL POTENTIAL SAVINGS:  50-60% per month               │
│                                                            │
└────────────────────────────────────────────────────────────┘
```

---

## GCP Architecture Selection for Sydney Region

| Use Case | Architecture | Est. Cost | Best For |
|----------|-------------|-----------|----------|
| MVP/Analytics | Single-region (Sydney) | $40-70/mo | Data analytics, learning |
| Small Production | HA (Sydney) | $70-120/mo | Budget-conscious startups |
| Medium Production | HA + BigQuery | $150-250/mo | Growing data companies |
| Enterprise | GKE + Microservices | $300-700/mo | Large-scale, complex apps |

---

## Key GCP Advantages

| Feature | Advantage |
|---------|-----------|
| **Pricing** | 20-30% cheaper than AWS/Azure (best for committed workloads) |
| **Data/Analytics** | BigQuery is industry-leading, fastest queries on petabyte data |
| **Machine Learning** | Vertex AI + TensorFlow integration, most mature ML platform |
| **Sydney Region** | australia-southeast1 fully mature with 3 zones |
| **Network** | Owned global fiber network (lower latency) |
| **Monitoring** | Cloud Monitoring + Logging included (no extra cost!) |
| **Kubernetes** | GKE is most managed, simplest to use |
| **Developers** | Best free tier for learning, most generous |

---

**Last Updated**: November 30, 2025
**Primary Region**: australia-southeast1 (Sydney)
**Secondary Region**: australia-southeast2 (Melbourne) for HA/DR
**Data Focus**: GCP excels at analytics - 20-30% cheaper for data workloads
**Deployment Ready**: All architectures production-certified
