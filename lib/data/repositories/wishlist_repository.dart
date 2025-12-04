import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/data_sources/local/wishlist_camping_local_data_source.dart';
import 'package:to_camp/data/entities/wishlist_camping_entity.dart';
import 'package:to_camp/data/entities/wishlist_category_entity.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/wishlist_model.dart';

final wishlistRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(wishlistLocalDataSourceProvider);
  return WishlistRepository(dataSource);
});

class WishlistRepository {
  final WishlistLocalDataSource dataSource;

  WishlistRepository(this.dataSource);

  Future<List<WishlistModel>> getWishlist() async {
    /// 카테고리 먼저 가져온 후
    final categories = await dataSource.fetchCategories();

    List<WishlistModel> items = [];
    for (final category in categories) {
      /// 각 카테고리에 속해있는 캠핑장 리스트를 받아온다.
      final campingList = await dataSource.fetchWishlistByCategory(
        categoryId: category.id!,
      );

      /// 데이터 저장
      final item = WishlistModel.fromQuery(category, campingList);
      items.add(item);
    }

    return items;
  }

  /// 카테고리 생성 후 캠핑장 까지 삽입
  Future<WishlistModel> createWishlist(
    CampingModel campingModel,
    String name,
  ) async {
    final id = await _createCategory(name);
    await addToCategory(id, campingModel);
    return WishlistModel(id: id, name: name, items: [campingModel]);
  }

  /// 새로운 카테고리 생성
  Future<int> _createCategory(String name) async {
    final entity = WishlistCategoryEntity(name: name);
    final id = await dataSource.insertCategory(entity);
    return id;
  }

  Future<void> deleteCategory(int id) async {
    await dataSource.deleteCategory(id);
  }

  /// 특정 카테고리에 캠핑장 추가
  Future<void> addToCategory(
    int categoryId,
    CampingModel model,
  ) async {
    final entity = WishlistCampingEntity.fromCampingModel(
      model: model,
      categoryId: categoryId,
    );
    await dataSource.insertWishlistCamping(entity);
  }

  Future<void> removeFromCategory(String id) async {
    await dataSource.deleteWishlistCamping(campingId: id);
  }
}
