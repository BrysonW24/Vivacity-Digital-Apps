# Next.js Web Boilerplate

Production-ready Next.js 14 boilerplate with TypeScript, Tailwind CSS, NextAuth, and more.

## Quick Start

### Prerequisites

- Node.js 18+
- npm or yarn

### Installation

```bash
npm install
# or
yarn install
```

### Development

```bash
npm run dev
# or
yarn dev
```

Visit [http://localhost:3000](http://localhost:3000) to see your application.

### Build for Production

```bash
npm run build
npm start
```

## Project Structure

```
src/
├── app/                    # Next.js app directory
│   ├── api/               # API routes
│   ├── layout.tsx         # Root layout
│   └── page.tsx           # Home page
├── components/            # React components
├── hooks/                 # Custom React hooks
├── lib/                   # Utilities and helpers
│   ├── api-client.ts      # Axios API client
│   └── validators.ts      # Zod validation schemas
├── services/              # Business logic services
├── types/                 # TypeScript type definitions
├── utils/                 # Common utility functions
└── styles/                # Global styles
```

## Key Technologies

### Frontend Framework
- **Next.js 14** - React framework with App Router
- **React 18** - UI library
- **TypeScript** - Type safety

### Styling & UI
- **Tailwind CSS** - Utility-first CSS
- **Radix UI** - Headless UI components

### State Management
- **Zustand** - Lightweight state management
- **React Query** - Server state management
- **NextAuth.js** - Authentication

### Forms & Validation
- **React Hook Form** - Flexible form handling
- **Zod** - TypeScript-first schema validation

### HTTP Client
- **Axios** - Promise-based HTTP client
- Custom interceptors for auth and error handling

### Development Tools
- **ESLint** - Code linting
- **Prettier** - Code formatting
- **TypeScript** - Static type checking

### Testing
- **Playwright** - E2E testing

## Configuration

### Environment Variables

Create `.env.local` based on `.env.example`:

```bash
NEXT_PUBLIC_API_BASE_URL=http://localhost:3000/api
NEXTAUTH_SECRET=your-secret-key
NEXTAUTH_URL=http://localhost:3000
```

### API Configuration

Update `src/lib/api-client.ts` with your API base URL and authentication strategy.

### Theme Configuration

Customize colors and spacing in `tailwind.config.ts`.

## Available Scripts

```bash
# Development
npm run dev              # Start dev server

# Building
npm run build            # Build for production
npm start                # Start production server

# Code Quality
npm run lint             # Run ESLint
npm run type-check       # Type check with TypeScript
npm run format           # Format code with Prettier
npm run format:check     # Check formatting

# Testing
npm run test:e2e         # Run Playwright tests
```

## Authentication

The boilerplate includes NextAuth.js configured with:

- Credentials provider (email/password)
- JWT session strategy
- Protected routes
- Session callbacks

To implement your authentication:

1. Update `src/app/api/auth/[...nextauth]/route.ts`
2. Configure your credential provider
3. Implement login/signup pages

## API Integration

The `apiClient` in `src/lib/api-client.ts` handles:

- Request/response interceptors
- Automatic token injection
- Error standardization
- Retry logic for failures

### Usage

```typescript
import { apiClient } from '@/lib/api-client';

// GET request
const data = await apiClient.get('/users/me');

// POST request
const result = await apiClient.post('/posts', {
  title: 'New Post',
  content: 'Post content',
});
```

## Form Validation

Use Zod schemas with React Hook Form:

```typescript
import { useForm } from 'react-hook-form';
import { zodResolver } from '@hookform/resolvers/zod';
import { loginSchema, type LoginFormData } from '@/lib/validators';

export function LoginForm() {
  const { register, handleSubmit, formState: { errors } } = useForm<LoginFormData>({
    resolver: zodResolver(loginSchema),
  });

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <input {...register('email')} />
      {errors.email && <span>{errors.email.message}</span>}
    </form>
  );
}
```

## Hooks

Custom hooks available in `src/hooks/`:

- `useAsync` - Handle async operations
- `useDebounce` - Debounce values
- `usePrevious` - Track previous value
- `useLocalStorage` - Persist state to localStorage
- `useIsMounted` - Check if component is mounted

## Utilities

Common utilities in `src/utils/common.ts`:

- Date formatting and manipulation
- Number and currency formatting
- String manipulation
- Object cloning and merging
- UUID generation

## Contributing

1. Create a feature branch
2. Make your changes
3. Format code: `npm run format`
4. Run linter: `npm run lint`
5. Type check: `npm run type-check`
6. Submit a pull request

## License

MIT

## Support

For questions or issues, please open an issue or contact support.

## Documentation

- [Next.js Docs](https://nextjs.org/docs)
- [React Docs](https://react.dev)
- [Tailwind CSS](https://tailwindcss.com)
- [TypeScript](https://www.typescriptlang.org)
- [NextAuth.js](https://next-auth.js.org)
