import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/dababase/app_database.dart';
import 'package:to_camp/data/entities/wishlist_camping_entity.dart';
import 'package:to_camp/data/entities/wishlist_entity.dart';

final wishlistLocalDataSourceProvider = Provider(
  (ref) => WishlistLocalDataSource(),
);

class WishlistLocalDataSource {
  final wishlistTable = TABLE_WISHLIST_CATEGORY;
  final campingTable = TABLE_WISHLIST_CAMPING;

  ///=========================Wishlist=========================

  /// 모든 위시리스트 목록 가져오기
  Future<List<WishlistEntity>> fetchAllWishlist() async {
    final db = await AppDatabase.database;
    final resp = await db.query(wishlistTable, orderBy: 'id DESC');
    return resp.map((e) => WishlistEntity.fromJson(e)).toList();
  }

  /// 새로운 카테고리 생성
  Future<int> insertWishlist(WishlistEntity wishlistCategory) async {
    final db = await AppDatabase.database;
    return await db.insert(wishlistTable, wishlistCategory.toJson());
  }

  /// 카테고리 삭제
  Future<int> deleteWishlist(int id) async {
    final db = await AppDatabase.database;
    return await db.delete(
      wishlistTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// =========================Items============================

  Future<List<WishlistCampingEntity>> fetchCampingList({
    required int wishlistId,
  }) async {
    final db = await AppDatabase.database;
    final resp = await db.query(
      campingTable,
      where: 'categoryId = ?',
      whereArgs: [wishlistId],
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
