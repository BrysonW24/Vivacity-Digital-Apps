import 'package:flutter/material.dart';
import '../models/journal_entry.dart';
import '../repositories/journal_repository.dart';
import '../repositories/category_repository.dart';
import '../repositories/tag_repository.dart';

/// Provider class for managing journal-related state
class JournalProvider with ChangeNotifier {
  final JournalRepository _journalRepository = JournalRepository();
  final CategoryRepository _categoryRepository = CategoryRepository();
  final TagRepository _tagRepository = TagRepository();

  // State variables
  List<JournalEntry> _entries = [];
  List<Category> _categories = [];
  List<Tag> _tags = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<JournalEntry> get entries => List.unmodifiable(_entries);
  List<Category> get categories => List.unmodifiable(_categories);
  List<Tag> get tags => List.unmodifiable(_tags);
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Computed getters
  List<JournalEntry> get favoriteEntries =>
      _entries.where((entry) => entry.isFavorite).toList();

  List<JournalEntry> get recentEntries =>
      _entries.take(5).toList();

  int get totalEntries => _entries.length;
  int get favoriteEntriesCount => favoriteEntries.length;

  Map<String, int> get moodStatistics {
    final stats = <String, int>{};
    for (final mood in Mood.values) {
      stats[mood.displayName] = _entries.where((entry) => entry.mood == mood).length;
    }
    return stats;
  }

  /// Initialize the provider and load initial data
  Future<void> initialize() async {
    try {
      _setLoading(true);
      _clearError();

      // Create default categories and tags if they don't exist
      await _categoryRepository.createDefaultCategories();
      await _tagRepository.createDefaultTags();

      // Load all data
      await Future.wait([
        loadEntries(),
        loadCategories(),
        loadTags(),
      ]);
    } catch (e) {
      _setError('Failed to initialize journal: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Load all journal entries
  Future<void> loadEntries({
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
    try {
      _setLoading(true);
      _clearError();

      _entries = await _journalRepository.getAllEntries(
        searchQuery: searchQuery,
        categoryId: categoryId,
        tagIds: tagIds,
        mood: mood,
        isFavorite: isFavorite,
        startDate: startDate,
        endDate: endDate,
        sortBy: sortBy,
        ascending: ascending,
      );

      notifyListeners();
    } catch (e) {
      _setError('Failed to load entries: $e');
    } finally {
      _setLoading(false);
    }
  }

  /// Load all categories
  Future<void> loadCategories() async {
    try {
      _categories = await _categoryRepository.getAllCategories();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load categories: $e');
    }
  }

  /// Load all tags
  Future<void> loadTags() async {
    try {
      _tags = await _tagRepository.getAllTags();
      notifyListeners();
    } catch (e) {
      _setError('Failed to load tags: $e');
    }
  }

  /// Get a single entry by ID
  Future<JournalEntry?> getEntryById(String id) async {
    try {
      return await _journalRepository.getEntryById(id);
    } catch (e) {
      _setError('Failed to get entry: $e');
      return null;
    }
  }

  /// Create a new journal entry
  Future<String?> createEntry(JournalEntry entry) async {
    try {
      _setLoading(true);
      _clearError();

      final entryId = await _journalRepository.insertEntry(entry);

      // Reload entries to include the new one
      await loadEntries();

      return entryId;
    } catch (e) {
      _setError('Failed to create entry: $e');
      return null;
    } finally {
      _setLoading(false);
    }
  }

  /// Update an existing journal entry
  Future<bool> updateEntry(JournalEntry entry) async {
    try {
      _setLoading(true);
      _clearError();

      final rowsAffected = await _journalRepository.updateEntry(entry);

      if (rowsAffected > 0) {
        // Reload entries to reflect the update
        await loadEntries();
        return true;
      } else {
        _setError('Entry not found');
        return false;
      }
    } catch (e) {
      _setError('Failed to update entry: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Delete a journal entry
  Future<bool> deleteEntry(String id) async {
    try {
      _setLoading(true);
      _clearError();

      final rowsAffected = await _journalRepository.deleteEntry(id);

      if (rowsAffected > 0) {
        // Reload entries to reflect the deletion
        await loadEntries();
        return true;
      } else {
        _setError('Entry not found');
        return false;
      }
    } catch (e) {
      _setError('Failed to delete entry: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Toggle favorite status of an entry
  Future<bool> toggleFavorite(String id) async {
    try {
      final isFavorite = await _journalRepository.toggleFavorite(id);

      // Update the entry in the local list
      final index = _entries.indexWhere((entry) => entry.id == id);
      if (index >= 0) {
        _entries[index] = _entries[index].copyWith(isFavorite: isFavorite);
        notifyListeners();
      }

      return isFavorite;
    } catch (e) {
      _setError('Failed to toggle favorite: $e');
      return false;
    }
  }

  /// Search entries
  Future<void> searchEntries(String query) async {
    await loadEntries(searchQuery: query);
  }

  /// Filter entries by category
  Future<void> filterByCategory(String? categoryId) async {
    await loadEntries(categoryId: categoryId);
  }

  /// Filter entries by mood
  Future<void> filterByMood(Mood? mood) async {
    await loadEntries(mood: mood);
  }

  /// Filter entries by tags
  Future<void> filterByTags(List<String> tagIds) async {
    await loadEntries(tagIds: tagIds);
  }

  /// Filter favorite entries
  Future<void> filterFavorites() async {
    await loadEntries(isFavorite: true);
  }

  /// Clear all filters
  Future<void> clearFilters() async {
    await loadEntries();
  }

  /// Get statistics
  Future<Map<String, dynamic>> getStatistics() async {
    try {
      return await _journalRepository.getStatistics();
    } catch (e) {
      _setError('Failed to get statistics: $e');
      return {};
    }
  }

  /// Category operations
  Future<String?> createCategory(Category category) async {
    try {
      await _categoryRepository.insertCategory(category);
      await loadCategories();
      return category.id;
    } catch (e) {
      _setError('Failed to create category: $e');
      return null;
    }
  }

  Future<bool> updateCategory(Category category) async {
    try {
      final rowsAffected = await _categoryRepository.updateCategory(category);
      if (rowsAffected > 0) {
        await loadCategories();
        return true;
      }
      return false;
    } catch (e) {
      _setError('Failed to update category: $e');
      return false;
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      await _categoryRepository.deleteCategory(id);
      await loadCategories();
      // Reload entries to update category references
      await loadEntries();
      return true;
    } catch (e) {
      _setError('Failed to delete category: $e');
      return false;
    }
  }

  /// Tag operations
  Future<String?> createTag(Tag tag) async {
    try {
      await _tagRepository.insertTag(tag);
      await loadTags();
      return tag.id;
    } catch (e) {
      _setError('Failed to create tag: $e');
      return null;
    }
  }

  Future<bool> updateTag(Tag tag) async {
    try {
      final rowsAffected = await _tagRepository.updateTag(tag);
      if (rowsAffected > 0) {
        await loadTags();
        return true;
      }
      return false;
    } catch (e) {
      _setError('Failed to update tag: $e');
      return false;
    }
  }

  Future<bool> deleteTag(String id) async {
    try {
      await _tagRepository.deleteTag(id);
      await loadTags();
      // Reload entries to update tag references
      await loadEntries();
      return true;
    } catch (e) {
      _setError('Failed to delete tag: $e');
      return false;
    }
  }

  /// Get entries grouped by date (for calendar view)
  Future<Map<DateTime, List<JournalEntry>>> getEntriesGroupedByDate({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      return await _journalRepository.getEntriesGroupedByDate(
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      _setError('Failed to get entries by date: $e');
      return {};
    }
  }

  /// Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  /// Private helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  /// Get category by ID
  Category? getCategoryById(String id) {
    try {
      return _categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get tag by ID
  Tag? getTagById(String id) {
    try {
      return _tags.firstWhere((tag) => tag.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get tags by IDs
  List<Tag> getTagsByIds(List<String> ids) {
    return _tags.where((tag) => ids.contains(tag.id)).toList();
  }
}