# Widget Testing in Flutter

## Overview

Widget tests verify that UI components render correctly and respond to user interactions. They test widgets in isolation without running on a real device.

## Setup

```yaml
# pubspec.yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
```

## Basic Widget Test

```dart
// lib/widgets/counter_widget.dart
class CounterWidget extends StatefulWidget {
  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Count: $_counter', key: Key('counter_text')),
        ElevatedButton(
          key: Key('increment_button'),
          onPressed: _increment,
          child: Text('Increment'),
        ),
      ],
    );
  }
}

// test/widgets/counter_widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Counter starts at 0', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CounterWidget(),
        ),
      ),
    );

    expect(find.text('Count: 0'), findsOneWidget);
    expect(find.text('Count: 1'), findsNothing);
  });

  testWidgets('Increment button increases counter', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CounterWidget(),
        ),
      ),
    );

    // Find and tap the button
    await tester.tap(find.byKey(Key('increment_button')));
    await tester.pump();  // Rebuild the widget

    expect(find.text('Count: 1'), findsOneWidget);

    // Tap again
    await tester.tap(find.byKey(Key('increment_button')));
    await tester.pump();

    expect(find.text('Count: 2'), findsOneWidget);
  });
}
```

## Finding Widgets

```dart
// Find by text
find.text('Hello');

// Find by key
find.byKey(Key('my_widget'));

// Find by type
find.byType(ElevatedButton);

// Find by icon
find.byIcon(Icons.add);

// Find by widget instance
find.byWidget(myWidget);

// Descendant finder
find.descendant(
  of: find.byType(Container),
  matching: find.byType(Text),
);

// Ancestor finder
find.ancestor(
  of: find.text('Child'),
  matching: find.byType(Container),
);
```

## User Interactions

```dart
// Tap
await tester.tap(find.byIcon(Icons.add));
await tester.pump();

// Long press
await tester.longPress(find.text('Item'));
await tester.pump();

// Drag
await tester.drag(find.byType(ListView), Offset(0, -300));
await tester.pump();

// Enter text
await tester.enterText(find.byType(TextField), 'Hello');
await tester.pump();

// Scroll
await tester.scrollUntilVisible(
  find.text('Item 50'),
  500.0,
  scrollable: find.byType(Scrollable).first,
);
```

## Pump Methods

```dart
// Rebuild widget immediately
await tester.pump();

// Advance time and rebuild
await tester.pump(Duration(seconds: 1));

// Wait for all animations
await tester.pumpAndSettle();

// Pump multiple frames
await tester.pumpAndSettle(Duration(milliseconds: 100));
```

## Testing Async Widgets

```dart
testWidgets('FutureBuilder shows loading then data', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: FutureBuilder<String>(
        future: Future.delayed(
          Duration(seconds: 1),
          () => 'Hello',
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return Text(snapshot.data ?? '');
        },
      ),
    ),
  );

  // Initially shows loading
  expect(find.byType(CircularProgressIndicator), findsOneWidget);
  expect(find.text('Hello'), findsNothing);

  // Wait for future to complete
  await tester.pumpAndSettle();

  // Now shows data
  expect(find.byType(CircularProgressIndicator), findsNothing);
  expect(find.text('Hello'), findsOneWidget);
});
```

## Testing Navigation

```dart
testWidgets('Button navigates to detail screen', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: HomeScreen(),
      routes: {
        '/detail': (context) => DetailScreen(),
      },
    ),
  );

  // Tap navigation button
  await tester.tap(find.text('View Details'));
  await tester.pumpAndSettle();

  // Verify navigation occurred
  expect(find.byType(DetailScreen), findsOneWidget);
  expect(find.byType(HomeScreen), findsNothing);
});
```

## Testing with Provider

```dart
testWidgets('Updates when provider changes', (WidgetTester tester) async {
  final provider = CounterProvider();

  await tester.pumpWidget(
    ChangeNotifierProvider.value(
      value: provider,
      child: MaterialApp(
        home: CounterScreen(),
      ),
    ),
  );

  expect(find.text('Count: 0'), findsOneWidget);

  // Trigger provider change
  provider.increment();
  await tester.pump();

  expect(find.text('Count: 1'), findsOneWidget);
});
```

## Golden Tests

```dart
testWidgets('matches golden file', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MyWidget(),
    ),
  );

  await expectLater(
    find.byType(MyWidget),
    matchesGoldenFile('goldens/my_widget.png'),
  );
});
```

## Run Tests

```bash
# Run all widget tests
flutter test

# Run specific test file
flutter test test/widgets/counter_widget_test.dart

# Update golden files
flutter test --update-goldens
```

## Best Practices

1. **Use keys for important widgets**
2. **Test user interactions**
3. **Test different states**
4. **Use pumpAndSettle() for animations**
5. **Mock dependencies with Provider**
6. **Test accessibility**

---

**Resources:**
- [Widget Testing Documentation](https://docs.flutter.dev/testing/overview#widget-tests)
- [Flutter Test Package](https://api.flutter.dev/flutter/flutter_test/flutter_test-library.html)
