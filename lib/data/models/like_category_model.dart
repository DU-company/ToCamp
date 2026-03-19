import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/entities/like_camping_entity.dart';
import 'package:to_camp/data/entities/like_category_entity.dart';

/// 화면에 보여줄 카테고리 덩어리
class LikeCategoryModel {
  final int id;
  final String name;
  final List<CampingModel> items;

  LikeCategoryModel({
    required this.id,
    required this.name,
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
      id: category.id!,
      name: category.name,
      items: campingModels,
    );
  }

  LikeCategoryModel copyWith({
    String? name,
    List<CampingModel>? items,
  }) {
    return LikeCategoryModel(
      id: id,
      name: name ?? this.name,
      items: items ?? this.items,
    );
  }
}
