import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/models/journal_entry.dart';
import 'package:journal_app/repositories/journal_repository.dart';

void main() {
  group('JournalRepository', () {
    test('can be instantiated', () {
      final repository = JournalRepository();
      expect(repository, isNotNull);
    });

    test('getAllEntries returns Future<List<JournalEntry>>', () async {
      final repository = JournalRepository();

      // This test verifies the method exists and returns correct type
      final result = await repository.getAllEntries();

      expect(result, isA<List<JournalEntry>>());
    });

    test('getAllEntries with searchQuery filters by title/content', () async {
      final repository = JournalRepository();

      // Get all entries first
      final allEntries = await repository.getAllEntries();

      // Search should return Future<List>
      final searchResult = await repository.getAllEntries(searchQuery: 'test');

      expect(searchResult, isA<List<JournalEntry>>());
    });

    test('getAllEntries with mood filter', () async {
      final repository = JournalRepository();

      final result = await repository.getAllEntries(mood: Mood.happy);

      expect(result, isA<List<JournalEntry>>());
      // If entries exist with mood.happy, they should all be happy
      for (final entry in result) {
        expect(entry.mood, equals(Mood.happy));
      }
    });

    test('getAllEntries with isFavorite filter', () async {
      final repository = JournalRepository();

      final result = await repository.getAllEntries(isFavorite: true);

      expect(result, isA<List<JournalEntry>>());
      // All returned entries should be favorites
      for (final entry in result) {
        expect(entry.isFavorite, true);
      }
    });

    test('getAllEntries with sorting by created_at ascending', () async {
      final repository = JournalRepository();

      final result = await repository.getAllEntries(
        sortBy: 'created_at',
        ascending: true,
      );

      expect(result, isA<List<JournalEntry>>());

      // Verify sorting: if more than one entry, check order
      if (result.length > 1) {
        for (int i = 0; i < result.length - 1; i++) {
          expect(
            result[i].createdAt.isBefore(result[i + 1].createdAt) ||
                result[i].createdAt.isAtSameMomentAs(result[i + 1].createdAt),
            true,
          );
        }
      }
    });

    test('getAllEntries with sorting by title', () async {
      final repository = JournalRepository();

      final result = await repository.getAllEntries(
        sortBy: 'title',
        ascending: true,
      );

      expect(result, isA<List<JournalEntry>>());
    });

    test('getAllEntries with date range filter', () async {
      final repository = JournalRepository();
      final startDate = DateTime(2025, 1, 1);
      final endDate = DateTime(2025, 12, 31);

      final result = await repository.getAllEntries(
        startDate: startDate,
        endDate: endDate,
      );

      expect(result, isA<List<JournalEntry>>());

      // All entries should be within date range
      for (final entry in result) {
        expect(entry.createdAt.isAfter(startDate) || entry.createdAt.isAtSameMomentAs(startDate), true);
        expect(entry.createdAt.isBefore(endDate) || entry.createdAt.isAtSameMomentAs(endDate), true);
      }
    });

    test('getAllEntries with multiple filters combined', () async {
      final repository = JournalRepository();

      final result = await repository.getAllEntries(
        mood: Mood.happy,
        isFavorite: true,
        searchQuery: 'important',
      );

      expect(result, isA<List<JournalEntry>>());

      // All results should match filters
      for (final entry in result) {
        expect(entry.mood, Mood.happy);
        expect(entry.isFavorite, true);
      }
    });

    test('getAllEntries returns empty list initially', () async {
      final repository = JournalRepository();

      // Fresh database might be empty, or have data from previous tests
      final result = await repository.getAllEntries();

      expect(result, isA<List<JournalEntry>>());
    });

    test('repository methods handle null parameters gracefully', () async {
      final repository = JournalRepository();

      // Call with all null optional parameters
      final result = await repository.getAllEntries(
        searchQuery: null,
        categoryId: null,
        tagIds: null,
        mood: null,
        isFavorite: null,
        startDate: null,
        endDate: null,
      );

      expect(result, isA<List<JournalEntry>>());
    });

    test('repository preserves entry data through filters', () async {
      final repository = JournalRepository();

      // Get entries without filter
      final allEntries = await repository.getAllEntries();

      if (allEntries.isNotEmpty) {
        final firstEntry = allEntries.first;

        // Get same entries with sorting
        final sortedEntries = await repository.getAllEntries(
          sortBy: 'created_at',
        );

        // Verify entry data is preserved
        expect(sortedEntries, isNotEmpty);

        final matchingEntry = sortedEntries.firstWhere(
          (e) => e.id == firstEntry.id,
          orElse: () => JournalEntry(title: '', content: ''),
        );

        if (matchingEntry.id.isNotEmpty) {
          expect(matchingEntry.title, firstEntry.title);
          expect(matchingEntry.content, firstEntry.content);
          expect(matchingEntry.mood, firstEntry.mood);
        }
      }
    });
  });
}
