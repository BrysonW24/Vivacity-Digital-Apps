// Basic widget test for the Journal App

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:journal_app/main.dart';
import 'package:journal_app/providers/journal_provider.dart';
import 'package:journal_app/providers/theme_provider.dart';

void main() {
  testWidgets('Journal app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame - but JournalApp requires providers, so we need to wrap it
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => JournalProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const JournalApp(),
      ),
    );

    // Wait for initialization
    await tester.pumpAndSettle();

    // Verify that the app initializes without errors
    // Since it's a consumer, we just check that something renders
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
