import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/data/models/like_category_model.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/category_form_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/wishlist_options_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/dialog/delete_wishlist_confirm_dialog.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:collection/collection.dart';

class LikeCategoryScreen extends ConsumerWidget {
  static String get routeName => 'like-category';

  final String id;
  // final String name;
  const LikeCategoryScreen({
    super.key,
    required this.id,
    // required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistViewModelProvider);

    final category = wishlist.firstWhereOrNull(
      (e) => e.id.toString() == id,
    );

    final likedItems = category?.items;

    return CampingScreen(
      items: likedItems ?? [],
      title: category?.name ?? '',
      emptyMessage: '카테고리가 비어있어요!',
      onPressed: () =>
          showWishlistOptionsBottomSheet(context, category!),
    );
  }

  void showWishlistOptionsBottomSheet(
    BuildContext context,
    LikeCategoryModel category,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => WishlistOptionsBottomSheet(
        onTapEditName: () => _showEditBottomSheet(context, category),
        onTapDelete: () => _showDeleteDialog(context, category),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    LikeCategoryModel? category,
  ) {
    if (category == null) return;
    context.pop();
    showDialog(
      context: context,
      builder: (context) =>
          DeleteCategoryConfirmDialog(model: category),
    );
  }

  void _showEditBottomSheet(
    BuildContext context,
    LikeCategoryModel? category,
  ) {
    if (category == null) return;
    context.pop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: CategoryFormBottomSheet(
          isEdit: true,
          categoryModel: category,
        ),
      ),
    );
  }
}
