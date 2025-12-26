# Cloud Providers

```
    ╔═══════════════════════════════════════════════════════╗
    ║                                                       ║
    ║    ██████╗██╗      ██████╗ ██╗   ██╗██████╗          ║
    ║   ██╔════╝██║     ██╔═══██╗██║   ██║██╔══██╗         ║
    ║   ██║     ██║     ██║   ██║██║   ██║██║  ██║         ║
    ║   ██║     ██║     ██║   ██║██║   ██║██║  ██║         ║
    ║   ╚██████╗███████╗╚██████╔╝╚██████╔╝██████╔╝         ║
    ║    ╚═════╝╚══════╝ ╚═════╝  ╚═════╝ ╚═════╝          ║
    ║                                                       ║
    ║      P R O V I D E R   C O N F I G U R A T I O N S    ║
    ║                                                       ║
    ╚═══════════════════════════════════════════════════════╝
```

## Overview

This directory contains configurations, templates, and integration guides for various cloud service providers used by Vivacity Digital applications.

## Supported Providers

```
┌──────────────────────────────────────────────────────────────┐
│                                                              │
│  📁 providers/                                               │
│  │                                                           │
│  ├── ☁️  aws/                  Amazon Web Services          │
│  │   ├── compute/                EC2, Lambda, ECS           │
│  │   └── storage/                S3, RDS, DynamoDB          │
│  │                                                           │
│  ├── 🚂 railway/                Railway Platform            │
│  │   └── deployment-configs/     Railway deployments        │
│  │                                                           │
│  ├── ⚡ supabase/               Supabase (Firebase Alt)     │
│  │   └── database-configs/       PostgreSQL & Auth          │
│  │                                                           │
│  └── ▲  vercel/                 Vercel Platform            │
│      └── web-deployments/        Frontend hosting           │
│                                                              │
└──────────────────────────────────────────────────────────────┘
```

## Provider Comparison

```
╔════════════════════════════════════════════════════════════════╗
║                    PROVIDER USE CASES                          ║
╠════════════════════════════════════════════════════════════════╣
║                                                                ║
║  AWS (Amazon Web Services)                                     ║
║  ├─ Best for: Enterprise clients, complex infrastructure      ║
║  ├─ Use when: Scalability, full control, AWS ecosystem needed ║
║  └─ Services: EC2, Lambda, S3, RDS, DynamoDB, CloudFront      ║
║                                                                ║
║  Railway                                                       ║
║  ├─ Best for: Quick deployments, small to medium apps         ║
║  ├─ Use when: Simple deployments, PostgreSQL needed           ║
║  └─ Services: Web hosting, databases, cron jobs               ║
║                                                                ║
║  Supabase                                                      ║
║  ├─ Best for: Real-time apps, rapid development               ║
║  ├─ Use when: Firebase alternative, PostgreSQL + Auth needed  ║
║  └─ Services: PostgreSQL, Auth, Storage, Real-time, Edge      ║
║                                                                ║
║  Vercel                                                        ║
║  ├─ Best for: Frontend applications, JAMstack sites           ║
║  ├─ Use when: Next.js, static sites, serverless functions     ║
║  └─ Services: Edge hosting, serverless functions, analytics   ║
║                                                                ║
╚════════════════════════════════════════════════════════════════╝
```

## Architecture Patterns

### Typical Deployment Architecture

```
    ┌─────────────────────────────────────────────────┐
    │                                                 │
    │              END USERS                          │
    │                                                 │
    └─────────────┬───────────────────────────────────┘
                  │
                  ▼
    ┌─────────────────────────────────────────────────┐
    │         VERCEL (Frontend)                       │
    │  • Next.js / React Web App                      │
    │  • Static Assets                                │
    │  • Edge Functions                               │
    └─────────────┬───────────────────────────────────┘
                  │
                  ▼
    ┌─────────────────────────────────────────────────┐
    │      RAILWAY / AWS (Backend)                    │
    │  • REST API / GraphQL                           │
    │  • Business Logic                               │
    │  • Background Jobs                              │
    └─────────────┬───────────────────────────────────┘
                  │
                  ▼
    ┌─────────────────────────────────────────────────┐
    │      SUPABASE / AWS RDS (Database)              │
    │  • PostgreSQL Database                          │
    │  • Authentication                               │
    │  • Real-time Subscriptions                      │
    └─────────────────────────────────────────────────┘
```

### Mobile App Architecture

```
    ┌─────────────────────────────────────────────────┐
    │           FLUTTER MOBILE APP                    │
    │  iOS / Android / Web                            │
    └─────────────┬───────────────────────────────────┘
                  │
        ┌─────────┴─────────┐
        ▼                   ▼
    ┌─────────┐       ┌─────────────┐
    │ Railway │       │  Supabase   │
    │  API    │       │  Services   │
    └─────────┘       └─────────────┘
        │                   │
        ▼                   ▼
    ┌─────────┐       ┌─────────────┐
    │  AWS S3 │       │ PostgreSQL  │
    │ Storage │       │  Database   │
    └─────────┘       └─────────────┘
```

## Quick Start Guides

### AWS Setup

```bash
# Navigate to AWS configs
cd providers/aws

# Review compute options
cat compute/README.md

# Review storage options
cat storage/README.md
```

### Railway Deployment

```bash
# Navigate to Railway configs
cd providers/railway

# Follow deployment guide
cat deployment-configs/setup-guide.md

# Deploy using Railway CLI
railway up
```

### Supabase Integration

```bash
# Navigate to Supabase configs
cd providers/supabase

# Setup database
cat database-configs/schema.sql

# Configure environment
cp .env.example .env
```

### Vercel Deployment

```bash
# Navigate to Vercel configs
cd providers/vercel

# Deploy Next.js app
vercel deploy

# Or use CLI
npm install -g vercel
vercel
```

## Cost Comparison

```
┌────────────────────────────────────────────────────────────┐
│  PROVIDER    │  FREE TIER       │  TYPICAL COST (SMALL)   │
├────────────────────────────────────────────────────────────┤
│  AWS         │  12 months       │  $50-200/month          │
│  Railway     │  $5 credit/mo    │  $5-20/month            │
│  Supabase    │  500MB DB        │  $25/month (Pro)        │
│  Vercel      │  Unlimited       │  $20/month (Pro)        │
└────────────────────────────────────────────────────────────┘
```

## Configuration Files

### Environment Variables Template

```bash
# AWS Configuration
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_REGION=us-east-1
S3_BUCKET_NAME=your-bucket

# Railway Configuration
RAILWAY_TOKEN=your_railway_token
DATABASE_URL=postgresql://...

# Supabase Configuration
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your_anon_key
SUPABASE_SERVICE_KEY=your_service_key

# Vercel Configuration
VERCEL_TOKEN=your_vercel_token
NEXT_PUBLIC_API_URL=https://api.yourapp.com
```

## Security Best Practices

```
╔════════════════════════════════════════════════════╗
║           SECURITY CHECKLIST                       ║
╠════════════════════════════════════════════════════╣
║  ✓  Never commit API keys or secrets              ║
║  ✓  Use environment variables for credentials     ║
║  ✓  Enable MFA for all provider accounts          ║
║  ✓  Use IAM roles with least privilege (AWS)      ║
║  ✓  Enable audit logging                          ║
║  ✓  Regular security reviews                      ║
║  ✓  Rotate credentials periodically               ║
║  ✓  Use secrets management (AWS Secrets Manager)  ║
╚════════════════════════════════════════════════════╝
```

## Monitoring & Logging

```
    Provider Monitoring Setup
    ═════════════════════════

    AWS
    ├── CloudWatch Logs
    ├── CloudWatch Metrics
    └── AWS X-Ray (tracing)

    Railway
    ├── Built-in logs
    └── Metrics dashboard

    Supabase
    ├── Database logs
    ├── Auth logs
    └── API logs

    Vercel
    ├── Deployment logs
    ├── Function logs
    └── Analytics
```

## Migration Guides

Moving between providers? Check these guides:

- **Firebase → Supabase**: See `supabase/migration-from-firebase.md`
- **Heroku → Railway**: See `railway/migration-from-heroku.md`
- **Netlify → Vercel**: See `vercel/migration-from-netlify.md`

## Development vs Production

```
┌─────────────────────────────────────────────────────────────┐
│  ENVIRONMENT    │  PROVIDERS                                │
├─────────────────────────────────────────────────────────────┤
│  Development    │  • Local databases                        │
│                 │  • Supabase free tier                     │
│                 │  • Vercel preview deployments             │
├─────────────────────────────────────────────────────────────┤
│  Staging        │  • Railway (cost-effective)               │
│                 │  • Supabase (separate project)            │
│                 │  • Vercel (preview branch)                │
├─────────────────────────────────────────────────────────────┤
│  Production     │  • AWS (enterprise clients)               │
│                 │  • Railway/Supabase (small clients)       │
│                 │  • Vercel (frontend)                      │
└─────────────────────────────────────────────────────────────┘
```

## Support Resources

### Provider Documentation

- [AWS Documentation](https://docs.aws.amazon.com/)
- [Railway Docs](https://docs.railway.app/)
- [Supabase Docs](https://supabase.com/docs)
- [Vercel Docs](https://vercel.com/docs)

### Internal Resources

- See [infrastructure-devops](../infrastructure-devops/) for deployment guides
- See [development-resources](../development-resources/) for integration examples
- See [security](../development-resources/security/) for security configurations

## Contributing

When adding a new provider:

1. Create a new directory under `providers/`
2. Include setup documentation
3. Add configuration templates
4. Document integration examples
5. Include cost estimates

---

**Vivacity Digital** - Multi-cloud deployment expertise
