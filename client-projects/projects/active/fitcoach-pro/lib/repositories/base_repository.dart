/// Base repository class for data access layer
/// Provides common CRUD operations pattern
abstract class BaseRepository<T> {
  /// Create (insert) item
  Future<T> create(T item);

  /// Read (query) item by ID
  Future<T?> getById(String id);

  /// Read (query) all items
  Future<List<T>> getAll();

  /// Update item
  Future<bool> update(T item);

  /// Delete item by ID
  Future<bool> delete(String id);

  /// Delete all items
  Future<bool> deleteAll();
}

/// Example implementation (customize for your app):
///
/// ```dart
/// import 'package:uuid/uuid.dart';
/// import '../database/database_helper.dart';
/// import '../models/item_model.dart';
///
/// class ItemRepository implements BaseRepository<ItemModel> {
///   final DatabaseHelper _dbHelper = DatabaseHelper.instance;
///   static const String _tableName = 'items';
///
///   @override
///   Future<ItemModel> create(ItemModel item) async {
///     final id = const Uuid().v4();
///     final itemWithId = item.copyWith(id: id);
///     await _dbHelper.insert(_tableName, itemWithId.toMap());
///     return itemWithId;
///   }
///
///   @override
///   Future<ItemModel?> getById(String id) async {
///     final result = await _dbHelper.queryById(_tableName, id);
///     return result != null ? ItemModel.fromMap(result) : null;
///   }
///
///   @override
///   Future<List<ItemModel>> getAll() async {
///     final results = await _dbHelper.queryAll(_tableName);
///     return results.map((map) => ItemModel.fromMap(map)).toList();
///   }
///
///   @override
///   Future<bool> update(ItemModel item) async {
///     final rowsAffected = await _dbHelper.update(_tableName, item.toMap());
///     return rowsAffected > 0;
///   }
///
///   @override
///   Future<bool> delete(String id) async {
///     final rowsAffected = await _dbHelper.delete(_tableName, id);
///     return rowsAffected > 0;
///   }
///
///   @override
///   Future<bool> deleteAll() async {
///     final db = await _dbHelper.database;
///     await db.delete(_tableName);
///     return true;
///   }
/// }
/// ```
