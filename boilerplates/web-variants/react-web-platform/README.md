# React Web Platform

A professional, production-ready fullstack web application boilerplate built with React, TypeScript, and modern DevOps practices.

## Overview

**React Web Platform** is a comprehensive starter template for building scalable web applications with:

- **Frontend**: React + TypeScript + Tailwind CSS
- **Backend**: Node.js/Express API server
- **Admin Dashboard**: Full-featured admin panel
- **Mobile Support**: Optional Capacitor wrapper for iOS/Android
- **Monorepo**: Turborepo for efficient workspace management
- **Infrastructure**: Docker, Kubernetes, Terraform ready
- **CI/CD**: GitHub Actions workflows
- **Testing**: E2E, Integration, Load testing suites
- **DevOps**: Professional deployment automation

## Project Structure

```
react-web-platform/
├── applications/                   # Deployable applications
│   ├── web-customer/              # Customer-facing web app
│   ├── web-admin/                 # Admin dashboard
│   ├── api-server/                # Backend API service
│   └── mobile-wrapper/            # Capacitor mobile shell
│
├── shared-packages/               # Reusable libraries
│   ├── component-library/         # UI components
│   ├── api-client/                # API SDK
│   ├── authentication/            # Auth logic
│   ├── build-configs/             # Build configuration
│   ├── email-system/              # Email handling
│   ├── analytics-tracking/        # Event tracking
│   ├── database-schema/           # Database models
│   ├── common-utilities/          # Shared utilities
│   └── typescript-types/          # Shared types
│
├── background-services/           # Worker services
│   ├── job-worker/                # Background jobs
│   └── scheduled-tasks/           # Cron jobs
│
├── infrastructure/                # DevOps & deployment
│   ├── docker-configs/            # Docker setup
│   ├── automation-scripts/        # Build/deploy scripts
│   ├── kubernetes-manifests/      # K8s configs
│   └── terraform-modules/         # Infrastructure as code
│
├── .github/                       # GitHub configuration
│   ├── workflows/                 # CI/CD pipelines
│   └── issue-templates/           # Issue templates
│
├── documentation/                 # Project documentation
│   ├── architecture-decisions/    # ADRs
│   ├── deployment-guides/         # Deployment docs
│   ├── developer-guides/          # Developer docs
│   └── api-reference/             # API documentation
│
├── test-suites/                   # Test configurations
│   ├── end-to-end/                # Playwright tests
│   ├── integration/               # Integration tests
│   └── load-testing/              # k6 load tests
│
├── .husky/                        # Git hooks
├── turbo.json                     # Monorepo configuration
├── pnpm-workspace.yaml            # Workspace config
├── package.json                   # Root dependencies
├── tsconfig.json                  # TypeScript config
├── .gitignore                     # Git ignore rules
└── LICENSE                        # MIT License
```

## Tech Stack

### Core Technologies
- **React 18+** - UI framework
- **TypeScript** - Type safety
- **Node.js** - Runtime
- **Express** - Web framework
- **PostgreSQL** - Database
- **Redis** - Caching

### Frontend
- **Tailwind CSS** - Utility-first CSS
- **React Router** - Client-side routing
- **TanStack Query** - Data fetching
- **Zustand/Redux** - State management
- **Zod/Yup** - Validation

### Backend
- **Prisma** - ORM
- **Zod** - API validation
- **JWT** - Authentication
- **Bull** - Job queue
- **Nodemailer** - Email

### DevOps & Infrastructure
- **Docker** - Containerization
- **Kubernetes** - Orchestration
- **Terraform** - Infrastructure as Code
- **GitHub Actions** - CI/CD
- **Vercel/AWS** - Deployment

### Testing
- **Playwright** - End-to-end testing
- **Vitest** - Unit testing
- **k6** - Load testing

## Quick Start

### Prerequisites
- Node.js 18+
- pnpm 8+
- Docker (optional)

### Installation

```bash
# Clone the repository
git clone https://github.com/vivacitydigital/react-web-platform.git
cd react-web-platform

# Install dependencies
pnpm install

# Setup environment variables
cp .env.example .env.local

# Start development
pnpm dev
```

### Development Commands

```bash
# Start all applications in development mode
pnpm dev

# Build all packages
pnpm build

# Run tests
pnpm test

# Run linting
pnpm lint

# Format code
pnpm format

# Type check
pnpm type-check
```

## Project Organization

### Applications

**web-customer/**
- Customer-facing web application
- Public routes and features
- Deployed to Vercel/AWS

**web-admin/**
- Internal admin dashboard
- Protected routes (admin only)
- Advanced analytics and management

**api-server/**
- RESTful API backend
- Authentication and authorization
- Database operations
- Third-party integrations

**mobile-wrapper/**
- Capacitor configuration
- iOS/Android builds
- Native bridge setup

### Shared Packages

**component-library/**
- Reusable React components
- Storybook documentation
- Design system

**api-client/**
- Typed API SDK
- Request/response handling
- Error management

**authentication/**
- JWT handling
- OAuth integration
- Session management

**build-configs/**
- ESLint, Prettier, TypeScript
- Tailwind CSS
- Vite/Webpack configuration

**database-schema/**
- Prisma schema
- Migrations
- Database utilities

## Architecture

### Monorepo Strategy
This project uses **Turborepo** for efficient workspace management:

- Shared dependency deduplication
- Optimized builds with caching
- Parallel task execution
- Workspace-aware linting and testing

### API Architecture
- RESTful endpoints
- OpenAPI/Swagger documentation
- Versioned APIs
- Middleware for auth, logging, validation

### Database
- PostgreSQL with Prisma ORM
- Migrations tracked in version control
- Seed data for development
- Connection pooling with PgBouncer

### Authentication
- JWT tokens with refresh mechanism
- OAuth2 support (Google, GitHub, etc.)
- Role-based access control (RBAC)
- Session management

## Deployment

### To Vercel (Frontend)
```bash
pnpm deploy:web-customer:vercel
```

### To AWS (Full Stack)
```bash
pnpm deploy:aws
```

### With Docker
```bash
docker-compose -f infrastructure/docker-configs/docker-compose.yml up
```

### With Kubernetes
```bash
kubectl apply -f infrastructure/kubernetes-manifests/
```

### With Terraform
```bash
cd infrastructure/terraform-modules
terraform apply -var-file=environments/production/terraform.tfvars
```

## Testing

### End-to-End Tests
```bash
pnpm test:e2e
```

### Integration Tests
```bash
pnpm test:integration
```

### Load Testing
```bash
pnpm test:load
```

### All Tests
```bash
pnpm test
```

## CI/CD Pipeline

GitHub Actions workflows handle:
- ✅ Continuous Integration (linting, testing, building)
- ✅ Automated deployment to Vercel
- ✅ AWS deployment
- ✅ Admin dashboard deployment
- ✅ Mobile builds (iOS/Android)
- ✅ Security scanning
- ✅ Performance monitoring

## Contributing

See [CONTRIBUTING.md](documentation/developer-guides/CONTRIBUTING.md) for:
- Code style guidelines
- Commit message conventions
- Pull request process
- Development workflow

## Documentation

- [Architecture Decisions](documentation/architecture-decisions/)
- [Local Setup Guide](documentation/developer-guides/local-setup.md)
- [Deployment Guides](documentation/deployment-guides/)
- [API Reference](documentation/api-reference/)

## Environment Variables

See `.env.example` for required variables:

```
# API
API_URL=http://localhost:3000
API_KEY=your-api-key

# Database
DATABASE_URL=postgresql://user:password@localhost:5432/database

# Redis
REDIS_URL=redis://localhost:6379

# Email
SENDGRID_API_KEY=your-sendgrid-key

# Authentication
JWT_SECRET=your-jwt-secret
OAUTH_CLIENT_ID=your-oauth-client-id
OAUTH_CLIENT_SECRET=your-oauth-client-secret
```

## Performance

- Optimized bundle size
- Code splitting and lazy loading
- Image optimization
- Caching strategies
- API rate limiting

## Security

- Environment variable isolation
- CORS configuration
- CSRF protection
- SQL injection prevention (ORM)
- XSS protection
- Rate limiting
- Security headers

## License

MIT License - See [LICENSE](LICENSE)

## Support

For questions or issues:
- Check [documentation](documentation/)
- Open an [issue](https://github.com/vivacitydigital/react-web-platform/issues)
- Create a [discussion](https://github.com/vivacitydigital/react-web-platform/discussions)

## Roadmap

- [ ] GraphQL support
- [ ] WebSocket real-time features
- [ ] Advanced caching strategies
- [ ] Multi-tenant support
- [ ] Headless CMS integration
- [ ] Analytics dashboard

---

**Built for modern, scalable web applications.**

Maintained by [Vivacity Digital](https://vivacitydigital.com)
