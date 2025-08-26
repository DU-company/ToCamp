import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/data/like_category_entity.dart';
import 'package:to_camp/features/like/model/camping_like_model.dart';
import 'package:to_camp/features/like/data/like_camping_entity.dart';
import 'package:to_camp/features/like/repository/camping_like_repository.dart';
import 'package:to_camp/features/like/repository/like_category_repository.dart';

final campingLikeServiceProvider = Provider((ref) {
  final likeCategoryRepository = ref.watch(
    likeCategoryRepositoryProvider,
  );
  final likeCampingRepository = ref.watch(
    likeCampingRepositoryProvider,
  );
  return CampingLikeService(
    ref: ref,
    likeCampingRepository: likeCampingRepository,
    likeCategoryRepository: likeCategoryRepository,
  );
});

class CampingLikeService {
  final Ref ref;
  final LikeCampingRepository likeCampingRepository;
  final LikeCategoryRepository likeCategoryRepository;

  CampingLikeService({
    required this.ref,
    required this.likeCampingRepository,
    required this.likeCategoryRepository,
  });

  // deleteDB() async {
  //   await AppDatabase.deleteDB();
  // }

  Future<List<CampingLikeModel>> getAllData() async {
    final categories = await likeCategoryRepository.getCategories();

    List<CampingLikeModel> models = [];

    /// 받아온 Category들을 기반으로 Looping
    for (final likeCategory in categories) {
      final resp = await likeCampingRepository.getCampingsByCategory(
        likeCategory.id!,
      );

      /// Parsing
      final campingModels = resp
          .map((e) => e.toCampingModel())
          .toList();

      models.add(
        CampingLikeModel(
          likeCategory: likeCategory,
          campingModels: campingModels,
        ),
      );
    }
    return models;
  }

  /// 새로운 카테고리를 만들어 캠핑장까지 저장
  Future<List<CampingLikeModel>> createCategoryAndAdd(
    String name,
    CampingModel campingModel,
  ) async {
    final categoryId = await createCategory(name);
    await addToCategory(categoryId, campingModel);
    return getAllData();
  }

  Future<int> createCategory(String name) async {
    final likeCategory = LikeCategoryEntity(null, name);
    final id = await likeCategoryRepository.insertCategory(
      likeCategory,
    );
    return id;
  }

  Future<List<CampingLikeModel>> deleteCategory(
    int categoryId,
  ) async {
    await likeCategoryRepository.deleteCategory(categoryId);
    return getAllData();
  }

  Future<List<CampingLikeModel>> addToCategory(
    int categoryId,
    CampingModel campingModel,
  ) async {
    final likeCampingEntity = LikeCampingEntity.fromCampingModel(
      model: campingModel,
      categoryId: categoryId,
    );
    await likeCampingRepository.insertLikeCamping(likeCampingEntity);
    return getAllData();
  }

  Future<List<CampingLikeModel>> removeFromCategory({
    required String campingId,
    // required int categoryId,
  }) async {
    await likeCampingRepository.deleteLikeCamping(
      campingId: campingId,
      // categoryId: categoryId,
    );
    final categories = await getAllData();
    final emptyCategories = categories.where(
      (c) => c.campingModels.isEmpty,
    );

    for (final category in emptyCategories) {
      final categoryId = category.likeCategory.id;
      if (categoryId != null) {
        await deleteCategory(categoryId);
      }
    }

    return getAllData();
  }
}
