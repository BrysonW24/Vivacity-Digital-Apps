#!/bin/bash

set -e

echo "=== Starting Development Environment ==="
echo ""

# Check if Docker services are running
echo "Checking Docker services..."
if ! docker-compose -f docker-configs/docker-compose.yml ps | grep -q "Up"; then
  echo "Starting Docker services..."
  docker-compose -f docker-configs/docker-compose.yml up -d
  sleep 5
fi

# Start development servers
echo "Starting development servers..."
echo ""
echo "Web Customer:  http://localhost:3000"
echo "API Server:    http://localhost:3001"
echo "Admin Panel:   http://localhost:3002"
echo ""

pnpm dev
