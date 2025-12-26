import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/journal_entry.dart';

/// Repository class for managing journal entries in the database
class JournalRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Get all journal entries, optionally filtered
  Future<List<JournalEntry>> getAllEntries({
    String? searchQuery,
    String? categoryId,
    List<String>? tagIds,
    Mood? mood,
    bool? isFavorite,
    DateTime? startDate,
    DateTime? endDate,
    String? sortBy = 'created_at',
    bool ascending = false,
  }) async {
    final db = await _dbHelper.database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    // Build WHERE clause based on filters
    List<String> conditions = [];

    if (searchQuery != null && searchQuery.isNotEmpty) {
      conditions.add('(title LIKE ? OR content LIKE ?)');
      whereArgs.add('%$searchQuery%');
      whereArgs.add('%$searchQuery%');
    }

    if (categoryId != null) {
      conditions.add('category_id = ?');
      whereArgs.add(categoryId);
    }

    if (tagIds != null && tagIds.isNotEmpty) {
      // Search for entries that contain any of the specified tags
      List<String> tagConditions = [];
      for (String tagId in tagIds) {
        tagConditions.add("tags LIKE ?");
        whereArgs.add('%,$tagId,%');
      }
      conditions.add('(${tagConditions.join(' OR ')})');
    }

    if (mood != null) {
      conditions.add('mood = ?');
      whereArgs.add(mood.index);
    }

    if (isFavorite != null) {
      conditions.add('is_favorite = ?');
      whereArgs.add(isFavorite ? 1 : 0);
    }

    if (startDate != null) {
      conditions.add('created_at >= ?');
      whereArgs.add(startDate.toIso8601String());
    }

    if (endDate != null) {
      conditions.add('created_at <= ?');
      whereArgs.add(endDate.toIso8601String());
    }

    if (conditions.isNotEmpty) {
      whereClause = 'WHERE ${conditions.join(' AND ')}';
    }

    // Build ORDER BY clause
    String orderBy = 'created_at DESC'; // Default: newest first
    if (sortBy != null) {
      switch (sortBy) {
        case 'title':
          orderBy = 'title ${ascending ? 'ASC' : 'DESC'}';
          break;
        case 'updated_at':
          orderBy = 'updated_at ${ascending ? 'ASC' : 'DESC'}';
          break;
        case 'created_at':
        default:
          orderBy = 'created_at ${ascending ? 'ASC' : 'DESC'}';
          break;
      }
    }

    final List<Map<String, dynamic>> maps = await db.rawQuery(
      'SELECT * FROM ${DatabaseHelper.tableEntries} $whereClause ORDER BY $orderBy',
      whereArgs,
    );

    print('📖 getAllEntries: Found ${maps.length} entries in database');
    if (maps.isEmpty) {
      print('   ⚠️  Database returned no entries');
    } else {
      print('   First entry: ${maps.first['title']}');
    }

    return maps.map((map) => JournalEntry.fromMap(map)).toList();
  }

  /// Get a single journal entry by ID
  Future<JournalEntry?> getEntryById(String id) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableEntries,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return JournalEntry.fromMap(maps.first);
    }

    return null;
  }

  /// Insert a new journal entry
  Future<String> insertEntry(JournalEntry entry) async {
    try {
      final db = await _dbHelper.database;
      final entryMap = entry.toMap();

      print('🔍 Attempting to insert entry into database:');
      print('   ID: ${entryMap['id']}');
      print('   Title: ${entryMap['title']}');
      print('   Content length: ${(entryMap['content'] as String).length}');
      print('   Map: $entryMap');

      final result = await db.insert(
        DatabaseHelper.tableEntries,
        entryMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      print('✅ Database insert successful! Row ID: $result');

      // Verify the entry was saved
      final verification = await db.query(
        DatabaseHelper.tableEntries,
        where: 'id = ?',
        whereArgs: [entry.id],
      );
      print('🔍 Verification query returned ${verification.length} row(s)');

      return entry.id;
    } catch (e, stackTrace) {
      print('❌ Database insert error: $e');
      print('📋 Stack trace: $stackTrace');
      rethrow;
    }
  }

  /// Update an existing journal entry
  Future<int> updateEntry(JournalEntry entry) async {
    final db = await _dbHelper.database;

    // Update the updated_at timestamp
    final updatedEntry = entry.copyWith(updatedAt: DateTime.now());

    return await db.update(
      DatabaseHelper.tableEntries,
      updatedEntry.toMap(),
      where: 'id = ?',
      whereArgs: [entry.id],
    );
  }

  /// Delete a journal entry
  Future<int> deleteEntry(String id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      DatabaseHelper.tableEntries,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Toggle favorite status of an entry
  Future<bool> toggleFavorite(String id) async {
    final entry = await getEntryById(id);
    if (entry == null) return false;

    final updatedEntry = entry.copyWith(isFavorite: !entry.isFavorite);
    await updateEntry(updatedEntry);

    return updatedEntry.isFavorite;
  }

  /// Get entries count with optional filters
  Future<int> getEntriesCount({
    String? categoryId,
    Mood? mood,
    bool? isFavorite,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final db = await _dbHelper.database;

    String whereClause = '';
    List<dynamic> whereArgs = [];

    List<String> conditions = [];

    if (categoryId != null) {
      conditions.add('category_id = ?');
      whereArgs.add(categoryId);
    }

    if (mood != null) {
      conditions.add('mood = ?');
      whereArgs.add(mood.index);
    }

    if (isFavorite != null) {
      conditions.add('is_favorite = ?');
      whereArgs.add(isFavorite ? 1 : 0);
    }

    if (startDate != null) {
      conditions.add('created_at >= ?');
      whereArgs.add(startDate.toIso8601String());
    }

    if (endDate != null) {
      conditions.add('created_at <= ?');
      whereArgs.add(endDate.toIso8601String());
    }

    if (conditions.isNotEmpty) {
      whereClause = 'WHERE ${conditions.join(' AND ')}';
    }

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseHelper.tableEntries} $whereClause',
      whereArgs,
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Get statistics about journal entries
  Future<Map<String, dynamic>> getStatistics() async {
    final db = await _dbHelper.database;

    // Total entries
    final totalEntries = await getEntriesCount();

    // Favorite entries
    final favoriteEntries = await getEntriesCount(isFavorite: true);

    // Entries by mood
    final moodStats = <String, int>{};
    for (var mood in Mood.values) {
      final count = await getEntriesCount(mood: mood);
      moodStats[mood.displayName] = count;
    }

    // Recent entries (last 7 days)
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final recentEntries = await getEntriesCount(startDate: sevenDaysAgo);

    // Average words per entry
    final entries = await getAllEntries();
    final totalWords = entries.fold<int>(0, (sum, entry) => sum + entry.wordCount);
    final averageWords = entries.isNotEmpty ? totalWords / entries.length : 0;

    return {
      'totalEntries': totalEntries,
      'favoriteEntries': favoriteEntries,
      'moodStatistics': moodStats,
      'recentEntries': recentEntries,
      'averageWordsPerEntry': averageWords.round(),
      'totalWords': totalWords,
    };
  }

  /// Search entries by content, title, or tags
  Future<List<JournalEntry>> searchEntries(String query) async {
    return getAllEntries(searchQuery: query);
  }

  /// Get entries grouped by date (for calendar view)
  Future<Map<DateTime, List<JournalEntry>>> getEntriesGroupedByDate({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final entries = await getAllEntries(
      startDate: startDate,
      endDate: endDate,
      sortBy: 'created_at',
      ascending: true,
    );

    final grouped = <DateTime, List<JournalEntry>>{};

    for (final entry in entries) {
      final date = DateTime(
        entry.createdAt.year,
        entry.createdAt.month,
        entry.createdAt.day,
      );

      if (grouped.containsKey(date)) {
        grouped[date]!.add(entry);
      } else {
        grouped[date] = [entry];
      }
    }

    return grouped;
  }

  /// Get recent entries (last N entries)
  Future<List<JournalEntry>> getRecentEntries(int limit) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableEntries,
      orderBy: 'created_at DESC',
      limit: limit,
    );

    return maps.map((map) => JournalEntry.fromMap(map)).toList();
  }

  /// Clear all entries (use with caution)
  Future<int> clearAllEntries() async {
    final db = await _dbHelper.database;
    return await db.delete(DatabaseHelper.tableEntries);
  }
}