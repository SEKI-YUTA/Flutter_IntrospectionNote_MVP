import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  // シングルトンパターン
  DatabaseHelper._privateConstructor();
  static const _databaseName = 'introspection_note.db';
  static const _databaseVersion = 1;

  static const table = 'notes';

  static const columnId = 'id';
  static const columnDate = 'date';
  static const columnPositiveItems = 'positive_items';
  static const columnImprovementItems = 'improvement_items';
  static const columnDailyComment = 'daily_comment';
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // データベースインスタンス
  static Database? _database;

  // データベースの取得（初回呼び出し時に初期化）
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // データベースの初期化
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // テーブル作成
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId TEXT PRIMARY KEY,
        $columnDate TEXT NOT NULL,
        $columnPositiveItems TEXT NOT NULL,
        $columnImprovementItems TEXT NOT NULL,
        $columnDailyComment TEXT NOT NULL
      )
    ''');
  }

  // データベースを閉じる
  Future<void> close() async {
    final db = await instance.database;
    db.close();
    _database = null;
  }

  Future<void> open() async {
    await instance.database;
  }
}
