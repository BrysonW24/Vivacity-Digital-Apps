import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../database/database_helper.dart';
import '../models/journal_entry.dart';

/// Repository class for managing categories in the database
class CategoryRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  /// Get all categories
  Future<List<Category>> getAllCategories() async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableCategories,
      orderBy: 'name ASC',
    );

    return maps.map((map) => Category.fromMap(map)).toList();
  }

  /// Get a single category by ID
  Future<Category?> getCategoryById(String id) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableCategories,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Category.fromMap(maps.first);
    }

    return null;
  }

  /// Get category by name
  Future<Category?> getCategoryByName(String name) async {
    final db = await _dbHelper.database;

    final List<Map<String, dynamic>> maps = await db.query(
      DatabaseHelper.tableCategories,
      where: 'name = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return Category.fromMap(maps.first);
    }

    return null;
  }

  /// Insert a new category
  Future<String> insertCategory(Category category) async {
    final db = await _dbHelper.database;

    await db.insert(
      DatabaseHelper.tableCategories,
      category.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return category.id;
  }

  /// Update an existing category
  Future<int> updateCategory(Category category) async {
    final db = await _dbHelper.database;

    return await db.update(
      DatabaseHelper.tableCategories,
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  /// Delete a category
  Future<int> deleteCategory(String id) async {
    final db = await _dbHelper.database;

    // First, set category_id to null for all entries with this category
    await db.update(
      DatabaseHelper.tableEntries,
      {'category_id': null},
      where: 'category_id = ?',
      whereArgs: [id],
    );

    // Then delete the category
    return await db.delete(
      DatabaseHelper.tableCategories,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Get categories count
  Future<int> getCategoriesCount() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseHelper.tableCategories}',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  /// Get usage statistics for categories (entries per category)
  Future<Map<String, int>> getCategoryUsageStats() async {
    final db = await _dbHelper.database;

    final result = await db.rawQuery('''
      SELECT c.name, COUNT(e.id) as entry_count
      FROM ${DatabaseHelper.tableCategories} c
      LEFT JOIN ${DatabaseHelper.tableEntries} e ON c.id = e.category_id
      GROUP BY c.id, c.name
      ORDER BY entry_count DESC
    ''');

    final stats = <String, int>{};
    for (final row in result) {
      stats[row['name'] as String] = row['entry_count'] as int;
    }

    return stats;
  }

  /// Create default categories if none exist
  Future<void> createDefaultCategories() async {
    final count = await getCategoriesCount();
    if (count > 0) return; // Default categories already exist

    final defaultCategories = [
      Category(
        name: 'Personal',
        description: 'Personal thoughts and reflections',
        color: const Color(0xFF2196F3), // Blue
        iconName: 'person',
      ),
      Category(
        name: 'Work',
        description: 'Work-related thoughts and notes',
        color: const Color(0xFF4CAF50), // Green
        iconName: 'work',
      ),
      Category(
        name: 'Health',
        description: 'Health and wellness related entries',
        color: const Color(0xFFFF9800), // Orange
        iconName: 'health',
      ),
      Category(
        name: 'Travel',
        description: 'Travel experiences and adventures',
        color: const Color(0xFF9C27B0), // Purple
        iconName: 'travel',
      ),
      Category(
        name: 'Learning',
        description: 'Learning experiences and insights',
        color: const Color(0xFF00BCD4), // Cyan
        iconName: 'school',
      ),
      Category(
        name: 'Relationships',
        description: 'Thoughts about relationships and people',
        color: const Color(0xFFE91E63), // Pink
        iconName: 'people',
      ),
    ];

    for (final category in defaultCategories) {
      await insertCategory(category);
    }
  }
}