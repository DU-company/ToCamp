import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const String tableLikeCategory = 'like_categories';
const String tableLikeCamping = 'like_campings';
const String tableRecentCamping = 'recent_campings';
const String dbName = 'tocamp.db';

class AppDatabase {
  static Database? _db;

  static deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName); // 기존 DB 파일 이름

    await deleteDatabase(path);
    print('Database deleted successfully');
  }

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $tableLikeCategory (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
        ''');

        await db.execute('''
          CREATE TABLE $tableLikeCamping (
            id TEXT PRIMARY KEY NOT NULL,
            thumbUrl TEXT NOT NULL,
            name TEXT NOT NULL,
            lineIntro TEXT,
            intro TEXT,
            sbrsCl TEXT,
            posblFcltyCl TEXT,
            doNm TEXT,
            sigunguNm TEXT,
            address TEXT,
            fire TEXT,
            pet TEXT,
            caravan TEXT,
            lng REAL,
            lat REAL,
            resveUrl TEXT,
            homepage TEXT,
            tel TEXT,
            siteBottomCl1 TEXT,
            siteBottomCl2 TEXT,
            siteBottomCl3 TEXT,
            siteBottomCl4 TEXT,
            siteBottomCl5 TEXT,
            createdAt INTEGER NOT NULL,
            categoryId INTEGER NOT NULL,
            FOREIGN KEY (categoryId) REFERENCES $tableLikeCategory(id) ON DELETE CASCADE
          )
          ''');

        await db.execute('''
          CREATE TABLE $tableRecentCamping (
            id TEXT PRIMARY KEY NOT NULL,
            thumbUrl TEXT NOT NULL,
            name TEXT NOT NULL,
            lineIntro TEXT,
            intro TEXT,
            sbrsCl TEXT,
            posblFcltyCl TEXT,
            doNm TEXT,
            sigunguNm TEXT,
            address TEXT,
            fire TEXT,
            pet TEXT,
            caravan TEXT,
            lng REAL,
            lat REAL,
            resveUrl TEXT,
            homepage TEXT,
            tel TEXT,
            siteBottomCl1 TEXT,
            siteBottomCl2 TEXT,
            siteBottomCl3 TEXT,
            siteBottomCl4 TEXT,
            siteBottomCl5 TEXT,
            createdAt INTEGER NOT NULL
          )
          ''');
      },
      // onUpgrade: (db, oldVersion, newVersion) {},
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON'); // 외래키 활성화
      },
    );

    return _db!;
  }
}
