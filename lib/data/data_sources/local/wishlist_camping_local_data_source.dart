import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/dababase/app_database.dart';
import 'package:to_camp/data/entities/wishlist_camping_entity.dart';
import 'package:to_camp/data/entities/wishlist_category_entity.dart';

final wishlistLocalDataSourceProvider = Provider(
  (ref) => WishlistLocalDataSource(),
);

class WishlistLocalDataSource {
  final categoryTable = TABLE_WISHLIST_CATEGORY;
  final campingTable = TABLE_WISHLIST_CAMPING;

  ///==================================Category=====================================

  /// 모든 카테고리 목록 가져오기
  Future<List<WishlistCategoryEntity>> fetchCategories() async {
    final db = await AppDatabase.database;
    final resp = await db.query(categoryTable, orderBy: 'id DESC');
    return resp
        .map((e) => WishlistCategoryEntity.fromJson(e))
        .toList();
  }

  /// 새로운 카테고리 생성
  Future<int> insertCategory(
    WishlistCategoryEntity wishlistCategory,
  ) async {
    final db = await AppDatabase.database;
    return await db.insert(categoryTable, wishlistCategory.toJson());
  }

  /// 카테고리 삭제
  Future<int> deleteCategory(int id) async {
    final db = await AppDatabase.database;
    return await db.delete(
      categoryTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// ==================================Items=====================================

  Future<List<WishlistCampingEntity>> fetchWishlistByCategory({
    required int categoryId,
  }) async {
    final db = await AppDatabase.database;
    final resp = await db.query(
      campingTable,
      where: 'categoryId = ?',
      whereArgs: [categoryId],
      orderBy: 'createdAt DESC', // 최신순
    );
    return resp
        .map((e) => WishlistCampingEntity.fromJson(e))
        .toList();
  }

  /// 특정 카테고리에 캠핑장 추가
  Future<int> insertWishlistCamping(
    WishlistCampingEntity wishlistCamping,
  ) async {
    final db = await AppDatabase.database;
    return await db.insert(campingTable, wishlistCamping.toJson());
  }

  Future<int> deleteWishlistCamping({
    required String campingId,
  }) async {
    final db = await AppDatabase.database;
    final resp = await db.delete(
      campingTable,
      where: 'id = ?',
      whereArgs: [campingId],
    );
    return resp;
  }
}
