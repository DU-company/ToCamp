import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/wishlist_model.dart';

class LikeUtils {
  static bool checkIsLiked(
    List<WishlistModel> likeList,
    CampingModel model,
  ) {
    for (final like in likeList) {
      if (like.items.any((c) => c.id == model.id)) {
        return true;
      }
    }
    return false;
  }

  static List<CampingModel> getTotalLike(
    List<WishlistModel> likeModels,
  ) {
    List<CampingModel> totalModels = [];
    for (final likeModel in likeModels) {
      totalModels.addAll(likeModel.items);
    }
    return totalModels;
  }
}
