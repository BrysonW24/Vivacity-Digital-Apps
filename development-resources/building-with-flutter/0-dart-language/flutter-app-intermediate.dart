// Intermediate Flutter App Development - Structured for Scalable App Development
// This repository contains advanced Flutter app-building concepts.

// Each file is a separate module covering key intermediate app development topics.

//==========================================//

// Intermediate Flutter App Development - Table of Contents
// 21_mvvm_architecture.dart - Implementing Model-View-ViewModel (MVVM) in Flutter
// 22_caching_with_hive.dart - Efficient local storage with Hive database
// 23_background_services.dart - Running background tasks with WorkManager
// 24_in_app_payments.dart - Implementing Stripe or Google Pay integration
// 25_push_notifications.dart - Firebase Cloud Messaging (FCM) notifications
// 26_animations_with_rive.dart - Adding interactive animations with Rive
// 27_multilingual_support.dart - Localizing a Flutter app with intl
// 28_unit_testing.dart - Writing and running unit tests in Flutter
// 29_integration_testing.dart - Full application testing with integration tests
// 30_performance_optimization.dart - Optimizing Flutter app performance

//==========================================//

// 21_mvvm_architecture.dart - Implementing Model-View-ViewModel (MVVM) in Flutter
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterViewModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterViewModel(),
      child: const CounterApp(),
    ),
  );
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('MVVM Counter App')),
        body: Center(
          child: Consumer<CounterViewModel>(
            builder: (context, model, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Counter: ${model.counter}', style: const TextStyle(fontSize: 24)),
                ElevatedButton(onPressed: model.increment, child: const Text('Increment')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//==========================================//

// 22_caching_with_hive.dart - Efficient local storage with Hive database
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  var dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  var box = await Hive.openBox('myBox');

  box.put('username', 'JohnDoe');
  print('Saved Username: ${box.get('username')}');
}

//==========================================//

// 23_background_services.dart - Running background tasks with WorkManager
import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print('Background Task Running');
    return Future.value(true);
  });
}

void main() {
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerOneOffTask("task-identifier", "simpleTask");
}

//==========================================//

// 24_in_app_payments.dart - Implementing Stripe or Google Pay integration
import 'package:flutter_stripe/flutter_stripe.dart';

void setupStripe() {
  Stripe.publishableKey = 'your_publishable_key';
}

//==========================================//

// 25_push_notifications.dart - Firebase Cloud Messaging (FCM) notifications
import 'package:firebase_messaging/firebase_messaging.dart';

void setupFirebaseMessaging() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission();
}

//==========================================//

// 26_animations_with_rive.dart - Adding interactive animations with Rive
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const RiveAnimationApp());
}

class RiveAnimationApp extends StatelessWidget {
  const RiveAnimationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: const RiveAnimation.asset('assets/animation.riv'),
        ),
      ),
    );
  }
}

//==========================================//

// 27_multilingual_support.dart - Localizing a Flutter app with intl
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const LocalizedApp());
}

class LocalizedApp extends StatelessWidget {
  const LocalizedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [Locale('en', ''), Locale('es', '')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        appBar: AppBar(title: const Text('Localized App')),
        body: const Center(child: Text('Hello World!')),
      ),
    );
  }
}

//==========================================//

// 28_unit_testing.dart - Writing and running unit tests in Flutter
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Simple unit test', () {
    int add(int a, int b) => a + b;
    expect(add(2, 3), 5);
  });
}

//==========================================//

// 29_integration_testing.dart - Full application testing with integration tests
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Check if button increments counter', (WidgetTester tester) async {
    await tester.pumpWidget(const CounterApp());
    expect(find.text('Counter: 0'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(find.text('Counter: 1'), findsOneWidget);
  });
}

//==========================================//

// 30_performance_optimization.dart - Optimizing Flutter app performance
import 'package:flutter/material.dart';

void main() {
  runApp(const OptimizedApp());
}

class OptimizedApp extends StatelessWidget {
  const OptimizedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Optimized App')),
        body: const OptimizedWidget(),
      ),
    );
  }
}

class OptimizedWidget extends StatelessWidget {
  const OptimizedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) => ListTile(title: Text('Item $index')),
    );
  }
}
