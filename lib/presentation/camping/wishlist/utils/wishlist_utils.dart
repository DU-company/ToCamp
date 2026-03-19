import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/like_category_model.dart';

class WishlistUtils {
  static bool checkIsLiked(
    List<LikeCategoryModel> wishlistModels,
    CampingModel targetModel,
  ) {
    for (final wishlistModel in wishlistModels) {
      if (wishlistModel.items.any((c) => c.id == targetModel.id)) {
        return true;
      }
    }
    return false;
  }

  /// 모든 카테고리의 캠핑장들을 쭉 나열 (Map에서 사용)
  static List<CampingModel> extractCampingList(
    List<LikeCategoryModel> categoryList,
  ) {
    List<CampingModel> totalModels = [];
    for (final category in categoryList) {
      totalModels.addAll(category.items);
    }
    return totalModels;
  }
}
