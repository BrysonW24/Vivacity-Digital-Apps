import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/app_provider.dart';
import 'providers/notification_provider.dart';
import 'views/showcase/widget_showcase_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Boilerplate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      builder: (context, child) {
        return Listener(
          behavior: HitTestBehavior.deferToChild,
          onPointerSignal: (_) {}, //suppresses the mouse tracker
          child: child!,
        );
      },
      //home: const HomeScreen(),  // default
      home: const WidgetShowcaseScreen(),  // points to full UI showcase
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Boilerplate Home')),
      body: const Center(child: Text('Welcome to the Flutter Boilerplate!')),
    );
  }
}
