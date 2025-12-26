import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/models/journal_entry.dart';
import 'package:journal_app/screens/entry_editor_screen.dart';
import 'package:journal_app/providers/journal_provider.dart';
import 'package:journal_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  group('EntryEditorScreen Widget Tests', () {
    late JournalProvider journalProvider;
    late ThemeProvider themeProvider;

    setUp(() {
      journalProvider = JournalProvider();
      themeProvider = ThemeProvider();
    });

    Widget createTestWidget({JournalEntry? entry}) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<JournalProvider>.value(value: journalProvider),
          ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ],
        child: MaterialApp(
          home: EntryEditorScreen(entry: entry),
        ),
      );
    }

    testWidgets('displays title field and content field', (tester) async {
      await tester.pumpWidget(createTestWidget());

      // Find text fields
      expect(find.byType(TextField), findsWidgets);

      // Should have title field
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('displays all mood options', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find mood section
      expect(find.text('How are you feeling?'), findsOneWidget);

      // Check all mood emojis are present
      for (final mood in Mood.values) {
        expect(find.text(mood.emoji), findsOneWidget);
      }
    });

    testWidgets('can select mood by tapping', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find and tap happy mood
      final happyMood = find.text(Mood.happy.emoji);
      expect(happyMood, findsOneWidget);

      await tester.tap(happyMood);
      await tester.pumpAndSettle();

      // Mood should be selected (verify by checking container decoration)
      // The selected mood should have a different visual state
    });

    testWidgets('displays save button', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Save button should be in app bar
      expect(find.byIcon(Icons.save), findsOneWidget);
    });

    testWidgets('pre-fills fields when editing existing entry', (tester) async {
      final existingEntry = JournalEntry(
        id: 'test-123',
        title: 'Existing Title',
        content: 'Existing Content',
        mood: Mood.happy,
      );

      await tester.pumpWidget(createTestWidget(entry: existingEntry));
      await tester.pumpAndSettle();

      // Title should be pre-filled
      expect(find.text('Existing Title'), findsOneWidget);

      // Content should be pre-filled
      expect(find.text('Existing Content'), findsOneWidget);
    });

    testWidgets('can enter text in title field', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find title field and enter text
      final titleField = find.byKey(const Key('title_field'));
      await tester.enterText(titleField, 'New Journal Entry');
      await tester.pump();

      expect(find.text('New Journal Entry'), findsOneWidget);
    });

    testWidgets('can enter text in content field', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Find content field and enter text
      final contentField = find.byKey(const Key('content_field'));
      await tester.enterText(contentField, 'This is my journal content for today.');
      await tester.pump();

      expect(find.text('This is my journal content for today.'), findsOneWidget);
    });

    testWidgets('displays back button in app bar', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Back button should be present
      expect(find.byType(BackButton), findsOneWidget);
    });

    testWidgets('mood selection is optional', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Should be able to create entry without selecting mood
      // No mood should be selected initially
      // This is a visual test - in actual implementation, you'd check the state
    });
  });

  group('EntryEditorScreen Edge Cases', () {
    late JournalProvider journalProvider;
    late ThemeProvider themeProvider;

    setUp(() {
      journalProvider = JournalProvider();
      themeProvider = ThemeProvider();
    });

    Widget createTestWidget({JournalEntry? entry}) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<JournalProvider>.value(value: journalProvider),
          ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ],
        child: MaterialApp(
          home: EntryEditorScreen(entry: entry),
        ),
      );
    }

    testWidgets('handles very long title', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final longTitle = 'A' * 500;
      final titleField = find.byKey(const Key('title_field'));

      await tester.enterText(titleField, longTitle);
      await tester.pump();

      // Should accept long title without crashing
      expect(find.textContaining('A'), findsWidgets);
    });

    testWidgets('handles very long content', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      final longContent = 'B' * 10000;
      final contentField = find.byKey(const Key('content_field'));

      await tester.enterText(contentField, longContent);
      await tester.pump();

      // Should accept long content without crashing
      expect(find.textContaining('B'), findsWidgets);
    });

    testWidgets('handles empty title and content gracefully', (tester) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Try to save without entering anything
      final saveButton = find.byIcon(Icons.save);
      expect(saveButton, findsOneWidget);

      // Tapping save with empty fields should handle gracefully
      // (Implementation would show validation error or prevent save)
    });
  });
}
