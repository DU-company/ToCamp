import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/entities/wishlist_camping_entity.dart';
import 'package:to_camp/data/entities/wishlist_category_entity.dart';

/// 화면에 보여줄 카테고리 덩어리
class WishlistModel {
  // final WishlistCategoryEntity likeCategory;
  final int id;
  final String name;
  final List<CampingModel> items;

  WishlistModel({
    // required this.likeCategory,
    required this.id,
    required this.name,
    required this.items,
  });

  factory WishlistModel.fromQuery(
    WishlistCategoryEntity wishlistCategory,
    List<WishlistCampingEntity> wishlistCampings,
  ) {
    final campingModels = wishlistCampings
        .map((e) => e.toCampingModel())
        .toList();

    return WishlistModel(
      // likeCategory: likeCategory,
      id: wishlistCategory.id!,
      name: wishlistCategory.name,
      items: campingModels,
    );
  }
}
