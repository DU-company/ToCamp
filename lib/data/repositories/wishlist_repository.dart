import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/data_sources/local/wishlist_camping_local_data_source.dart';
import 'package:to_camp/data/entities/wishlist_camping_entity.dart';
import 'package:to_camp/data/entities/wishlist_entity.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/wishlist_model.dart';

final wishlistRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(wishlistLocalDataSourceProvider);
  return WishlistRepository(dataSource);
});

class WishlistRepository {
  final WishlistLocalDataSource dataSource;

  WishlistRepository(this.dataSource);

  Future<List<WishlistModel>> getAllWishlist() async {
    /// 카테고리 먼저 가져온 후
    final wishlists = await dataSource.fetchAllWishlist();

    List<WishlistModel> items = [];
    for (final wishlist in wishlists) {
      /// 각 카테고리에 속해있는 캠핑장 리스트를 받아온다.
      final campingList = await dataSource.fetchCampingList(
        wishlistId: wishlist.id!,
      );

      /// 데이터 저장
      final item = WishlistModel.fromQuery(wishlist, campingList);
      items.add(item);
    }

    return items;
  }

  /// 새로운 위시리스트 생성 후 캠핑장 까지 삽입
  Future<WishlistModel> createWishlist(
    CampingModel campingModel,
    String name,
  ) async {
    final id = await _createWishlist(name);
    await addToWishlist(id, campingModel);
    return WishlistModel(id: id, name: name, items: [campingModel]);
  }

  /// 새로운 위시리스트 생성
  Future<int> _createWishlist(String name) async {
    final entity = WishlistEntity(name: name);
    final id = await dataSource.insertWishlist(entity);
    return id;
  }

  Future<void> deleteWishlist(int id) async {
    await dataSource.deleteWishlist(id);
  }

  /// 특정 위시리스트에 캠핑장 추가
  Future<void> addToWishlist(
    int wishlistId,
    CampingModel model,
  ) async {
    final entity = WishlistCampingEntity.fromCampingModel(
      categoryId: wishlistId,
      model: model,
    );
    await dataSource.insertWishlistCamping(entity);
  }

  Future<void> removeFromWishlist(String id) async {
    await dataSource.deleteWishlistCamping(campingId: id);
  }
}
