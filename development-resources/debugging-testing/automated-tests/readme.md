# Automated Testing Framework

## Overview

This folder contains reusable test templates, examples, and runners for setting up automated testing in Flutter projects.

## Structure

```
automated-tests/
├── templates/          # Test templates to copy into projects
├── examples/           # Working test examples from real projects
├── runners/            # Test execution scripts
└── readme.md          # This file
```

## Quick Setup for New Project

### 1. Add Test Dependencies

Add to your project's `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  integration_test:
    sdk: flutter
  mockito: ^5.4.0
  build_runner: ^2.4.0
  fake_async: ^1.3.1
```

### 2. Create Test Folders

```bash
cd your_project/
mkdir -p test/models test/utils test/widgets
mkdir -p integration_test
```

### 3. Copy Templates

```bash
# Copy test templates
cp debugging-testing/automated-tests/templates/*.dart your_project/test/

# Copy test runner
cp debugging-testing/automated-tests/runners/run-tests.* your_project/
```

### 4. Customize Templates

1. Replace `[ModelName]` with your actual model name
2. Replace `[WidgetName]` with your actual widget name
3. Uncomment and update import paths
4. Fill in actual test logic

### 5. Run Tests

```bash
cd your_project/
flutter pub get
flutter test
```

## Test Templates

### Model Test Template
**File:** `templates/model_test_template.dart`
**Use for:** Testing data models, serialization, business logic

**Copy to:** `your_project/test/models/your_model_test.dart`

### Widget Test Template
**File:** `templates/widget_test_template.dart`
**Use for:** Testing UI components, user interactions

**Copy to:** `your_project/test/widgets/your_widget_test.dart`

### Integration Test Template
**File:** `templates/integration_test_template.dart`
**Use for:** Testing complete user workflows end-to-end

**Copy to:** `your_project/integration_test/app_test.dart`

## Working Examples

See `examples/journal-app-tests/` for complete working test suite from the journal app:
- Model tests (JournalEntry, Mood, Category, Tag)
- Utility tests (DateFormatter)
- Widget tests (EntryEditorScreen)
- Integration tests (CRUD workflows)

## Test Runners

### Windows: `run-tests.bat`
Double-click or run from command line:
```cmd
run-tests.bat
```

### Mac/Linux: `run-tests.sh`
```bash
chmod +x run-tests.sh
./run-tests.sh
```

## Best Practices

### Writing Tests

1. **Follow AAA Pattern**
   - Arrange: Set up test data
   - Act: Perform the action
   - Assert: Verify the result

2. **One Test, One Thing**
   - Each test should verify one specific behavior
   - Use descriptive test names

3. **Keep Tests Independent**
   - Tests should not depend on each other
   - Each test should clean up after itself

4. **Test Edge Cases**
   - Empty values, null, very large values
   - Boundary conditions
   - Error scenarios

### Running Tests

```bash
# All tests
flutter test

# Specific file
flutter test test/models/user_test.dart

# With coverage
flutter test --coverage

# Integration tests (requires device)
flutter test integration_test/ -d windows
```

### Debugging Tests

```bash
# Verbose output
flutter test --verbose

# Debug specific test
flutter test test/models/user_test.dart --name "creates user"
```

## Test Coverage Targets

| Component | Target | Critical |
|-----------|--------|----------|
| Models | 100% | Yes |
| Utilities | 100% | Yes |
| Repositories | 80% | Yes |
| Providers | 80% | No |
| Widgets | 70% | No |
| Overall | 75% | Yes |

## CI/CD Integration

### GitHub Actions Example

```yaml
name: Run Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v3
```

## Troubleshooting

### "Package not found" errors
```bash
flutter pub get
flutter clean
flutter pub get
```

### Tests won't run
```bash
# Check Flutter installation
flutter doctor

# Verify test files
flutter test --list-tests
```

### Widget tests failing
- Ensure `flutter_test` is imported
- Use `testWidgets` instead of `test`
- Call `await tester.pumpAndSettle()` after actions

---

**Note:** These templates are meant to be copied into actual Flutter projects. They won't work standalone in this directory because there's no `pubspec.yaml` or Flutter SDK here.

**For working examples, see:** `examples/journal-app-tests/`
