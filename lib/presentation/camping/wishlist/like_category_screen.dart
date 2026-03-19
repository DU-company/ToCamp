import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/data/models/like_category_model.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/add_category_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/wishlist_options_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/dialog/delete_wishlist_confirm_dialog.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:collection/collection.dart';

class LikeCategoryScreen extends ConsumerWidget {
  static String get routeName => 'like-category';

  final String id;
  final String name;
  const LikeCategoryScreen({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistViewModelProvider);

    final category = wishlist.firstWhereOrNull(
      (e) => e.categoryId.toString() == id,
    );

    final likedItems = category?.items;

    return CampingScreen(
      items: likedItems ?? [],
      title: name,
      emptyMessage: '카테고리가 비어있어요!',
      onPressed: () =>
          showWishlistOptionsBottomSheet(context, wishlist),
    );
  }

  void showWishlistOptionsBottomSheet(
    BuildContext context,
    List<LikeCategoryModel> categories,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => WishlistOptionsBottomSheet(
        onTapEditName: () {},
        onTapDelete: () => _deleteCategory(context, categories),
      ),
    );
  }

  void _deleteCategory(
    BuildContext context,
    List<LikeCategoryModel> categories,
  ) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => DeleteCategoryConfirmDialog(
        model: categories.firstWhere(
          (e) => e.categoryId.toString() == id,
        ),
      ),
    );
  }

  void _editCategoryName(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>
      /// TODO : HandleBottomSheet로 바꾸기?
      /// 그리고 여기서는 model이 필요없음. 옵셔널 파라미터로 바꾼 뒤, 분기처리하기
          AddCategoryBottomSheet(campingModel: campingModel),
    );
  }
}
