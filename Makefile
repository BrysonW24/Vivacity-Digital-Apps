.PHONY: help setup clean build test deploy run docs

# Default target
help:
	@echo "Vivacity Digital Platform - Development Commands"
	@echo "=================================================="
	@echo "setup              - Install dependencies and initialize project"
	@echo "clean              - Clean build artifacts and caches"
	@echo "build              - Build Flutter apps (debug)"
	@echo "build-release      - Build Flutter apps (release)"
	@echo "build-android      - Build Android APK"
	@echo "build-ios          - Build iOS app"
	@echo "test               - Run all tests"
	@echo "test-unit          - Run unit tests only"
	@echo "test-widget        - Run widget tests only"
	@echo "test-coverage      - Run tests with coverage"
	@echo "lint               - Run linting checks"
	@echo "lint-fix           - Fix linting issues"
	@echo "format             - Format code"
	@echo "validate           - Validate code quality"
	@echo "run                - Run active project (journal-app)"
	@echo "docs               - Generate documentation"
	@echo "docker-build       - Build Docker image"
	@echo "docker-run         - Run Docker container"
	@echo "docker-up          - Start docker-compose services"
	@echo "docker-down        - Stop docker-compose services"
	@echo "pub-upgrade        - Upgrade Flutter dependencies"
	@echo "pub-get            - Get Flutter dependencies"
	@echo ""

# Setup and Installation
setup:
	@echo "Setting up Vivacity Digital Platform..."
	flutter pub global activate fvm
	fvm install 3.19.0
	fvm default 3.19.0
	pub get
	@echo " Setup complete"

pub-get:
	@echo "Getting Flutter dependencies..."
	flutter pub get
	@echo " Dependencies installed"

pub-upgrade:
	@echo "Upgrading Flutter dependencies..."
	flutter pub upgrade
	@echo " Dependencies upgraded"

# Cleanup
clean:
	@echo "Cleaning build artifacts..."
	flutter clean
	find . -name ".dart_tool" -type d -exec rm -rf {} + 2>/dev/null || true
	find . -name "build" -type d -exec rm -rf {} + 2>/dev/null || true
	@echo " Cleanup complete"

# Building
build:
	@echo "Building Flutter app (debug)..."
	flutter build apk --debug

build-release:
	@echo "Building Flutter app (release)..."
	flutter build apk --release

build-android:
	@echo "Building Android APK..."
	cd client-projects/active/journal-app && flutter build apk --release

build-ios:
	@echo "Building iOS app..."
	cd client-projects/active/journal-app && flutter build ios --release

# Testing
test:
	@echo "Running all tests..."
	flutter test --coverage

test-unit:
	@echo "Running unit tests..."
	flutter test test/unit --no-pub

test-widget:
	@echo "Running widget tests..."
	flutter test test/widget --no-pub

test-coverage:
	@echo "Running tests with coverage..."
	flutter test --coverage
	@echo "Coverage report generated in coverage/lcov.info"

# Code Quality
lint:
	@echo "Running linting checks..."
	flutter analyze

lint-fix:
	@echo "Fixing linting issues..."
	dart fix --apply

format:
	@echo "Formatting code..."
	dart format --line-length 120 lib/ test/

validate: lint format
	@echo " Code validation complete"

# Running
run:
	@echo "Running journal-app..."
	cd client-projects/active/journal-app && flutter run

run-dev:
	@echo "Running app in development mode..."
	flutter run --dart-define=ENV=development

run-prod:
	@echo "Running app in production mode..."
	flutter run --dart-define=ENV=production

# Documentation
docs:
	@echo "Generating documentation..."
	@echo "Documentation commands would go here"
	@echo "Consider using dartdoc or similar tools"

# Docker
docker-build:
	@echo "Building Docker image..."
	docker build -t vivacity-digital:latest .

docker-run:
	@echo "Running Docker container..."
	docker run -it vivacity-digital:latest

docker-up:
	@echo "Starting docker-compose services..."
	docker-compose -p vivacity-digital up -d
	@echo " Services started"

docker-down:
	@echo "Stopping docker-compose services..."
	docker-compose -p vivacity-digital down
	@echo " Services stopped"

# Deployment
deploy-staging:
	@echo "Deploying to staging..."
	@echo "Deployment scripts would go here"

deploy-production:
	@echo "Deploying to production..."
	@echo "Deployment scripts would go here"

.DEFAULT_GOAL := help
