# Integration Testing in Flutter

## Overview

Integration tests verify complete user workflows by running the full app on a real device or emulator. They test how multiple widgets work together.

## Setup

```yaml
# pubspec.yaml
dev_dependencies:
  integration_test:
    sdk: flutter
  flutter_test:
    sdk: flutter
```

Create integration test folder:
```
your_app/
  integration_test/
    app_test.dart
  lib/
  test/
```

## Basic Integration Test

```dart
// integration_test/app_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:your_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('complete user flow', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify initial screen
      expect(find.text('Welcome'), findsOneWidget);

      // Tap login button
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // Enter credentials
      await tester.enterText(
        find.byKey(Key('email_field')),
        'user@example.com',
      );
      await tester.enterText(
        find.byKey(Key('password_field')),
        'password123',
      );

      // Submit
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Verify logged in
      expect(find.text('Dashboard'), findsOneWidget);
    });
  });
}
```

## Testing User Workflows

```dart
testWidgets('create and save journal entry', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  // Navigate to editor
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle();

  // Enter title
  await tester.enterText(
    find.byKey(Key('title_field')),
    'My Test Entry',
  );

  // Enter content
  await tester.enterText(
    find.byKey(Key('content_field')),
    'This is test content',
  );

  // Select mood
  await tester.tap(find.text('😊'));
  await tester.pump();

  // Save entry
  await tester.tap(find.byIcon(Icons.save));
  await tester.pumpAndSettle();

  // Verify entry appears in list
  expect(find.text('My Test Entry'), findsOneWidget);
});
```

## Testing Navigation

```dart
testWidgets('navigate through app', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  // Tap on first tab
  await tester.tap(find.text('Entries'));
  await tester.pumpAndSettle();
  expect(find.byType(EntriesScreen), findsOneWidget);

  // Tap on second tab
  await tester.tap(find.text('Calendar'));
  await tester.pumpAndSettle();
  expect(find.byType(CalendarScreen), findsOneWidget);

  // Navigate back
  await tester.pageBack();
  await tester.pumpAndSettle();
  expect(find.byType(EntriesScreen), findsOneWidget);
});
```

## Testing Scrolling

```dart
testWidgets('scroll to find item', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  // Scroll until item is visible
  await tester.scrollUntilVisible(
    find.text('Item 50'),
    500.0,
    scrollable: find.byType(Scrollable).first,
  );

  // Verify item is now visible
  expect(find.text('Item 50'), findsOneWidget);

  // Tap the item
  await tester.tap(find.text('Item 50'));
  await tester.pumpAndSettle();
});
```

## Testing Forms

```dart
testWidgets('complete form submission', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  // Fill out form fields
  await tester.enterText(find.byKey(Key('name')), 'John Doe');
  await tester.enterText(find.byKey(Key('email')), 'john@example.com');
  await tester.enterText(find.byKey(Key('phone')), '555-1234');

  // Select dropdown
  await tester.tap(find.byKey(Key('country')));
  await tester.pumpAndSettle();
  await tester.tap(find.text('United States').last);
  await tester.pumpAndSettle();

  // Toggle switch
  await tester.tap(find.byKey(Key('notifications_toggle')));
  await tester.pump();

  // Submit form
  await tester.tap(find.text('Submit'));
  await tester.pumpAndSettle();

  // Verify success message
  expect(find.text('Form submitted successfully'), findsOneWidget);
});
```

## Testing Dialogs

```dart
testWidgets('show and dismiss dialog', (tester) async {
  app.main();
  await tester.pumpAndSettle();

  // Trigger dialog
  await tester.tap(find.text('Delete'));
  await tester.pumpAndSettle();

  // Verify dialog appears
  expect(find.text('Are you sure?'), findsOneWidget);

  // Dismiss dialog
  await tester.tap(find.text('Cancel'));
  await tester.pumpAndSettle();

  // Verify dialog is gone
  expect(find.text('Are you sure?'), findsNothing);
});
```

## Testing with Mock Data

```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    // Initialize test database
    await setupTestDatabase();
  });

  tearDownAll(() async {
    // Cleanup
    await clearTestDatabase();
  });

  testWidgets('load data from mock database', (tester) async {
    // Insert test data
    await insertTestEntries();

    app.main();
    await tester.pumpAndSettle();

    // Verify test data appears
    expect(find.text('Test Entry 1'), findsOneWidget);
    expect(find.text('Test Entry 2'), findsOneWidget);
  });
}
```

## Performance Testing

```dart
import 'package:integration_test/integration_test.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('measure app startup time', (tester) async {
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.benchmarkLive;

    await binding.watchPerformance(() async {
      app.main();
      await tester.pumpAndSettle();
    });

    // Results saved to build/test_results.json
  });
}
```

## Run Integration Tests

```bash
# Android
flutter test integration_test/app_test.dart

# iOS
flutter test integration_test/app_test.dart -d ios

# Chrome
flutter test integration_test/app_test.dart -d chrome

# All devices
flutter test integration_test
```

## Run on Specific Device

```bash
# List devices
flutter devices

# Run on specific device
flutter test integration_test/app_test.dart -d <device_id>
```

## Continuous Integration

```yaml
# .github/workflows/integration_test.yml
name: Integration Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter test integration_test
```

## Best Practices

1. **Test complete user workflows**
2. **Use real data when possible**
3. **Test on multiple platforms**
4. **Clean up test data**
5. **Use descriptive test names**
6. **Test error scenarios**
7. **Keep tests independent**
8. **Use realistic delays (pumpAndSettle)**

## Common Patterns

```dart
// Wait for network request
await tester.runAsync(() async {
  await Future.delayed(Duration(seconds: 2));
});
await tester.pumpAndSettle();

// Screenshot for debugging
await binding.takeScreenshot('screenshot_name');

// Test deep links
await tester.tap(find.text('Open Link'));
await tester.pumpAndSettle();
expect(find.byType(DetailScreen), findsOneWidget);
```

---

**Resources:**
- [Integration Testing Documentation](https://docs.flutter.dev/testing/integration-tests)
- [Integration Test Package](https://pub.dev/packages/integration_test)
- [CI/CD for Flutter](https://docs.flutter.dev/deployment/cd)
