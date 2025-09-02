import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/dababase/app_database.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/entity/like_camping_entity.dart';
import 'package:to_camp/features/like/entity/like_category_entity.dart';
import 'package:to_camp/features/like/model/camping_like_model.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';
import 'package:to_camp/features/like/repository/like_camping_repository.dart';
import 'package:to_camp/features/like/repository/like_category_repository.dart';
import 'package:to_camp/features/like/view/component/bottom_sheet/select_category_bottom_sheet.dart';

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

  deleteDB() async {
    await AppDatabase.deleteDB();
  }

  Future<List<CampingLikeModel>> getAllData() async {
    final categories = await likeCategoryRepository.getCategories();

    List<CampingLikeModel> models = [];

    /// 받아온 Category들을 기반으로 Looping
    for (final likeCategory in categories) {
      final resp = await likeCampingRepository.getCampingsByCategory(
        categoryId: likeCategory.id!,
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
  }) async {
    await likeCampingRepository.deleteLikeCamping(
      campingId: campingId,
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

  void onLikePressed({
    required BuildContext context,
    required bool isLiked,
    required CampingModel campingModel,
  }) {
    EasyThrottle.throttle('onLikePressed', Duration(seconds: 1), () {
      try {
        if (isLiked) {
          ref
              .read(campingLikeProvider.notifier)
              .removeFromCategory(campingModel);
          ref
              .read(toastUtilsProvider)
              .showToast(text: '위시리스트에서 삭제되었습니다.');
        } else {
          showModalBottomSheet(
            scrollControlDisabledMaxHeightRatio: 0.5,
            isScrollControlled: true,
            useSafeArea: true,
            context: context,
            builder: (context) => SelectCategoryBottomSheet(
              campingModel: campingModel,
              isLiked: isLiked,
            ),
          );
        }
      } catch (e) {
        ref
            .read(toastUtilsProvider)
            .showToast(text: '위시리스트에 추가할 수 없습니다.');
      }
    });
  }
}
