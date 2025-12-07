import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/wishlist_model.dart';

class WishlistUtils {
  static bool checkIsLiked(
    List<WishlistModel> wishlistModels,
    CampingModel targetModel,
  ) {
    for (final wishlistModel in wishlistModels) {
      if (wishlistModel.items.any((c) => c.id == targetModel.id)) {
        return true;
      }
    }
    return false;
  }

  /// WishlistModel -> CampingModel 추출
  static List<CampingModel> extractCampingList(
    List<WishlistModel> wishlistModels,
  ) {
    List<CampingModel> totalModels = [];
    for (final wishlistModel in wishlistModels) {
      totalModels.addAll(wishlistModel.items);
    }
    return totalModels;
  }
}
