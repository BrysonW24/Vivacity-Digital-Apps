# ADR 001: Monorepo Structure

## Status
Accepted

## Context
We needed to organize multiple related applications and packages in a way that:
- Allows code sharing across applications
- Maintains clear separation of concerns
- Enables independent deployment
- Simplifies dependency management
- Supports multiple application types (React, NestJS, mobile wrapper)

## Decision
We adopted a monorepo structure using pnpm workspaces and Turborepo.

## Structure

```
.
├── applications/          # Deployable applications
│   ├── web-customer/     # React Vite app
│   ├── web-admin/        # Next.js admin dashboard
│   ├── api-server/       # NestJS backend
│   └── mobile-wrapper/   # Capacitor mobile wrapper
├── shared-packages/      # Reusable packages
│   ├── component-library/
│   ├── api-client/
│   ├── authentication/
│   ├── build-configs/
│   ├── email-system/
│   ├── analytics-tracking/
│   ├── database-schema/
│   ├── common-utilities/
│   └── typescript-types/
├── background-services/  # Long-running services
│   ├── job-worker/
│   └── scheduled-tasks/
├── docker-configs/       # Docker configurations
├── kubernetes-manifests/ # K8s deployments
├── terraform-modules/    # IaC definitions
├── .github/             # CI/CD workflows
└── documentation/       # Project documentation
```

## Benefits

1. **Code Sharing**: Shared packages reduce duplication
2. **Consistent Tooling**: Single source of truth for configs
3. **Atomic Commits**: Changes across packages in single commit
4. **Simplified Dependency Management**: pnpm handles monorepo deps
5. **Build Optimization**: Turborepo caching and parallelization
6. **Easy Testing**: Test all packages with single command

## Drawbacks

1. **Complexity**: Larger learning curve for new developers
2. **Build Time**: Initial setup takes longer
3. **CI/CD**: Pipeline needs to understand monorepo structure

## Alternatives Considered

### Multi-repo Approach
- Pros: Complete independence, easier to understand
- Cons: Code duplication, hard to sync versions

### Single App Approach
- Pros: Simple structure
- Cons: Tight coupling, harder to scale

## Consequences

- All developers need to understand monorepo structure
- Dependencies must be carefully managed
- CI/CD pipeline must support workspaces
- Deployment process is more complex but more flexible
