import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/journal_entry.dart';

/// Repository class for managing tags in the database
class TagRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Get all tags
  Future<List<Tag>> getAllTags() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableTags,
      orderBy: 'name ASC',
    );

    return maps.map((map) => Tag.fromMap(map)).toList();
  }

  /// Get a single tag by ID
  Future<Tag?> getTagById(String id) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableTags,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Tag.fromMap(maps.first);
    }

    return null;
  }

  /// Get tag by name
  Future<Tag?> getTagByName(String name) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableTags,
      where: 'name = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return Tag.fromMap(maps.first);
    }

    return null;
  }

  /// Insert a new tag
  Future<String> insertTag(Tag tag) async {
    final db = await _dbHelper.database;

    await db.insert(
      DatabaseHelper.tableTags,
      tag.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return tag.id;
  }

  /// Update an existing tag
  Future<int> updateTag(Tag tag) async {
    final db = await _dbHelper.database;

    return await db.update(
      DatabaseHelper.tableTags,
      tag.toMap(),
      where: 'id = ?',
      whereArgs: [tag.id],
    );
  }

  /// Delete a tag
  Future<int> deleteTag(String id) async {
    final db = await _dbHelper.database;

    // Remove this tag from all entries that have it
    final entriesWithTag = await db.query(
      DatabaseHelper.tableEntries,
      where: 'tags LIKE ?',
      whereArgs: ['%,$id,%'],
    );

    for (final entry in entriesWithTag) {
      final currentTags = (entry['tags'] as String?)?.split(',').where((tag) => tag.isNotEmpty).toList() ?? [];
      currentTags.remove(id);
      final updatedTags = currentTags.join(',');

      await db.update(
        DatabaseHelper.tableEntries,
        {'tags': updatedTags},
        where: 'id = ?',
        whereArgs: [entry['id']],
      );
    }

    // Then delete the tag
    return await db.delete(
      DatabaseHelper.tableTags,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Get tags count
  Future<int> getTagsCount() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseHelper.tableTags}',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Get usage statistics for tags (entries per tag)
  Future<Map<String, int>> getTagUsageStats() async {
    final db = await _dbHelper.database;

    final tags = await getAllTags();
    final stats = <String, int>{};

    for (final tag in tags) {
      final count = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${DatabaseHelper.tableEntries} WHERE tags LIKE ?',
        ['%,${tag.id},%'],
      );

      final entryCount = Sqflite.firstIntValue(count) ?? 0;
      if (entryCount > 0) {
        stats[tag.name] = entryCount;
      }
    }

    // Sort by usage (most used first)
    final sortedStats = Map.fromEntries(
      stats.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );

    return sortedStats;
  }

  /// Search tags by name
  Future<List<Tag>> searchTags(String query) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableTags,
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
      orderBy: 'name ASC',
    );

    return maps.map((map) => Tag.fromMap(map)).toList();
  }

  /// Get most popular tags (limit to top N)
  Future<List<MapEntry<Tag, int>>> getPopularTags({int limit = 10}) async {
    final usageStats = await getTagUsageStats();
    final tags = await getAllTags();

    final tagUsageList = <MapEntry<Tag, int>>[];

    for (final tag in tags) {
      final usage = usageStats[tag.name] ?? 0;
      tagUsageList.add(MapEntry(tag, usage));
    }

    // Sort by usage descending
    tagUsageList.sort((a, b) => b.value.compareTo(a.value));

    // Return top N
    return tagUsageList.take(limit).toList();
  }

  /// Create default tags if none exist
  Future<void> createDefaultTags() async {
    final count = await getTagsCount();
    if (count > 0) return; // Default tags already exist

    final defaultTags = [
      Tag(name: 'Inspiration', color: const Color(0xFF4CAF50)), // Green
      Tag(name: 'Reflection', color: const Color(0xFF2196F3)), // Blue
      Tag(name: 'Goals', color: const Color(0xFFFF9800)), // Orange
      Tag(name: 'Gratitude', color: const Color(0xFFE91E63)), // Pink
      Tag(name: 'Challenge', color: const Color(0xFF9C27B0)), // Purple
      Tag(name: 'Achievement', color: const Color(0xFF00BCD4)), // Cyan
      Tag(name: 'Learning', color: const Color(0xFF8BC34A)), // Light Green
      Tag(name: 'Creativity', color: const Color(0xFFFF5722)), // Deep Orange
      Tag(name: 'Health', color: const Color(0xFF3F51B5)), // Indigo
      Tag(name: 'Relationships', color: const Color(0xFF795548)), // Brown
    ];

    for (final tag in defaultTags) {
      await insertTag(tag);
    }
  }

  /// Bulk insert tags
  Future<void> insertTags(List<Tag> tags) async {
    for (final tag in tags) {
      await insertTag(tag);
    }
  }
}