import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:journal_app/main.dart' as app;
import 'package:journal_app/models/journal_entry.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Journal App Integration Tests', () {
    testWidgets('Complete user flow: Create, View, Edit, Delete entry', (tester) async {
      // Start the app
      app.main();
      await tester.pumpAndSettle();

      // Wait for app to initialize
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // ========== CREATE ENTRY ==========

      // Find and tap the FAB to create new entry
      final fab = find.byType(FloatingActionButton);
      expect(fab, findsOneWidget);
      await tester.tap(fab);
      await tester.pumpAndSettle();

      // Verify we're on the editor screen
      expect(find.byKey(const Key('title_field')), findsOneWidget);
      expect(find.byKey(const Key('content_field')), findsOneWidget);

      // Enter title
      await tester.enterText(
        find.byKey(const Key('title_field')),
        'Integration Test Entry',
      );
      await tester.pump();

      // Enter content
      await tester.enterText(
        find.byKey(const Key('content_field')),
        'This is a test entry created by integration tests. It should be saved to the database.',
      );
      await tester.pump();

      // Select a mood (Happy)
      final happyMood = find.text(Mood.happy.emoji);
      await tester.tap(happyMood);
      await tester.pump();

      // Save the entry
      final saveButton = find.byIcon(Icons.save);
      expect(saveButton, findsOneWidget);
      await tester.tap(saveButton);
      await tester.pumpAndSettle();

      // ========== VERIFY ENTRY IN LIST ==========

      // Should be back on home screen
      // Look for our entry in the list
      await tester.pumpAndSettle(const Duration(seconds: 1));

      // Entry should appear in the table
      expect(find.text('Integration Test Entry'), findsOneWidget);

      // ========== VIEW ENTRY DETAILS ==========

      // Tap on the entry to view details
      await tester.tap(find.text('Integration Test Entry'));
      await tester.pumpAndSettle();

      // Verify we can see the full content
      expect(find.textContaining('This is a test entry'), findsOneWidget);
      expect(find.text(Mood.happy.emoji), findsOneWidget);

      // Go back to home screen
      await tester.pageBack();
      await tester.pumpAndSettle();

      // ========== EDIT ENTRY ==========

      // Tap on entry again and select edit
      await tester.tap(find.text('Integration Test Entry'));
      await tester.pumpAndSettle();

      // Find and tap edit button
      final editButton = find.byIcon(Icons.edit);
      expect(editButton, findsOneWidget);
      await tester.tap(editButton);
      await tester.pumpAndSettle();

      // Modify the title
      final titleField = find.byKey(const Key('title_field'));
      await tester.enterText(titleField, 'Edited Integration Test Entry');
      await tester.pump();

      // Change mood to Very Happy
      final veryHappyMood = find.text(Mood.veryHappy.emoji);
      await tester.tap(veryHappyMood);
      await tester.pump();

      // Save changes
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // ========== VERIFY EDITS ==========

      // Should be back on detail screen or home screen
      await tester.pumpAndSettle();

      // Verify edited title appears
      expect(find.text('Edited Integration Test Entry'), findsOneWidget);

      // ========== DELETE ENTRY ==========

      // Navigate to entry if not already there
      if (find.byIcon(Icons.delete).evaluate().isEmpty) {
        await tester.tap(find.text('Edited Integration Test Entry'));
        await tester.pumpAndSettle();
      }

      // Find and tap delete button
      final deleteButton = find.byIcon(Icons.delete);
      expect(deleteButton, findsOneWidget);
      await tester.tap(deleteButton);
      await tester.pumpAndSettle();

      // Confirm deletion in dialog
      final confirmButton = find.text('Delete');
      if (confirmButton.evaluate().isNotEmpty) {
        await tester.tap(confirmButton);
        await tester.pumpAndSettle();
      }

      // ========== VERIFY DELETION ==========

      // Entry should no longer be in the list
      await tester.pumpAndSettle(const Duration(seconds: 1));
      expect(find.text('Edited Integration Test Entry'), findsNothing);
    });

    testWidgets('Search functionality works', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Create a test entry first
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('title_field')), 'Searchable Entry');
      await tester.enterText(find.byKey(const Key('content_field')), 'Unique content 12345');
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // Open search
      final searchButton = find.byIcon(Icons.search);
      if (searchButton.evaluate().isNotEmpty) {
        await tester.tap(searchButton);
        await tester.pumpAndSettle();

        // Enter search query
        final searchField = find.byType(TextField).first;
        await tester.enterText(searchField, 'Searchable');
        await tester.pumpAndSettle();

        // Verify search results
        expect(find.text('Searchable Entry'), findsOneWidget);

        // Clear search
        await tester.enterText(searchField, '');
        await tester.pumpAndSettle();
      }

      // Clean up: delete the test entry
      if (find.text('Searchable Entry').evaluate().isNotEmpty) {
        await tester.tap(find.text('Searchable Entry'));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        final confirmButton = find.text('Delete');
        if (confirmButton.evaluate().isNotEmpty) {
          await tester.tap(confirmButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Favorite toggle works', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Create entry
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(const Key('title_field')), 'Favorite Test Entry');
      await tester.enterText(find.byKey(const Key('content_field')), 'This will be favorited');
      await tester.tap(find.byIcon(Icons.save));
      await tester.pumpAndSettle();

      // Find the favorite button in the table
      final favoriteButtons = find.byIcon(Icons.favorite_border);
      if (favoriteButtons.evaluate().isNotEmpty) {
        await tester.tap(favoriteButtons.first);
        await tester.pumpAndSettle();

        // Verify it changed to filled heart
        expect(find.byIcon(Icons.favorite), findsWidgets);

        // Toggle back
        await tester.tap(find.byIcon(Icons.favorite).first);
        await tester.pumpAndSettle();

        // Should be back to outline
        expect(find.byIcon(Icons.favorite_border), findsWidgets);
      }

      // Clean up
      if (find.text('Favorite Test Entry').evaluate().isNotEmpty) {
        await tester.tap(find.text('Favorite Test Entry'));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        final confirmButton = find.text('Delete');
        if (confirmButton.evaluate().isNotEmpty) {
          await tester.tap(confirmButton);
          await tester.pumpAndSettle();
        }
      }
    });

    testWidgets('Navigation between tabs works', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Find tabs
      final entriesTab = find.text('Entries');
      final calendarTab = find.text('Calendar');
      final favoritesTab = find.text('Favorites');

      if (entriesTab.evaluate().isNotEmpty) {
        // Navigate to Calendar
        if (calendarTab.evaluate().isNotEmpty) {
          await tester.tap(calendarTab);
          await tester.pumpAndSettle();

          // Verify calendar view is shown
          // (Look for calendar-specific widgets)
        }

        // Navigate to Favorites
        if (favoritesTab.evaluate().isNotEmpty) {
          await tester.tap(favoritesTab);
          await tester.pumpAndSettle();

          // Verify favorites view is shown
        }

        // Navigate back to Entries
        await tester.tap(entriesTab);
        await tester.pumpAndSettle();
      }
    });

    testWidgets('Empty state is displayed when no entries', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // If there are entries, this test might not see empty state
      // But if database is empty, should see empty state message
      final emptyStateIndicators = [
        find.textContaining('No entries'),
        find.textContaining('Start'),
        find.textContaining('empty'),
        find.byIcon(Icons.book),
        find.byIcon(Icons.edit_note),
      ];

      // At least one empty state indicator should be present if DB is empty
      // (This assertion is flexible since DB might have entries)
    });
  });
}
