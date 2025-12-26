import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/journal_entry.dart';

/// Database helper class for managing SQLite database operations
class DatabaseHelper {
  static const String _databaseName = 'journal_app.db';
  static const int _databaseVersion = 1;

  // Table names
  static const String tableEntries = 'journal_entries';
  static const String tableCategories = 'categories';
  static const String tableTags = 'tags';

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
    // Create journal entries table
    await db.execute('''
      CREATE TABLE $tableEntries (
        id TEXT PRIMARY KEY,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        mood INTEGER,
        category_id TEXT,
        tags TEXT,
        is_favorite INTEGER DEFAULT 0,
        image_path TEXT,
        FOREIGN KEY (category_id) REFERENCES $tableCategories (id) ON DELETE SET NULL
      )
    ''');

    // Create categories table
    await db.execute('''
      CREATE TABLE $tableCategories (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        description TEXT,
        color INTEGER NOT NULL,
        icon_name TEXT,
        created_at TEXT NOT NULL
      )
    ''');

    // Create tags table
    await db.execute('''
      CREATE TABLE $tableTags (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL UNIQUE,
        color INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Create indexes for better performance
    await db.execute('CREATE INDEX idx_entries_created_at ON $tableEntries(created_at)');
    await db.execute('CREATE INDEX idx_entries_category ON $tableEntries(category_id)');
    await db.execute('CREATE INDEX idx_entries_favorite ON $tableEntries(is_favorite)');
    await db.execute('CREATE INDEX idx_categories_name ON $tableCategories(name)');
    await db.execute('CREATE INDEX idx_tags_name ON $tableTags(name)');
  }

  /// Handle database upgrades
  Future<void> _upgradeDatabase(Database db, int oldVersion, int newVersion) async {
    // Handle future database migrations here
    // For now, just recreate tables (data will be lost)
    if (oldVersion < newVersion) {
      await db.execute('DROP TABLE IF EXISTS $tableEntries');
      await db.execute('DROP TABLE IF EXISTS $tableCategories');
      await db.execute('DROP TABLE IF EXISTS $tableTags');
      await _createTables(db, newVersion);
    }
  }

  /// Close database connection
  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
  }

  /// Get database path (for backup/export operations)
  Future<String> getDatabasePath() async {
    return join(await getDatabasesPath(), _databaseName);
  }
}