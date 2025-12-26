# Journal App Test Suite

## Overview

This directory contains comprehensive tests for the Journal App, including unit tests, widget tests, and integration tests.

## Test Structure

```
test/
├── models/
│   └── journal_entry_test.dart          # Unit tests for JournalEntry, Mood, Category, Tag
├── utils/
│   └── date_formatter_test.dart         # Unit tests for DateFormatter utility
├── widgets/
│   └── entry_editor_widget_test.dart    # Widget tests for EntryEditorScreen
└── README.md                            # This file

integration_test/
└── app_test.dart                        # End-to-end integration tests
```

## Running Tests

### Run All Tests

```bash
# Run all unit and widget tests
flutter test

# Run with coverage
flutter test --coverage

# View coverage report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
```

### Run Specific Test Files

```bash
# Run model tests only
flutter test test/models/journal_entry_test.dart

# Run utility tests only
flutter test test/utils/date_formatter_test.dart

# Run widget tests only
flutter test test/widgets/entry_editor_widget_test.dart
```

### Run Integration Tests

```bash
# Run on connected device or emulator
flutter test integration_test/app_test.dart

# Run on specific device
flutter test integration_test/app_test.dart -d windows
flutter test integration_test/app_test.dart -d chrome
flutter test integration_test/app_test.dart -d <device-id>
```

## Test Coverage

### Unit Tests (`test/models/`, `test/utils/`)

**What they test:**
- Model creation and validation (JournalEntry, Category, Tag, Mood)
- Data serialization (toMap/fromMap)
- Model methods (copyWith, equality, toString)
- Utility functions (DateFormatter)
- Edge cases and error conditions

**Coverage targets:**
- Models: 100%
- Utilities: 100%

### Widget Tests (`test/widgets/`)

**What they test:**
- Widget rendering
- User interactions (taps, text input)
- State changes
- Navigation
- Visual regression (using golden files)

**Coverage targets:**
- Critical UI components: 80%+
- Forms and inputs: 90%+

### Integration Tests (`integration_test/`)

**What they test:**
- Complete user workflows
- Database operations
- Navigation flows
- Real-world scenarios

**Test scenarios:**
1. **Create, View, Edit, Delete Entry**: Complete CRUD workflow
2. **Search Functionality**: Search and filter entries
3. **Favorite Toggle**: Mark/unmark favorites
4. **Tab Navigation**: Switch between different views
5. **Empty States**: Display when no data

## Test Best Practices

### Writing Unit Tests

```dart
group('MyClass', () {
  test('does something correctly', () {
    // Arrange
    final input = 'test';

    // Act
    final result = myFunction(input);

    // Assert
    expect(result, expectedValue);
  });
});
```

### Writing Widget Tests

```dart
testWidgets('displays text correctly', (tester) async {
  // Build widget
  await tester.pumpWidget(MyWidget());

  // Find widgets
  final textFinder = find.text('Hello');

  // Verify
  expect(textFinder, findsOneWidget);

  // Interact
  await tester.tap(find.byType(ElevatedButton));
  await tester.pump();

  // Verify state change
  expect(find.text('Clicked'), findsOneWidget);
});
```

### Writing Integration Tests

```dart
testWidgets('complete user flow', (tester) async {
  // Start app
  app.main();
  await tester.pumpAndSettle();

  // Perform user actions
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();

  await tester.enterText(find.byKey(Key('input')), 'Test');
  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();

  // Verify results
  expect(find.text('Test'), findsOneWidget);
});
```

## Continuous Integration

### GitHub Actions Example

```yaml
name: Tests

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
        with:
          file: coverage/lcov.info
```

## Debugging Tests

### Enable Debugging

```dart
testWidgets('my test', (tester) async {
  // Enable debugging
  debugDefaultTargetPlatformOverride = TargetPlatform.android;

  await tester.pumpWidget(MyApp());

  // Print widget tree
  debugDumpApp();

  // Print render tree
  debugDumpRenderTree();

  // Take screenshot
  await tester.takeScreenshot('my_test');
});
```

### Common Issues

**Issue: Widget not found**
```dart
// Wait for animations
await tester.pumpAndSettle();

// Or pump specific duration
await tester.pump(Duration(seconds: 1));
```

**Issue: Async operation not completed**
```dart
// Use runAsync for async operations
await tester.runAsync(() async {
  await Future.delayed(Duration(seconds: 2));
});
await tester.pumpAndSettle();
```

**Issue: Provider not found**
```dart
// Wrap widget with providers
await tester.pumpWidget(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => MyProvider()),
    ],
    child: MaterialApp(home: MyWidget()),
  ),
);
```

## Test Utilities

Create test helpers in `test/helpers/`:

```dart
// test/helpers/test_helpers.dart
Widget createTestableWidget(Widget child) {
  return MaterialApp(
    home: Scaffold(body: child),
  );
}

JournalEntry createMockEntry({String? title}) {
  return JournalEntry(
    title: title ?? 'Mock Entry',
    content: 'Mock content',
  );
}
```

## Performance Testing

### Measure Widget Build Time

```dart
testWidgets('builds quickly', (tester) async {
  final stopwatch = Stopwatch()..start();

  await tester.pumpWidget(MyComplexWidget());

  stopwatch.stop();
  expect(stopwatch.elapsedMilliseconds, lessThan(100));
});
```

### Measure Scroll Performance

```dart
testWidgets('scrolls smoothly', (tester) async {
  await tester.pumpWidget(MyListView());

  await tester.drag(find.byType(ListView), Offset(0, -500));
  await tester.pumpAndSettle();

  // Verify no jank
});
```

## Coverage Requirements

| Component | Target Coverage | Current |
|-----------|----------------|---------|
| Models | 100% | TBD |
| Utilities | 100% | TBD |
| Repositories | 80% | TBD |
| Providers | 80% | TBD |
| Widgets/Screens | 70% | TBD |
| Overall | 75% | TBD |

## Running Tests in CI/CD

### Pre-commit Hook

```bash
# .git/hooks/pre-commit
#!/bin/sh
flutter test
if [ $? -ne 0 ]; then
  echo "Tests failed. Commit aborted."
  exit 1
fi
```

### Pre-push Hook

```bash
# .git/hooks/pre-push
#!/bin/sh
flutter test --coverage
if [ $? -ne 0 ]; then
  echo "Tests failed. Push aborted."
  exit 1
fi
```

## Resources

- [Flutter Testing Documentation](https://docs.flutter.dev/testing)
- [Widget Testing Guide](https://docs.flutter.dev/cookbook/testing/widget/introduction)
- [Integration Testing Guide](https://docs.flutter.dev/testing/integration-tests)
- [Mockito Documentation](https://pub.dev/packages/mockito)

---

**Last Updated:** 2025-01-30
**Maintainer:** Vivacity Digital Development Team
