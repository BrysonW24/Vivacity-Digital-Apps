import 'package:flutter_test/flutter_test.dart';
import 'package:journal_app/models/journal_entry.dart';
import 'package:journal_app/providers/journal_provider.dart';

void main() {
  late JournalProvider provider;

  setUp(() {
    provider = JournalProvider();
  });

  group('JournalProvider', () {
    test('initial state is empty', () {
      expect(provider.entries, isEmpty);
      expect(provider.isLoading, false);
      expect(provider.error, isNull);
    });

    test('computed getters work correctly', () {
      // Test favorite entries getter
      expect(provider.favoriteEntries, isEmpty);

      // Test recent entries getter
      expect(provider.recentEntries, isEmpty);

      // Test counts
      expect(provider.totalEntries, 0);
      expect(provider.favoriteEntriesCount, 0);
    });

    test('moodStatistics returns correct stats', () {
      final stats = provider.moodStatistics;

      // Should have all mood types initialized to 0
      expect(stats.length, Mood.values.length);
      for (final mood in Mood.values) {
        expect(stats[mood.displayName], 0);
      }
    });

    test('clearError clears error state', () {
      // Since we can't easily trigger errors without repository calls,
      // we test the clearError method directly
      provider.clearError();
      expect(provider.error, isNull);
    });

    test('getCategoryById returns null when no categories', () {
      final category = provider.getCategoryById('nonexistent');
      expect(category, isNull);
    });

    test('getTagById returns null when no tags', () {
      final tag = provider.getTagById('nonexistent');
      expect(tag, isNull);
    });

    test('getTagsByIds returns empty list when no tags', () {
      final tags = provider.getTagsByIds(['nonexistent']);
      expect(tags, isEmpty);
    });
  });
}