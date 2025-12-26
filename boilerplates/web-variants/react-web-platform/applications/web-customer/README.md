# Web Customer Application

Customer-facing React web application built with Vite, React Router, and Tailwind CSS.

## Features

- Server-side rendering optimized
- Client-side routing with React Router
- State management with Zustand
- Data fetching with TanStack Query
- Form handling with React Hook Form
- UI components from shared component library
- Responsive design with Tailwind CSS
- Dark mode support
- Authentication with JWT

## Getting Started

```bash
# Install dependencies
pnpm install

# Development
pnpm dev

# Build
pnpm build

# Preview
pnpm preview
```

## Directory Structure

```
src/
├── components/          # React components
├── pages/              # Page components
├── hooks/              # Custom React hooks
├── utils/              # Utility functions
├── types/              # TypeScript types
├── stores/             # Zustand stores
├── services/           # API services
├── styles/             # Global styles
└── main.tsx            # Entry point
```

## Deployment

Deploy to Vercel:

```bash
pnpm deploy
```
