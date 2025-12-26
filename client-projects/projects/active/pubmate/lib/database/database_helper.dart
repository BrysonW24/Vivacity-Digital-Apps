import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// Database helper class for managing SQLite database operations
/// Implements singleton pattern for single database instance
class DatabaseHelper {
  static const String _databaseName = 'app.db';
  static const int _databaseVersion = 1;

  // Table names (customize for your app)
  static const String tableItems = 'items';

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  /// Get database instance (creates if doesn't exist)
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initialize database and create tables
  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _createTables,
      onUpgrade: _upgradeDatabase,
    );
  }

  /// Create all database tables
  Future<void> _createTables(Database db, int version) async {
    // TODO: Create your app-specific tables
    // Example:
    // await db.execute('''
    //   CREATE TABLE $tableItems (
    //     id TEXT PRIMARY KEY,
    //     title TEXT NOT NULL,
    //     description TEXT,
    //     created_at TEXT NOT NULL,
    //     updated_at TEXT NOT NULL
    //   )
    // ''');
  }

  /// Handle database upgrades between versions
  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    // TODO: Handle schema changes for version upgrades
    // Example:
    // if (oldVersion < 2) {
    //   await db.execute('ALTER TABLE $tableItems ADD COLUMN category TEXT');
    // }
  }

  /// Insert item into database
  Future<int> insert(String table, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(table, row);
  }

  /// Query all items from table
  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    Database db = await database;
    return await db.query(table);
  }

  /// Query item by ID
  Future<Map<String, dynamic>?> queryById(String table, String id) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      table,
      where: 'id = ?',
      whereArgs: [id],
    );
    return results.isNotEmpty ? results.first : null;
  }

  /// Update item in database
  Future<int> update(String table, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.update(
      table,
      row,
      where: 'id = ?',
      whereArgs: [row['id']],
    );
  }

  /// Delete item from database
  Future<int> delete(String table, String id) async {
    Database db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  /// Close database connection
  Future<void> close() async {
    Database db = await database;
    await db.close();
  }
}
