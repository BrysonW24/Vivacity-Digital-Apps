# Debugging & Testing - Vivacity Digital Apps

## Overview

This directory contains all debugging tools, testing frameworks, and quality assurance documentation for Flutter projects.

## 📂 Directory Structure

```
debugging-testing/
├── tools/                     # Debugging & IDE Tools
│   ├── devtools_setup.md
│   ├── vs_code_debugging.md
│   ├── android_studio_debug.md
│   └── logging_setup.md
│
├── error-handling/            # Error Tracking
│   ├── flutter_errors.md
│   ├── firebase_crashlytics.md
│   ├── sentry_integration.md
│   └── try_catch_best.md
│
├── performance/               # Performance Optimization
│   └── performance_tips.md
│
├── qa-testing/                # Manual QA Checklists
│   ├── readme.md
│   ├── micro-tier-tests.md           (15-20 min)
│   ├── standard-tier-tests.md        (30-45 min)
│   ├── premium-tier-tests.md         (60-90 min)
│   ├── automated-unit-tests-guide.md
│   ├── automated-widget-tests-guide.md
│   └── automated-integration-tests-guide.md
│
├── automated-tests/           # Test Framework & Templates
│   ├── readme.md                     # Setup instructions
│   ├── templates/                    # Copy these to projects
│   │   ├── model_test_template.dart
│   │   ├── widget_test_template.dart
│   │   └── integration_test_template.dart
│   ├── examples/                     # Working examples
│   │   └── journal-app-tests/       # Complete test suite
│   └── runners/                      # Test execution scripts
│       ├── run-tests.bat            # Windows
│       └── run-tests.sh             # Mac/Linux
│
└── readme.md                  # This file
```

## 🎯 Quick Start

### For Developers

**1. Set Up Debugging**
- [Flutter DevTools Setup](tools/devtools_setup.md)
- [VS Code Debugging](tools/vs_code_debugging.md)

**2. Set Up Automated Tests**
- Read [automated-tests/readme.md](automated-tests/readme.md)
- Copy templates to your project
- Run `flutter test`

**3. Handle Errors Properly**
- [Common Flutter Errors](error-handling/flutter_errors.md)
- [Try-Catch Best Practices](error-handling/try_catch_best.md)

### For QA Testers

**1. Choose Test Tier**
- Simple app → [micro-tier-tests.md](qa-testing/micro-tier-tests.md)
- Standard app → [standard-tier-tests.md](qa-testing/standard-tier-tests.md)
- Enterprise app → [premium-tier-tests.md](qa-testing/premium-tier-tests.md)

**2. Run Manual Tests**
- Follow checklist step-by-step
- Document issues found
- Track until resolved

**3. Verify Automated Tests**
- Ensure all tests pass
- Check coverage reports

## 🚀 Setting Up Tests for New Project

```bash
# 1. Navigate to project
cd your_project/

# 2. Add test dependencies to pubspec.yaml
# (See automated-tests/readme.md for details)

# 3. Create test folders
mkdir -p test/models test/utils test/widgets integration_test

# 4. Copy test templates
cp ../debugging-testing/automated-tests/templates/*.dart test/

# 5. Copy test runner
cp ../debugging-testing/automated-tests/runners/run-tests.* ./

# 6. Install dependencies
flutter pub get

# 7. Run tests
flutter test
```

## 📊 Quality Standards

### Test Coverage Requirements
- Models: 100%
- Utilities: 100%
- Repositories: 80%
- Providers: 80%
- Widgets: 70%
- **Overall: 75%** (minimum)

### Manual QA Pass Criteria
| Tier | Critical | Major | Minor |
|------|----------|-------|-------|
| Micro | 0 | ≤2 | ≤5 |
| Standard | 0 | ≤3 | ≤10 |
| Premium | 0 | 0 | ≤5 |

## 🔧 Common Commands

```bash
# Run all automated tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test
flutter test test/models/user_test.dart

# Run integration tests
flutter test integration_test/ -d windows

# Check test coverage
genhtml coverage/lcov.info -o coverage/html
```

## 📚 Documentation

### Debugging
- [DevTools](tools/devtools_setup.md) - Performance profiling
- [VS Code](tools/vs_code_debugging.md) - Breakpoints, debugging
- [Logging](tools/logging_setup.md) - Proper logging practices

### Error Handling
- [Common Errors](error-handling/flutter_errors.md) - Solutions to frequent issues
- [Crashlytics](error-handling/firebase_crashlytics.md) - Production monitoring
- [Sentry](error-handling/sentry_integration.md) - Error tracking

### Testing
- [Unit Tests](qa-testing/automated-unit-tests-guide.md)
- [Widget Tests](qa-testing/automated-widget-tests-guide.md)
- [Integration Tests](qa-testing/automated-integration-tests-guide.md)
- [Test Framework](automated-tests/readme.md)

## 🎓 Workflow

### Development
1. Write code
2. Write unit tests
3. Debug with DevTools
4. Fix issues
5. Run all tests

### Pre-Commit
1. Run `flutter test`
2. Fix any failures
3. Check coverage
4. Commit code

### Pre-Release
1. Run automated tests
2. Run manual QA checklist
3. Check performance
4. Verify error tracking
5. Deploy

## 🆘 Getting Help

**Internal:**
- Check relevant docs in this directory
- Review working examples
- Ask team for help

**External:**
- [Flutter Docs](https://docs.flutter.dev/)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- [Flutter Discord](https://discord.gg/flutter)

---

**Key Files:**
- [Test Framework Setup](automated-tests/readme.md) - Start here for testing
- [QA Overview](qa-testing/readme.md) - Manual testing process
- [Debugging Tools](tools/) - IDE setup and debugging

**Version:** 2.0.0
**Last Updated:** January 30, 2025
