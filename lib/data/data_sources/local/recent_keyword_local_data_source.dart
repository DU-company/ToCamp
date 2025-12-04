import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:collection/collection.dart';
import 'package:to_camp/core/dababase/app_database.dart';
import 'package:to_camp/data/entities/recent_keyword_entity.dart';
import 'package:to_camp/data/models/recent_keyword_model.dart';

final recentKeywordLocalDataSourceProvider = Provider((ref) {
  return RecentKeywordLocalDataSource();
});

class RecentKeywordLocalDataSource {
  final table = tableRecentKeyword;

  Future<List<RecentKeywordEntity>> fetchKeywords() async {
    final db = await AppDatabase.database;

    final resp = await db.query(
      tableRecentKeyword,
      orderBy: 'createdAt DESC',
    );
    return resp.map((e) => RecentKeywordEntity.fromJson(e)).toList();
  }

  Future<void> insertKeyword(RecentKeywordModel model) async {
    final db = await AppDatabase.database;

    await _deleteByOverflow(db, model.keyword);

    final entity = RecentKeywordEntity.fromModel(model);
    await db.insert(
      table,
      entity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    // db.transaction((txn) async {});
  }

  Future<void> deleteKeyword(String keyword) async {
    final db = await AppDatabase.database;

    await db.delete(
      table,
      where: 'keyword = ?',
      whereArgs: [keyword],
    );
  }

  Future<void> _deleteByOverflow(Database db, String keyword) async {
    final countResp = await db.rawQuery(
      '''
        SELECT COUNT(*) FROM $table
        WHERE keyword <> ?
        ''',
      [keyword],
    );
    final currentLength = Sqflite.firstIntValue(countResp) ?? 0;

    /// 현재 데이터 + 1이 10보다 크면
    /// 마지막 데이터 한 개를 지운다.
    if (currentLength + 1 > 10) {
      await db.rawDelete('''
        DELETE FROM $table
        WHERE keyword IN (
          SELECT keyword FROM $table
          ORDER BY createdAt ASC
          LIMIT 1  
        )
      ''');
    }
  }
}
