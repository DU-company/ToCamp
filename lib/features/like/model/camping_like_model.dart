import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/data/like_camping_entity.dart';
import 'package:to_camp/features/like/data/like_category_entity.dart';

class CampingLikeModel {
  final LikeCategoryEntity likeCategory;
  final List<CampingModel> campingModels;

  CampingLikeModel({
    required this.likeCategory,
    required this.campingModels,
  });

  factory CampingLikeModel.fromQuery(
    LikeCategoryEntity likeCategory,
    List<LikeCampingEntity> likeCampings,
  ) {
    final campingModels = likeCampings
        .map((e) => e.toCampingModel())
        .toList();

    return CampingLikeModel(
      likeCategory: likeCategory,
      campingModels: campingModels,
    );
  }
}
