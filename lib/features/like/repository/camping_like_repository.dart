import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/dababase/app_database.dart';
import 'package:to_camp/features/like/data/like_camping_entity.dart';

final likeCampingRepositoryProvider = Provider(
  (ref) => LikeCampingRepository(),
);

class LikeCampingRepository {
  final table = tableLikeCamping;

  Future<int> insertLikeCamping(
    LikeCampingEntity likeCampingEntity,
  ) async {
    final db = await AppDatabase.database;
    return await db.insert(table, likeCampingEntity.toJson());
  }

  Future<List<LikeCampingEntity>> getCampingsByCategory(
    int categoryId,
  ) async {
    final db = await AppDatabase.database;
    final resp = await db.query(
      table,
      where: 'categoryId = ?',
      whereArgs: [categoryId],
      orderBy: 'createdAt DESC', // 최신순
    );
    return resp.map((e) => LikeCampingEntity.fromJson(e)).toList();
  }

  Future<int> deleteLikeCamping({required String campingId}) async {
    final db = await AppDatabase.database;
    return await db.delete(
      table,
      where: 'id = ?',
      whereArgs: [campingId],
    );
  }
}
