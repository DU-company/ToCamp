import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/dababase/app_database.dart';
import 'package:to_camp/features/camping_recent/entity/recent_camping_entity.dart';

final recentCampingRepositoryProvider = Provider((ref) {
  return RecentCampingRepository();
});

class RecentCampingRepository {
  final table = tableRecentCamping;

  Future<List<RecentCampingEntity>> getRecentCampings() async {
    final db = await AppDatabase.database;

    final resp = await db.query(table, orderBy: 'createdAt DESC');

    return resp.map((e) => RecentCampingEntity.fromJson(e)).toList();
  }

  Future<void> insertRecentCamping(
    RecentCampingEntity recentCampingEntity,
  ) async {
    final db = await AppDatabase.database;
    await db.insert(table, recentCampingEntity.toJson());
  }

  Future<void> deleteRecentCamping(String camingId) async {
    final db = await AppDatabase.database;
    db.delete(table, where: 'id = ?', whereArgs: [camingId]);
  }
}
