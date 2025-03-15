// Intermediate Flutter - Structured for Scalable App Development
// This repository contains intermediate-level Flutter concepts.

// Each file is a separate module covering key intermediate Flutter topics.

//==========================================//

// Intermediate Flutter - Table of Contents
// 09_state_management_overview.md - Overview of state management solutions
// 10_provider_state_management.dart - Implementing state management with Provider
// 11_bloc_state_management.dart - Using BLoC for reactive state
// 12_inherited_widget.dart - Understanding InheritedWidget
// 13_theme_customization.dart - Advanced theming with ThemeData and custom fonts
// 14_animations.dart - Implicit and explicit animations in Flutter
// 15_custom_painting.dart - Creating custom UI elements with CustomPainter
// 16_drag_and_drop.dart - Implementing interactive drag-and-drop functionality
// 17_platform_channels.dart - Communicating between Flutter and native code (Android/iOS)
// 18_firebase_authentication.dart - User authentication with Firebase
// 19_graphql_api.dart - Integrating GraphQL APIs in Flutter apps
// 20_websockets_and_realtime.dart - Implementing WebSockets for real-time updates

//==========================================//

// 10_provider_state_management.dart - Implementing state management with Provider
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
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
        appBar: AppBar(title: const Text('Provider State Management')),
        body: Center(
          child: Consumer<CounterProvider>(
            builder: (context, model, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Counter: ${model.count}', style: const TextStyle(fontSize: 24)),
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

// 11_bloc_state_management.dart - Using BLoC for reactive state
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
}

void main() {
  runApp(const BlocCounterApp());
}

class BlocCounterApp extends StatelessWidget {
  const BlocCounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => CounterCubit(),
        child: Scaffold(
          appBar: AppBar(title: const Text('BLoC State Management')),
          body: Center(
            child: BlocBuilder<CounterCubit, int>(
              builder: (context, count) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Counter: $count', style: const TextStyle(fontSize: 24)),
                  ElevatedButton(
                    onPressed: () => context.read<CounterCubit>().increment(),
                    child: const Text('Increment'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//==========================================//

// 12_inherited_widget.dart - Understanding InheritedWidget
class CounterInheritedWidget extends InheritedWidget {
  final int counter;
  final Function increment;

  const CounterInheritedWidget({
    super.key,
    required this.counter,
    required this.increment,
    required Widget child,
  }) : super(child: child);

  static CounterInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(CounterInheritedWidget oldWidget) {
    return oldWidget.counter != counter;
  }
}

//==========================================//

// 13_theme_customization.dart - Advanced theming with ThemeData and custom fonts
class ThemedApp extends StatelessWidget {
  const ThemedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(bodyLarge: TextStyle(fontSize: 20)),
      ),
      home: const ThemedScreen(),
    );
  }
}

class ThemedScreen extends StatelessWidget {
  const ThemedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Themed App')),
      body: const Center(child: Text('Styled Text')),
    );
  }
}

//==========================================//

// 14_animations.dart - Implicit and explicit animations in Flutter
class AnimatedBox extends StatefulWidget {
  const AnimatedBox({super.key});

  @override
  _AnimatedBoxState createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _controller,
          child: Container(width: 100, height: 100, color: Colors.blue),
        ),
      ),
    );
  }
}

//==========================================//

// 15_custom_painting.dart - Creating custom UI elements with CustomPainter
class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

//==========================================//

// 16_drag_and_drop.dart - Implementing interactive drag-and-drop functionality
class DraggableItem extends StatelessWidget {
  const DraggableItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Draggable<int>(
      data: 10,
      feedback: const CircleAvatar(radius: 30, backgroundColor: Colors.blue),
      child: const CircleAvatar(radius: 30, backgroundColor: Colors.red),
    );
  }
}

//==========================================//

// 17_platform_channels.dart - Communicating between Flutter and native code (Android/iOS)
import 'package:flutter/services.dart';

const platform = MethodChannel('com.example.channel');

Future<void> callNativeMethod() async {
  final String result = await platform.invokeMethod('nativeMethod');
  print(result);
}

//==========================================//

// 18_firebase_authentication.dart - User authentication with Firebase
import 'package:firebase_auth/firebase_auth.dart';

void signInWithEmail(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('Signed in: ${userCredential.user}');
  } catch (e) {
    print('Error: $e');
  }
}

//==========================================//

// 19_graphql_api.dart - Integrating GraphQL APIs in Flutter apps
import 'package:graphql_flutter/graphql_flutter.dart';

void fetchGraphQLData() {
  final HttpLink httpLink = HttpLink('https://api.example.com/graphql');
}

//==========================================//

// 20_websockets_and_realtime.dart - Implementing WebSockets for real-time updates
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  final channel = WebSocketChannel.connect(Uri.parse('wss://example.com/socket'));
  channel.sink.add('Hello WebSocket!');
}
