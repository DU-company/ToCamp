import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:to_camp/core/const/data.dart';

class AppDatabase {
  static Database? _db;

  static deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DB_NAME); // 기존 DB 파일 이름

    await deleteDatabase(path);
    print('Database deleted successfully');
  }

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DB_NAME);

    _db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $TABLE_LIKE_CATEGORY (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL
        )
        ''');

        await db.execute('''
          CREATE TABLE $TABLE_LIKE_CAMPING (
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
            FOREIGN KEY (categoryId) REFERENCES $TABLE_LIKE_CATEGORY(id) ON DELETE CASCADE
          )
          ''');

        await db.execute('''
          CREATE TABLE $TABLE_RECENT_CAMPING (
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
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE $TABLE_RECENT_KEYWORD (
              keyword TEXT PRIMARY KEY,
              createdAt INTEGER NOT NULL
            )
            ''');
        }
      },
      onOpen: (db) async {
        await db.execute('PRAGMA foreign_keys = ON'); // 외래키 활성화
      },
    );

    return _db!;
  }
}
