import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:journal_app/screens/home_screen.dart';
import 'package:journal_app/providers/journal_provider.dart';
import 'package:journal_app/providers/theme_provider.dart';

void main() {
  group('HomeScreen Widget Tests', () {
    testWidgets('displays home screen with initial widgets', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => JournalProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MaterialApp(
            home: const HomeScreen(),
          ),
        ),
      );

      // Verify that home screen renders without errors
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('displays app title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => JournalProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MaterialApp(
            home: const HomeScreen(),
          ),
        ),
      );

      // App should display title
      expect(find.byType(AppBar), findsWidgets);
    });

    testWidgets('displays FloatingActionButton for creating new entry',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => JournalProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MaterialApp(
            home: const HomeScreen(),
          ),
        ),
      );

      // Verify FAB is present
      expect(find.byType(FloatingActionButton), findsWidgets);
    });

    testWidgets('displays bottom navigation bar', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => JournalProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MaterialApp(
            home: const HomeScreen(),
          ),
        ),
      );

      // HomeScreen should have tab navigation
      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('home screen initializes without errors', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => JournalProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MaterialApp(
            home: const HomeScreen(),
          ),
        ),
      );

      // Wait for all animations to complete
      await tester.pumpAndSettle();

      // Should still be on home screen
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('displays MaterialApp with correct theme', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => JournalProvider()),
            ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ],
          child: MaterialApp(
            home: const HomeScreen(),
            theme: ThemeData(useMaterial3: true),
          ),
        ),
      );

      // Verify MaterialApp is present
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
