import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'bank_accounts.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bank_accounts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category TEXT,
        account_number TEXT,
        iban TEXT,
        relation TEXT,
        phone_number TEXT,
        account_holder_name TEXT,
        bank_name TEXT,
        favorite INTEGER DEFAULT 0
      )
    ''');
  }

  Future<List<Map<String, dynamic>>> queryAllBankAccounts() async {
    Database db = await database;
    return await db.query('bank_accounts');
  }

  Future<void> insertBankAccount(Map<String, dynamic> account) async {
    Database db = await database;
    await db.insert('bank_accounts', account);
  }

  Future<void> deleteBankAccount(int id) async {
    Database db = await database;
    await db.delete('bank_accounts', where: 'id = ?', whereArgs: [id]);
  }

Future<List<Map<String, dynamic>>> queryFavoriteAccounts() async {
    final db = await database;
    return await db.query(
      'bank_accounts',
      where: 'favorite = ?',
      whereArgs: [1],
    );
  }

  Future<void> updateFavoriteStatus(int id, bool isFavorite) async {
    final db = await database;
    await db.update(
      'bank_accounts',
      {'favorite': isFavorite ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
