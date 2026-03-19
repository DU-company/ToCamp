import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/entities/like_camping_entity.dart';
import 'package:to_camp/data/entities/like_category_entity.dart';

/// 화면에 보여줄 카테고리 덩어리
class LikeCategoryModel {
  final int categoryId;
  final String categoryName;
  final List<CampingModel> items;

  LikeCategoryModel({
    required this.categoryId,
    required this.categoryName,
    required this.items,
  });

  factory LikeCategoryModel.fromQuery(
    LikeCategoryEntity category,
    List<LikeCampingEntity> likedItems,
  ) {
    final campingModels = likedItems
        .map((e) => e.toCampingModel())
        .toList();

    return LikeCategoryModel(
      categoryId: category.id!,
      categoryName: category.name,
      items: campingModels,
    );
  }
}
