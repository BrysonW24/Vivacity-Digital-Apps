# Political Strategy Workbench

```
    ╔══════════════════════════════════════════════════════════════╗
    ║                                                              ║
    ║   ██████╗  ██████╗ ██╗     ██╗████████╗██╗ ██████╗ █████╗ ██╗
    ║   ██╔══██╗██╔═══██╗██║     ██║╚══██╔══╝██║██╔════╝██╔══██╗██║
    ║   ██████╔╝██║   ██║██║     ██║   ██║   ██║██║     ███████║██║
    ║   ██╔═══╝ ██║   ██║██║     ██║   ██║   ██║██║     ██╔══██║██║
    ║   ██║     ╚██████╔╝███████╗██║   ██║   ██║╚██████╗██║  ██║███████╗
    ║   ╚═╝      ╚═════╝ ╚══════╝╚═╝   ╚═╝   ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝
    ║                                                              ║
    ║         S T R A T E G Y   W O R K B E N C H                  ║
    ║                                                              ║
    ╚══════════════════════════════════════════════════════════════╝
```

## Overview

**Political Strategy Workbench** is an AI-powered intelligence platform for analyzing political and business news from Australian sources. It helps strategists, analysts, and decision-makers identify thought leadership opportunities, discover strategic moats, and detect market disruption signals.

## Features

### 🎯 Four Core Analysis Tools

1. **Thought Leadership Analyzer**
   - Identify trending topics and narratives
   - Analyze sentiment and public opinion
   - Find opportunities for thought leadership
   - Track competitor positioning

2. **Strategic Moat Finder**
   - Discover competitive advantages
   - Identify defensible market positions
   - Analyze industry barriers to entry
   - Map strategic differentiators

3. **Disruption Radar**
   - Detect emerging technologies
   - Track industry disruption signals
   - Monitor competitive threats
   - Identify innovation opportunities

4. **News Intelligence** ⭐ NEW
   - Real-time news aggregation from Australian sources
   - ABC News, The Guardian Australia, and News.com.au
   - Category and source filtering
   - Sentiment analysis on articles
   - Direct links to original articles

### 📰 News Aggregation

The platform automatically fetches and stores news articles from:
- **ABC News** (RSS Feed)
- **The Guardian Australia** (API)
- **News.com.au** (RSS Feed)

Articles are fetched every 30 minutes and stored in the database with:
- Title, content, and source information
- Publication date and category
- Sentiment analysis (when available)
- Tags for easy filtering

## Tech Stack

### Frontend
- **Framework**: Next.js 14 (App Router)
- **Language**: TypeScript (strict mode)
- **Styling**: Tailwind CSS 3.4
- **Testing**: Vitest + Testing Library
- **Code Quality**: ESLint + Prettier
- **Git Hooks**: Husky

### Backend
- **Framework**: NestJS 10
- **Database**: PostgreSQL with Prisma ORM
- **News Aggregation**: RSS Parser, Axios, Cheerio
- **Scheduling**: @nestjs/schedule (Cron jobs)
- **Authentication**: JWT with Passport
- **API Documentation**: Swagger/OpenAPI

## Quick Start

### Prerequisites

- Node.js 18+
- npm 9+
- PostgreSQL 14+
- The Guardian API Key (get one at https://open-platform.theguardian.com/access/)

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd political-strategy-workbench

# Install frontend dependencies
npm install

# Install backend dependencies
cd backend/api-server
npm install

# Install NestJS CLI globally
npm install -g @nestjs/cli
```

### Environment Setup

1. Configure the backend environment:

```bash
cd backend/api-server
cp .env.example .env
# Edit .env and add your Guardian API key
```

Required environment variables:
- `DATABASE_URL` - PostgreSQL connection string
- `GUARDIAN_API_KEY` - Your Guardian API key (in .env file)
- `JWT_SECRET` - Secret for JWT tokens
- `PORT` - Backend port (default: 3001)
- `STATIC_USERNAME` - Static login username (default: admin)
- `STATIC_PASSWORD` - Static login password (default: password123)

### Database Setup

```bash
cd backend/api-server

# Generate Prisma client
npx prisma generate

# Push schema to database
npx prisma db push

# (Optional) Seed the database
npm run prisma:seed
```

### Running the Application

Open two terminals:

**Terminal 1 - Frontend:**
```bash
npm run dev
```
Frontend will start at [http://localhost:3000](http://localhost:3000)

**Terminal 2 - Backend:**
```bash
cd backend/api-server
npm run start:dev
```
Backend API will start at [http://localhost:3001](http://localhost:3001)

### Using the Makefile (Linux/Mac)

```bash
# Install all dependencies
make install

# Start frontend
make dev-frontend

# Start backend (in separate terminal)
make dev-backend

# Setup database
make db-setup

# Run all tests
make test
```

### Using build.cmd (Windows)

```cmd
# Install all dependencies
build install

# Start frontend
build dev-frontend

# Start backend (in separate terminal)
build dev-backend

# Setup database
build db-setup
```

## Development Commands

### Frontend Commands

```bash
# Development
npm run dev              # Start dev server
npm run build            # Build for production
npm run start            # Start production server

# Code Quality
npm run lint             # Run ESLint
npm run lint:fix         # Fix ESLint issues
npm run typecheck        # Run TypeScript type checking
npm run format           # Format code with Prettier

# Testing
npm test                 # Run tests in watch mode
npm run test:ui          # Run tests with UI
npm run test:coverage    # Run tests with coverage
```

### Backend Commands

```bash
cd backend/api-server

# Development
npm run start:dev        # Start backend in watch mode
npm run build            # Build for production
npm run start:prod       # Start production server

# Database
npm run prisma:generate  # Generate Prisma client
npm run prisma:migrate   # Run migrations
npm run prisma:studio    # Open Prisma Studio
npm run db:setup         # Complete database setup
npm run db:reset         # Reset database

# Code Quality
npm run lint             # Run ESLint
npm run format           # Format code with Prettier
npm run type-check       # TypeScript type checking

# Testing
npm test                 # Run unit tests
npm run test:watch       # Run tests in watch mode
npm run test:cov         # Run tests with coverage
npm run test:e2e         # Run end-to-end tests
```

## Project Structure

```
political-strategy-workbench/
├── src/
│   ├── app/                    # Next.js app directory
│   │   ├── page.tsx           # Thought Leadership page
│   │   ├── moat-finder/       # Strategic Moat Finder
│   │   ├── disruption-radar/  # Disruption Radar
│   │   └── news/              # News Intelligence page ⭐
│   ├── components/             # React components
│   │   └── Navigation.tsx     # Main navigation
│   ├── lib/                    # Utility functions
│   ├── hooks/                  # Custom React hooks
│   └── types/                  # TypeScript types
├── backend/
│   └── api-server/            # NestJS backend
│       ├── src/
│       │   ├── modules/
│       │   │   ├── auth/              # Authentication
│       │   │   ├── users/             # User management
│       │   │   ├── news-articles/     # News articles CRUD
│       │   │   ├── news-aggregation/  # News fetching ⭐
│       │   │   ├── analysis/          # AI analysis
│       │   │   └── campaigns/         # Campaign management
│       │   ├── database/      # Database module
│       │   └── common/        # Shared utilities
│       ├── prisma/
│       │   └── schema.prisma  # Database schema
│       └── docs/
│           └── GUARDIAN_API.md # Guardian API documentation
├── tests/                      # Frontend tests
├── docker-configs/            # Docker configuration
├── .github/workflows/         # CI/CD pipelines
├── Makefile                   # Build automation (Linux/Mac)
└── build.cmd                  # Build automation (Windows)
```

## News Aggregation

### How It Works

1. **Scheduled Fetching**: News is automatically fetched every 30 minutes via Cron job
2. **Multiple Sources**: Aggregates from ABC News, Guardian AU, and News.com.au
3. **Deduplication**: Checks for existing articles before storing
4. **Categories**: Articles are categorized (Politics, Business, Technology, etc.)
5. **Storage**: All articles stored in PostgreSQL via Prisma ORM

### API Endpoints

- `GET /api/news-articles` - Get all news articles (with pagination)
- `GET /api/news-articles/:id` - Get single article
- `GET /api/news-aggregation/fetch` - Manually trigger news fetch
- `GET /api/news-aggregation/recent` - Get recent articles
- `GET /api/news-aggregation/sources` - Get available sources

### Guardian API Setup

1. Get your free API key from https://open-platform.theguardian.com/access/
2. Add it to `backend/api-server/.env`:
   ```
   GUARDIAN_API_KEY=your-api-key-here
   ```
3. Restart the backend server

See `backend/api-server/docs/GUARDIAN_API.md` for detailed Guardian API documentation.

## Docker Support

```bash
# Start all services with Docker
make docker-up

# Build Docker images
make docker-build

# Stop all services
make docker-down

# View logs
make docker-logs
```

## Testing

### Frontend Tests
```bash
npm test                  # Run all tests
npm run test:coverage     # With coverage report
```

### Backend Tests
```bash
cd backend/api-server
npm test                  # Run unit tests
npm run test:e2e          # Run end-to-end tests
npm run test:cov          # With coverage
```

## Authentication

The application uses **simplified static authentication** for easy access:

**Default Login Credentials:**
- Username: `admin`
- Password: `password123`

You can customize these in the `.env` file:
```env
STATIC_USERNAME=admin
STATIC_PASSWORD=password123
```

The authentication still uses JWT tokens for secure API access, but no database or user registration is required. All JWT infrastructure is preserved for future expansion if needed.

## API Documentation

Once the backend is running, visit:
- Swagger UI: http://localhost:3001/api/docs
- Health Check: http://localhost:3001/api/health

## CI/CD

GitHub Actions workflows included:
- **ci.yml** - Runs tests, linting, and builds on every push
- **deploy-web.yml** - Deploy frontend
- **deploy-api.yml** - Deploy backend

## Contributing

1. Create a feature branch
2. Make your changes
3. Run tests: `npm test`
4. Run linting: `npm run lint`
5. Commit with descriptive message
6. Push and create a pull request

## License

MIT

## Support

For issues and questions:
- Backend API Documentation: http://localhost:3001/api/docs
- Guardian API Docs: `backend/api-server/docs/GUARDIAN_API.md`
- Create an issue in the repository

---

**Built with ❤️ for strategic intelligence and political analysis**
