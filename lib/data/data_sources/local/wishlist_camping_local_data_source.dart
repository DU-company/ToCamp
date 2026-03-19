import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/dababase/app_database.dart';
import 'package:to_camp/data/entities/like_camping_entity.dart';
import 'package:to_camp/data/entities/like_category_entity.dart';

final wishlistLocalDataSourceProvider = Provider(
  (ref) => WishlistLocalDataSource(),
);

class WishlistLocalDataSource {
  final categoryTable = TABLE_LIKE_CATEGORY;
  final campingTable = TABLE_LIKE_CAMPING;

  ///=========================Category=========================

  /// 모든 카테고리 목록 가져오기
  Future<List<LikeCategoryEntity>> fetchAllCategories() async {
    final db = await AppDatabase.database;
    final resp = await db.query(categoryTable, orderBy: 'id DESC');
    return resp.map((e) => LikeCategoryEntity.fromJson(e)).toList();
  }

  /// 새로운 카테고리 생성
  Future<int> insertCategory(
    LikeCategoryEntity categoryEntity,
  ) async {
    final db = await AppDatabase.database;
    return await db.insert(categoryTable, categoryEntity.toJson());
  }

  /// 카테고리 "이름" 수정
  Future<void> updateCategory({
    required int categoryId,
    required String name,
  }) async {
    final db = await AppDatabase.database;
    await db.update(
      categoryTable,
      {'name': name},
      where: 'id = ?',
      whereArgs: [categoryId],
    );
  }

  /// 카테고리 삭제
  Future<int> deleteCategory(int categoryId) async {
    final db = await AppDatabase.database;
    return await db.delete(
      categoryTable,
      where: 'id = ?',
      whereArgs: [categoryId],
    );
  }

  /// =========================Items============================

  Future<List<LikeCampingEntity>> fetchLikeCampingList({
    required int categoryId,
  }) async {
    final db = await AppDatabase.database;
    final resp = await db.query(
      campingTable,
      where: 'categoryId = ?',
      whereArgs: [categoryId],
      orderBy: 'createdAt DESC', // 최신순
    );
    return resp.map((e) => LikeCampingEntity.fromJson(e)).toList();
  }

  /// 특정 카테고리에 캠핑장 추가
  Future<int> insertLikeCamping(LikeCampingEntity entity) async {
    final db = await AppDatabase.database;
    return await db.insert(campingTable, entity.toJson());
  }

  Future<int> deleteLikeCamping({required String campingId}) async {
    final db = await AppDatabase.database;
    final resp = await db.delete(
      campingTable,
      where: 'id = ?',
      whereArgs: [campingId],
    );
    return resp;
  }
}
