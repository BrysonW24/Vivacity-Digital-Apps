# Local Development Setup

Complete guide for setting up React Web Platform for development.

## Prerequisites

- **Node.js**: 18+ (LTS recommended)
- **pnpm**: 8+ (faster than npm/yarn)
- **PostgreSQL**: 14+ (database)
- **Redis**: 7+ (caching)
- **Docker**: Latest (optional, for containerized development)

## Installation Steps

### 1. Clone Repository

```bash
git clone https://github.com/vivacitydigital/react-web-platform.git
cd react-web-platform
```

### 2. Install pnpm (if not already installed)

```bash
npm install -g pnpm
```

### 3. Install Dependencies

```bash
pnpm install
```

### 4. Setup Environment Variables

```bash
cp .env.example .env.local
```

Edit `.env.local` and fill in your values:

```env
# Database
DATABASE_URL=postgresql://postgres:password@localhost:5432/react_web_platform

# Redis
REDIS_URL=redis://localhost:6379

# JWT Secret (generate with: openssl rand -base64 32)
JWT_SECRET=your-generated-secret-here
JWT_REFRESH_SECRET=your-refresh-secret-here

# OAuth (optional)
GITHUB_CLIENT_ID=your-github-oauth-id
GITHUB_CLIENT_SECRET=your-github-oauth-secret
```

### 5. Setup Database

#### Option A: Docker (Recommended)

```bash
# Start PostgreSQL and Redis containers
pnpm docker:up

# Run migrations
pnpm db:push

# Seed database with sample data
pnpm db:seed
```

#### Option B: Local Installation

```bash
# Create database
createdb react_web_platform

# Run migrations
pnpm db:push

# Seed database
pnpm db:seed
```

### 6. Start Development Server

```bash
# Start all apps in development mode
pnpm dev

# Or start individual apps
pnpm dev --filter=web-customer
pnpm dev --filter=api-server
pnpm dev --filter=web-admin
```

Applications will start on:
- Web Customer: http://localhost:3000
- API Server: http://localhost:3001
- Admin Dashboard: http://localhost:3002

## Verification

### Check installations

```bash
node --version          # Should be 18+
pnpm --version          # Should be 8+
psql --version          # PostgreSQL client
redis-cli --version     # Redis client
```

### Test connections

```bash
# Test database
psql postgresql://postgres:password@localhost:5432/react_web_platform -c "SELECT 1;"

# Test Redis
redis-cli ping          # Should return PONG

# Test API
curl http://localhost:3001/api/health
```

## Common Tasks

### Database Management

```bash
# View database (Prisma Studio)
pnpm db:studio

# Create migration
pnpm db:migrate:dev --name your_migration_name

# Reset database (careful!)
pnpm db:reset

# Generate Prisma client
pnpm db:generate
```

### Code Quality

```bash
# Lint all code
pnpm lint

# Format all code
pnpm format

# Type check
pnpm type-check

# Run tests
pnpm test

# Run tests in watch mode
pnpm test:watch
```

### Building

```bash
# Build all packages
pnpm build

# Build specific package
pnpm build --filter=web-customer

# View built assets
ls -la dist/
ls -la .next/
```

## Troubleshooting

### Port Already in Use

```bash
# Kill process on port 3000
lsof -ti:3000 | xargs kill -9

# Kill process on port 3001
lsof -ti:3001 | xargs kill -9
```

### Database Connection Error

```bash
# Verify PostgreSQL is running
pg_isready -h localhost -p 5432

# Check connection string
echo $DATABASE_URL

# Recreate database
dropdb react_web_platform
createdb react_web_platform
pnpm db:push
```

### Redis Connection Error

```bash
# Verify Redis is running
redis-cli ping

# Restart Redis
brew services restart redis  # macOS
# or
sudo systemctl restart redis-server  # Linux
```

### Module Not Found

```bash
# Clear node_modules and reinstall
pnpm clean
pnpm install
pnpm build
```

### Prisma Client Missing

```bash
# Generate Prisma client
pnpm db:generate

# Or rebuild everything
pnpm clean
pnpm install
```

## IDE Setup

### VS Code

Install extensions:
- ESLint
- Prettier
- Tailwind CSS IntelliSense
- TypeScript Vue Plugin
- REST Client

Create `.vscode/settings.json`:

```json
{
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "editor.formatOnSave": true,
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  }
}
```

### WebStorm

- Go to Settings → Languages & Frameworks → TypeScript
- Set TypeScript version to "Use local version"
- Enable ESLint integration
- Configure Prettier

## Git Hooks

Pre-commit hooks are setup with Husky:

```bash
# Install hooks
pnpm prepare

# Run hooks manually
pnpm husky install
```

Hooks will:
- Lint staged files
- Format code
- Run type check

## Next Steps

1. Read [Architecture Documentation](../architecture-decisions/system-overview.md)
2. Check [Contributing Guide](CONTRIBUTING.md)
3. Review [API Documentation](../api-reference/)
4. Start building!

## Getting Help

- Check [documentation](../)
- Open an [issue](https://github.com/vivacitydigital/react-web-platform/issues)
- Create a [discussion](https://github.com/vivacitydigital/react-web-platform/discussions)
