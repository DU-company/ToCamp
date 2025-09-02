import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/model/camping_like_model.dart';

class LikeUtils {
  static bool checkIsLiked(
    List<CampingLikeModel> likeList,
    CampingModel model,
  ) {
    for (final like in likeList) {
      if (like.campingModels.any((c) => c.id == model.id)) {
        return true;
      }
    }
    return false;
  }

  static List<CampingModel> getTotalLike(
    List<CampingLikeModel> likeModels,
  ) {
    List<CampingModel> totalModels = [];
    for (final likeModel in likeModels) {
      totalModels.addAll(likeModel.campingModels);
    }
    return totalModels;
  }
}
