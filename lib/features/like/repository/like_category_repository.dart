import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/dababase/app_database.dart';
import 'package:to_camp/features/like/entity/like_category_entity.dart';

final likeCategoryRepositoryProvider = Provider(
  (ref) => LikeCategoryRepository(),
);

class LikeCategoryRepository {
  final table = tableLikeCategory;

  Future<List<LikeCategoryEntity>> getCategories() async {
    final db = await AppDatabase.database;
    final resp = await db.query(table, orderBy: 'id DESC');
    return resp.map((e) => LikeCategoryEntity.fromJson(e)).toList();
  }

  Future<int> insertCategory(
    LikeCategoryEntity likeCategoryEntity,
  ) async {
    final db = await AppDatabase.database;
    return await db.insert(table, likeCategoryEntity.toJson());
  }

  Future<int> deleteCategory(int id) async {
    final db = await AppDatabase.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
