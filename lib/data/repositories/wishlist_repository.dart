import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/data_sources/local/wishlist_camping_local_data_source.dart';
import 'package:to_camp/data/entities/like_camping_entity.dart';
import 'package:to_camp/data/entities/like_category_entity.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/like_category_model.dart';

final wishlistRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(wishlistLocalDataSourceProvider);
  return WishlistRepository(dataSource);
});

class WishlistRepository {
  final WishlistLocalDataSource dataSource;

  WishlistRepository(this.dataSource);

  Future<List<LikeCategoryModel>> getAllCategories() async {
    /// 카테고리 먼저 가져온 후
    final categories = await dataSource.fetchAllCategories();

    List<LikeCategoryModel> items = [];
    for (final category in categories) {
      /// 각 카테고리에 속해있는 캠핑장 리스트를 받아온다.
      final campingList = await dataSource.fetchLikeCampingList(
        categoryId: category.id!,
      );

      /// Model로 파싱
      final item = LikeCategoryModel.fromQuery(category, campingList);
      items.add(item);
    }

    return items;
  }

  /// 새로운 카테고리 생성 후 캠핑장 까지 삽입
  Future<LikeCategoryModel> createCategory(
    CampingModel campingModel,
    String name,
  ) async {
    final id = await _createCategory(name);
    await addToCategory(id, campingModel);
    return LikeCategoryModel(
      categoryId: id,
      categoryName: name,
      items: [campingModel],
    );
  }

  /// 새로운 카테고리 생성
  Future<int> _createCategory(String name) async {
    final entity = LikeCategoryEntity(name: name);
    final id = await dataSource.insertCategory(entity);
    return id;
  }

  Future<void> deleteCategory(int categoryId) async {
    await dataSource.deleteCategory(categoryId);
  }

  /// 특정 카테고리에 캠핑장 추가
  Future<void> addToCategory(
    int categoryId,
    CampingModel model,
  ) async {
    final entity = LikeCampingEntity.fromCampingModel(
      categoryId: categoryId,
      model: model,
    );
    await dataSource.insertLikeCamping(entity);
  }

  Future<void> removeFromCategory(String campingId) async {
    await dataSource.deleteLikeCamping(campingId: campingId);
  }
}
