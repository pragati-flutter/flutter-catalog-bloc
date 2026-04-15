import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  /// Singleton DB instance
  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  ///  Initialize DB
  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'app.db');

    return await openDatabase(
      path,
      version: 1,

      onCreate: (db, version) async {
        print(" DB CREATED");
        await _createTables(db);
      },

      onUpgrade: (db, oldVersion, newVersion) async {
        print(" DB UPGRADED");

        await db.execute("DROP TABLE IF EXISTS products");
        await db.execute("DROP TABLE IF EXISTS cart");

        await _createTables(db);
      },
    );
  }

  ///  Centralized table creation
  Future<void> _createTables(Database db) async {
    await db.execute('''
      CREATE TABLE products (
     id INTEGER PRIMARY KEY,
      title TEXT,
      description TEXT,
      price REAL,
     images TEXT,
      localImagePath TEXT
)
    ''');

    await db.execute('''   
      CREATE TABLE cart(
        id INTEGER PRIMARY KEY,
        title TEXT,
        price REAL,
        images TEXT,
        quantity INTEGER
      )
    ''');

    print(" TABLES CREATED");
  }
}
