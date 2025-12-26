# NestJS API Server

A production-ready NestJS RESTful API server with authentication, user management, and comprehensive security features.

## Features

- **Authentication**: JWT-based authentication with refresh tokens
- **User Management**: Complete user CRUD operations with role-based access control
- **Email Service**: Integrated email functionality for notifications
- **Health Checks**: Built-in health check endpoints
- **API Documentation**: Auto-generated Swagger/OpenAPI documentation
- **Security**: Helmet, CORS, rate limiting, and input validation
- **Database**: PostgreSQL with Prisma ORM

## Tech Stack

- **Framework**: NestJS 10
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: Passport.js with JWT strategy
- **Validation**: class-validator and class-transformer
- **Documentation**: Swagger/OpenAPI
- **Security**: Helmet, CORS, Throttler
- **Caching**: Redis (optional)

## Getting Started

### Prerequisites

- Node.js >= 18.0.0
- PostgreSQL >= 14
- npm >= 9.0.0
- Redis (optional, for caching)

### Installation

1. Install dependencies:
```bash
npm install
```

2. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

3. Set up the database:
```bash
npm run prisma:generate
npm run prisma:migrate
```

4. Seed the database (optional):
```bash
npm run prisma:seed
```

### Development

Start the development server:
```bash
npm run start:dev
```

The API will be available at `http://localhost:3001`

### API Documentation

Swagger documentation is available at `http://localhost:3001/api/docs`

## Available Scripts

### Development
- `npm run start` - Start production server
- `npm run start:dev` - Start development server with watch mode
- `npm run start:debug` - Start debug mode with watch

### Building
- `npm run build` - Build for production
- `npm run prebuild` - Clean dist folder

### Testing
- `npm test` - Run unit tests
- `npm run test:watch` - Run tests in watch mode
- `npm run test:cov` - Run tests with coverage
- `npm run test:e2e` - Run end-to-end tests

### Database
- `npm run prisma:generate` - Generate Prisma client
- `npm run prisma:migrate` - Run database migrations
- `npm run prisma:studio` - Open Prisma Studio
- `npm run prisma:seed` - Seed database
- `npm run db:reset` - Reset database
- `npm run db:setup` - Complete database setup

### Code Quality
- `npm run lint` - Run ESLint
- `npm run format` - Format code with Prettier
- `npm run type-check` - Run TypeScript type checking

## Project Structure

```
src/
├── common/              # Shared utilities, filters, interceptors
├── config/              # Configuration files
├── database/            # Database module and seeds
├── modules/             # Feature modules
│   ├── auth/           # Authentication module
│   ├── users/          # User management module
│   ├── email/          # Email service module
│   └── health/         # Health check module
├── app.module.ts       # Root application module
└── main.ts             # Application entry point
```

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login
- `POST /api/auth/refresh` - Refresh access token
- `POST /api/auth/logout` - User logout
- `POST /api/auth/forgot-password` - Request password reset
- `POST /api/auth/reset-password` - Reset password

### Users
- `GET /api/users` - Get all users (Admin)
- `GET /api/users/:id` - Get user by ID
- `PATCH /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

### Health
- `GET /api/health` - Basic health check
- `GET /api/health/db` - Database health check
- `GET /api/health/redis` - Redis health check (if enabled)

## Environment Variables

See `.env.example` for all available environment variables.

Key variables:
- `DATABASE_URL` - PostgreSQL connection string
- `JWT_SECRET` - Secret key for JWT tokens
- `CORS_ORIGIN` - Allowed CORS origins
- `EMAIL_*` - Email service configuration
- `REDIS_*` - Redis configuration (optional)

## Security Features

- **Helmet**: Security headers
- **CORS**: Cross-origin resource sharing
- **Rate Limiting**: Throttle API requests
- **Input Validation**: DTO validation with class-validator
- **Password Hashing**: bcrypt for secure password storage
- **JWT Authentication**: Secure token-based authentication
- **Role-Based Access Control**: Granular permissions

## Deployment

### Docker

Build and run with Docker:
```bash
docker-compose up -d
```

### Production Build

```bash
npm run build
npm run start:prod
```

## Testing

Run the test suite:
```bash
# Unit tests
npm test

# E2E tests
npm run test:e2e

# Test coverage
npm run test:cov
```

## Contributing

1. Create a feature branch
2. Make your changes
3. Write/update tests
4. Ensure linting passes: `npm run lint`
5. Submit a pull request

## License

MIT

## Support

For issues and questions, please create an issue in the repository.
