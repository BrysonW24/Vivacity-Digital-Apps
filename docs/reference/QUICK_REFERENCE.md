# Vivacity Digital Platform - Quick Reference Guide

## Essential Commands

### Setup & Dependencies
```bash
make setup              # Complete setup (install Flutter, pub get, npm install)
make pub-get            # Get Flutter dependencies only
make pub-upgrade        # Upgrade all Flutter packages
```

### Development
```bash
make run                # Run journal-app in debug mode
make run-dev            # Run with development environment variables
make run-prod           # Run with production environment variables
make format             # Format all code
make lint               # Check code quality
make lint-fix           # Auto-fix linting issues
make validate           # Full validation (lint + format)
```

### Testing
```bash
make test               # Run all tests with coverage
make test-unit          # Unit tests only
make test-widget        # Widget tests only
make test-coverage      # Show coverage report
```

### Building
```bash
make build              # Build debug APK
make build-release      # Build release APK
make build-android      # Full Android build
make build-ios          # Full iOS build
```

### Docker & Infrastructure
```bash
make docker-up          # Start all services
make docker-down        # Stop all services
make docker-build       # Build Docker image
make docker-run         # Run Docker container
```

### Cleanup
```bash
make clean              # Remove build artifacts and caches
```

---

## Project Structure Quick Map

```
📦 Vivacity-Digital-Apps/
├── 📱 client-projects/active/journal-app/    Production app (run: make run)
├── 📚 examples/                               Learning examples
├── 📦 templates/                              Reusable code templates
├── 🔧 Configuration Files
│   ├── .env.example                           Copy to .env for secrets
│   ├── vivacity.config.js                     App configuration
│   ├── docker-compose.yml                     Services (DB, Redis, etc.)
│   ├── Makefile                               Development commands
│   └── package.json                           Node.js tools
├── 🚀 CI/CD
│   └── .github/workflows/                     GitHub Actions pipelines
├── 📖 Documentation
│   ├── README.md                              Start here
│   ├── CLEANUP_SUMMARY.md                     What was done
│   ├── GIT_BRANCHING_STRATEGY_VDA.MD          Git workflow
│   ├── SECURITY.md                            Security guidelines
│   └── REPOSITORY_STRUCTURE_GUIDELINES_VDA.md Organization rules
└── 📁 Other directories
    ├── debugging-testing/                     Testing guides & tools
    ├── security/                              Security documentation
    ├── onboarding/                            Team setup guides
    └── automation/                            Scripts & tools
```

---

## Git Workflow

### Create a Feature
```bash
git checkout development
git pull origin development
git checkout -b feature/your-feature-name

# Make changes
git add .
git commit -m "feat: description of changes"
git push origin feature/your-feature-name

# Create Pull Request → test → development → main
```

### Release a Version
```bash
# On main branch
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0

# Automatically triggers:
# 1. Create GitHub release
# 2. Build Android APK → Google Play
# 3. Build iOS app → TestFlight
```

### Branches
- `main` - Production (release only)
- `development` - Development integration
- `test` - QA and testing
- `feature/*` - Feature branches
- `bugfix/*` - Bug fix branches

---

## Environment Setup

### Initial Setup
```bash
cp .env.example .env
# Edit .env and fill in:
FIREBASE_PROJECT_ID=your-project
FIREBASE_API_KEY=your-key
AWS_ACCESS_KEY_ID=your-key
AWS_SECRET_ACCESS_KEY=your-secret
# ... etc
```

### Start Services
```bash
make docker-up

# Services available at:
# - Database: localhost:5432
# - Redis: localhost:6379
# - Nginx: localhost:80, localhost:443
# - Admin UI: localhost:8080 (development only)
```

---

## Code Standards

### Before Committing
```bash
# 1. Format code
dart format --line-length 120 .

# 2. Fix issues
dart fix --apply

# 3. Check quality
flutter analyze

# 4. Run tests
flutter test --coverage

# 5. All in one
make validate
```

### Requirements
- Minimum 80% test coverage
- No analyzer warnings
- Formatted with `dart format`
- Clear commit messages
- Updated documentation if needed

---

## Debugging

### Enable DevTools
```bash
flutter pub global activate devtools
flutter pub global run devtools
# Opens http://localhost:9100
```

### View Logs
```bash
flutter logs              # Real-time app logs
flutter logs -f          # Follow logs
flutter logs | grep TAG  # Filter logs
```

### Debug App
```bash
flutter run --debug      # Debug mode
flutter run -v           # Verbose output
flutter attach           # Attach to running app
```

### Analyze Issues
```bash
flutter analyze          # Code analysis
dart fix --dry-run       # See potential fixes
dart format -h           # Format options
```

---

## Testing

### Run Tests
```bash
# All tests
flutter test

# Specific test
flutter test test/unit/models/user_model_test.dart

# With coverage
flutter test --coverage

# Watch mode
flutter test --watch
```

### Generate Coverage Report
```bash
# Generate HTML report
genhtml -o coverage/html coverage/lcov.info
open coverage/html/index.html
```

---

## Deployment

### To Development
```bash
git checkout development
git pull origin development
# Tests run automatically in CI/CD
# App available for internal testing
```

### To Production (Full Release)
```bash
# 1. Update version in pubspec.yaml
# 2. Commit changes
# 3. Tag release
git tag -a v1.0.0 -m "Version 1.0.0"
git push origin v1.0.0

# Automatically:
# - Tests run in CI
# - Builds APK and AAB
# - Uploads to Google Play (internal track)
# - Uploads to TestFlight
# - Creates GitHub release
```

---

## Common Issues

### "flutter: command not found"
```bash
# Add Flutter to PATH
export PATH="$PATH:~/flutter/bin"
# Or use FVM (Flutter Version Manager)
make setup
```

### Build fails with dependency errors
```bash
make clean
make pub-get
make build
```

### Tests fail suddenly
```bash
# Clear cache and rebuild
flutter clean
flutter pub get
flutter test
```

### Docker services won't start
```bash
# Check logs
docker-compose logs postgres
docker-compose logs redis

# Restart services
make docker-down
make docker-up
```

---

## Useful Links

- **Flutter Docs**: https://flutter.dev/docs
- **Dart Docs**: https://dart.dev
- **Firebase Docs**: https://firebase.google.com/docs
- **GitHub Actions**: https://docs.github.com/en/actions
- **Docker Docs**: https://docs.docker.com

---

## Getting Help

1. **Check documentation**
   - README.md - Start here
   - CLEANUP_SUMMARY.md - What was done
   - GIT_BRANCHING_STRATEGY_VDA.MD - Git workflow
   - SECURITY.md - Security issues

2. **Search issues**
   - GitHub Issues tab
   - GitHub Discussions

3. **Debug locally**
   - Use `flutter logs -f`
   - Use Flutter DevTools
   - Check `.env` configuration

---

**Quick Tip:** Type `make help` to see all available commands anytime!
