import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/core/service/toast_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/like_category_model.dart';
import 'package:to_camp/data/repositories/wishlist_repository.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/add_category_bottom_sheet.dart';
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
          return SelectWishlistBottomSheet(
            campingModel: campingModel,
            isLiked: isLiked,
          );
        },
      );
    }
  }

  Future<void> onTapCategory({
    required bool isAdding,
    required BuildContext context,
    required LikeCategoryModel wishlistModel,
    CampingModel? campingModel,
  }) async {
    /// 카테고리에 추가하는 상황인지 검토
    if (isAdding) {
      context.pop();
      await repository.addToCategory(
        wishlistModel.categoryId,
        campingModel!,
      );
      getWishlist();

      ref
          .read(toastServiceProvider)
          .showToast(
            text: '"${wishlistModel.categoryName}"에 추가되었습니다',
            isError: false,
          );
    } else {
      context.pushNamed(
        LikeCategoryScreen.routeName,
        pathParameters: {
          'id': '${wishlistModel.categoryId}',
          "name": wishlistModel.categoryName,
        },
      );
    }
  }

  /// 새로운 카테고리 생성 후, 캠핑장 삽입
  Future<void> createCategory(
    BuildContext context,
    CampingModel campingModel,
  ) async {
    try {
      final name = ref.read(likeCategoryNameProvider);
      _validateName(name);

      final wishlist = await repository.createCategory(
        campingModel,
        name,
      );

      /// 상태에 해당 카테고리 추가
      state = [wishlist, ...state];

      ref
          .read(toastServiceProvider)
          .showToast(text: '"$name"에 추가되었습니다', isError: false);
      context.pop();
    } catch (e) {
      ref.read(toastServiceProvider).showToast(text: e.toString());
    }
  }

  Future<void> deleteCategory(LikeCategoryModel model) async {
    await repository.deleteCategory(model.categoryId);
    state = state
        .where((e) => e.categoryId != model.categoryId)
        .toList();
    ref
        .read(toastServiceProvider)
        .showToast(text: '"${model.categoryName}" 카테고리가 삭제되었습니다');
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
