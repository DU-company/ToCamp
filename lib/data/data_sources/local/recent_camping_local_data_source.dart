import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/dababase/app_database.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/entities/recent_camping_entity.dart';

final recentCampingLocalDataSourceProvider = Provider((ref) {
  return RecentCampingLocalDataSource();
});

class RecentCampingLocalDataSource {
  final table = TABLE_RECENT_CAMPING;

  Future<List<RecentCampingEntity>> fetchRecentCampingList() async {
    final db = await AppDatabase.database;

    final resp = await db.query(table, orderBy: 'createdAt DESC');

    return resp.map((e) => RecentCampingEntity.fromJson(e)).toList();
  }

  Future<void> insertRecentCamping(CampingModel model) async {
    final db = await AppDatabase.database;
    final entity = RecentCampingEntity.fromCampingModel(model: model);

    /// 30 초과분 삭제
    await _deleteByOverflow(db, entity.id);
    await db.insert(
      table,
      entity.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteRecentCamping(String id) async {
    final db = await AppDatabase.database;
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  /// 초과분에 의한 삭제
  Future<void> _deleteByOverflow(Database db, String id) async {
    final countResp = await db.rawQuery(
      '''
      SELECT COUNT(*) FROM $table
      WHERE id <> ?
      ''',
      [id],
    );
    final length = Sqflite.firstIntValue(countResp) ?? 0;

    if (length > 30) {
      await db.rawDelete('''
      DELETE FROM $table
      WHERE id = (
        SELECT id FROM $table
        ORDER BY createdAt ASC
        LIMIT 1
      ) 
      ''');
    }
  }
}
