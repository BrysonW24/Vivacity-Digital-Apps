#!/bin/bash

set -e

echo "=== React Web Platform Setup ==="
echo ""

# Check Node.js version
echo "Checking Node.js version..."
node_version=$(node -v)
echo "Node version: $node_version"

# Check pnpm
echo "Checking pnpm..."
if ! command -v pnpm &> /dev/null; then
  echo "Installing pnpm globally..."
  npm install -g pnpm
fi

# Install dependencies
echo "Installing dependencies..."
pnpm install

# Setup environment
echo "Setting up environment..."
if [ ! -f .env.local ]; then
  cp .env.example .env.local
  echo "Created .env.local from .env.example - Please update with your values"
fi

# Start Docker services
echo "Starting Docker services..."
docker-compose -f docker-configs/docker-compose.yml up -d

# Wait for services to be ready
echo "Waiting for services to be ready..."
sleep 10

# Setup database
echo "Setting up database..."
pnpm db:push
pnpm db:seed

echo ""
echo "=== Setup Complete ==="
echo "Run 'pnpm dev' to start development"
