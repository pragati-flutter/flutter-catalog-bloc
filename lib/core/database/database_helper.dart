import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(''' 
         CREATE TABLE products(
         id INTEGER PRIMARY KEY,
         title TEXT,
         description TEXT,
         price REAL,
         thumbnail TEXT,
         
         
         )
         
         ''');
        await db.execute('''CREATE TABLE cart(
        id INTEGER PRIMARY KEY
        title TEXT,
        price REAL,
        thumbnail TEXT,
        quantity TEXT
        
        
        ) ''');
      },
    );
  }
}
