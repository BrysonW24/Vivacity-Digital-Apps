# Vivacity Digital Boilerplates

Complete collection of production-ready boilerplate templates for mobile and web applications.

**Last Updated**: December 21, 2025
**Status**: Ready for use

---

## Structure

```
boilerplates/
├── app-variants/                    # Mobile-first frameworks
│   ├── flutter-small-app/          # Basic Flutter template
│   ├── flutter-small-app-aws/      # AWS-integrated Flutter
│   ├── flutter-small-app-gcp/      # Google Cloud Flutter
│   └── flutter-small-app-onpremis/ # On-premise Flutter
│
├── web-variants/                    # Web-first platforms
│   ├── next-app/                   # Next.js template
│   └── react-web-platform/         # React fullstack template ✨ NEW
│
└── 0-archive/                       # Archived versions
```

---

## App Variants (Mobile-First)

### Flutter Boilerplates

All Flutter boilerplates include:
- Clean Architecture (5-layer)
- Provider state management
- SQLite local database
- Secure token storage
- HTTP client setup
- Internationalization (9 languages)
- Complete auth flow
- Ready-to-use screens
- Error handling
- Logging setup

#### flutter-small-app
**Best for**: MVP applications, learning
- Basic architecture
- Essential dependencies
- Minimal pre-built screens
- Quick to customize

#### flutter-small-app-aws
**Best for**: AWS-integrated projects
- AWS Amplify setup
- DynamoDB integration
- S3 file storage
- CloudWatch logging
- AWS IAM ready

#### flutter-small-app-gcp
**Best for**: Google Cloud projects
- Cloud Run deployment ready
- Firestore integration
- Cloud Storage setup
- Pub/Sub messaging
- BigQuery analytics

#### flutter-small-app-onpremis
**Best for**: Enterprise deployments
- Self-hosted backend setup
- Docker containerization
- Kubernetes ready
- Private API endpoints
- On-premise infrastructure

---

## Web Variants (Web-First)

### Next.js (next-app)

**Best for**: Server-side rendered websites, hybrid apps
- Next.js 14+ with App Router
- Server and client components
- API routes
- Image optimization
- Built-in analytics
- Vercel ready

### React Web Platform (react-web-platform) ✨ NEW

**Best for**: Fullstack web applications with Capacitor mobile option
- Professional monorepo setup
- 4 applications (customer, admin, API, mobile)
- 9 shared packages
- Background services
- Complete DevOps setup
- Production-ready architecture

#### Features

**Applications**:
- `web-customer/` - Customer-facing app
- `web-admin/` - Admin dashboard
- `api-server/` - RESTful API
- `mobile-wrapper/` - Capacitor mobile shell

**Shared Packages**:
- `component-library/` - Reusable UI components
- `api-client/` - Typed API SDK
- `authentication/` - Auth logic
- `build-configs/` - Build tools config
- `email-system/` - Email handling
- `analytics-tracking/` - Event tracking
- `database-schema/` - Prisma schema
- `common-utilities/` - Shared utilities
- `typescript-types/` - Shared TypeScript types

**Infrastructure**:
- Docker containerization
- Kubernetes manifests
- Terraform modules
- GitHub Actions CI/CD
- Comprehensive automation scripts

**Testing**:
- End-to-end (Playwright)
- Integration tests
- Load testing (k6)

**Documentation**:
- Architecture decision records
- Deployment guides
- Developer guides
- API reference

---

## Technology Stack by Category

### Mobile (app-variants)

```
Framework: Flutter
Language: Dart
State Management: Provider
Database: SQLite
Storage: Secure Storage
HTTP: Dio
DI: GetIt
Code Gen: Build Runner
Serialization: json_serializable, freezed
Testing: Mockito, flutter_test
```

### Web - Next.js (next-app)

```
Framework: Next.js
Language: TypeScript
Rendering: SSR/Static
Styling: CSS Modules, Tailwind
Deployment: Vercel
```

### Web - React Fullstack (react-web-platform)

```
Frontend:
  Framework: React 18+
  Language: TypeScript
  Build: Vite
  Routing: React Router
  State: Zustand/Redux
  Data Fetch: TanStack Query
  Forms: React Hook Form
  Styling: Tailwind CSS
  UI Framework: Headless UI

Backend:
  Runtime: Node.js
  Framework: Express
  Database: PostgreSQL
  ORM: Prisma
  Queue: Bull
  Cache: Redis
  Auth: JWT
  Validation: Zod

DevOps:
  Container: Docker
  Orchestration: Kubernetes
  IaC: Terraform
  CI/CD: GitHub Actions
  Monorepo: Turborepo

Testing:
  E2E: Playwright
  Unit: Vitest
  Load: k6
```

---

## Quick Start Guide

### Choose Your Boilerplate

**Question 1**: Mobile or Web?
- Mobile → **app-variants/**
- Web → **web-variants/**

**Question 2** (If Mobile): Which cloud platform?
- None/MVP → **flutter-small-app/**
- AWS → **flutter-small-app-aws/**
- Google Cloud → **flutter-small-app-gcp/**
- On-premise → **flutter-small-app-onpremis/**

**Question 3** (If Web): Single app or fullstack?
- Simple marketing site/blog → **next-app/**
- Complex fullstack app → **react-web-platform/**

### Setup

```bash
# 1. Copy boilerplate to your project
cp -r boilerplates/web-variants/react-web-platform my-app

# 2. Enter directory
cd my-app

# 3. Install dependencies
pnpm install

# 4. Setup environment
cp .env.example .env.local

# 5. Start development
pnpm dev
```

---

## Feature Matrix

| Feature | flutter-small-app | flutter-aws | flutter-gcp | flutter-onpremis | next-app | react-web-platform |
|---------|-------------------|-------------|-------------|------------------|----------|-------------------|
| Clean Architecture | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Authentication | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Database Setup | SQLite | SQLite | SQLite | SQLite | N/A | PostgreSQL |
| State Management | Provider | Provider | Provider | Provider | Next State | Zustand/Redux |
| API Integration | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Cloud Integration | ❌ | AWS | GCP | ❌ | ❌ | Any |
| Docker | ❌ | ❌ | ❌ | ✅ | ❌ | ✅ |
| Kubernetes | ❌ | ❌ | ❌ | ✅ | ❌ | ✅ |
| Monorepo | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Admin Panel | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Background Jobs | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Capacitor Mobile | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |
| Testing Suite | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Documentation | ✅ | ✅ | ✅ | ✅ | ✅ | ✅✅ |

---

## File Sizes

| Boilerplate | Size | Files |
|-------------|------|-------|
| flutter-small-app | ~50MB | ~500 |
| flutter-small-app-aws | ~55MB | ~520 |
| flutter-small-app-gcp | ~55MB | ~520 |
| flutter-small-app-onpremis | ~60MB | ~550 |
| next-app | ~30MB | ~300 |
| react-web-platform | ~80MB | ~600+ |

---

## Documentation

Each boilerplate includes comprehensive documentation:

- **README.md** - Project overview
- **CONTRIBUTING.md** - Contribution guidelines
- **Local Setup Guide** - Development environment setup
- **Architecture Docs** - System design decisions
- **Deployment Guides** - Production deployment
- **API Reference** - API documentation
- **CHANGELOG.md** - Version history

---

## Maintenance

### Regular Updates

Boilerplates are updated quarterly to keep up with:
- Framework versions
- Dependency updates
- Security patches
- Best practices

### Versioning

Format: `flutter-small-app@1.0.0`

Each boilerplate follows semantic versioning.

---

## Contributing to Boilerplates

To improve boilerplates:

1. Fork the boilerplate
2. Create feature branch
3. Make improvements
4. Test thoroughly
5. Submit PR with detailed description

---

## Support

**Need help?**

- Check boilerplate README
- Review documentation
- Open an issue
- Create a discussion

---

## License

All boilerplates are licensed under MIT License - free for commercial and personal use.

---

**Built with ❤️ by Vivacity Digital**

For more information: https://github.com/vivacitydigital
