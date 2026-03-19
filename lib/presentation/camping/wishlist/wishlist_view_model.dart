import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/core/service/toast_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/like_category_model.dart';
import 'package:to_camp/data/repositories/wishlist_repository.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/category_form_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/select_category_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/like_category_screen.dart';

/// Notice : Wishlist == List<LikeCategoryModel>

final wishlistViewModelProvider = NotifierProvider(
  () => WishlistViewModel(),
);

class WishlistViewModel extends Notifier<List<LikeCategoryModel>> {
  WishlistRepository get repository =>
      ref.read(wishlistRepositoryProvider);

  @override
  List<LikeCategoryModel> build() {
    state = [];
    getWishlist();
    return state;
  }

  Future<void> getWishlist() async {
    final resp = await repository.getAllCategories();
    state = resp;
  }

  void onLikePressed({
    required BuildContext context,
    required bool isLiked,
    required CampingModel campingModel,
  }) async {
    if (isLiked) {
      /// 이미 좋아요가 눌러져있으면 삭제
      await repository.removeFromCategory(campingModel.id);
      // 새로 데이터를 받아온다.
      getWishlist();
    } else {
      /// 카테고리 선택
      showModalBottomSheet(
        isScrollControlled: true,
        useSafeArea: true,
        context: context,
        builder: (context) {
          return SelectCategoryBottomSheet(
            campingModel: campingModel,
            isLiked: isLiked,
          );
        },
      );
    }
  }

  Future<void> addToCategory({
    required int categoryId,
    required CampingModel campingModel,
  }) async {
    await repository.addToCategory(categoryId, campingModel);
    getWishlist();
  }

  /// 새로운 카테고리 생성 후, 캠핑장 삽입
  Future<void> createCategory({
    required String name,
    required CampingModel campingModel,
  }) async {
    _validateName(name);

    final newCategory = await repository.createCategory(
      campingModel,
      name,
    );

    /// 상태에 해당 카테고리 추가
    state = [newCategory, ...state];
  }

  Future<void> editCategoryName({
    required int categoryId,
    required String name,
  }) async {
    _validateName(name);

    await repository.updateCategory(
      categoryId: categoryId,
      name: name,
    );

    final newItems = state.map(
      (e) => e.id == categoryId ? e.copyWith(name: name) : e,
    );

    /// 상태에 변경된 카테고리 적용
    state = [...newItems];
  }

  Future<void> deleteCategory(LikeCategoryModel model) async {
    await repository.deleteCategory(model.id);
    state = state.where((e) => e.id != model.id).toList();

    ToastService.show(text: '"${model.name}" 카테고리가 삭제되었습니다');
  }

  void _validateName(String name) {
    if (name.trim().length < 2) {
      throw '2글자 이상을 입력해 주세요';
    }
    if (name.length > 21) {
      throw '20자 이하로 작성해 주세요';
    }
  }
}
