import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/common/screen/root_tab.dart';
import 'package:to_camp/presentation/common/widgets/dialog/base_confirm_dialog.dart';
import 'package:to_camp/data/models/like_category_model.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:to_camp/presentation/home/home_screen.dart';

class DeleteCategoryConfirmDialog extends ConsumerWidget {
  final LikeCategoryModel model;
  const DeleteCategoryConfirmDialog({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseConfirmDialog(
      title: '위시리스트 삭제',
      content:
          '"${model.categoryName}" 위시리스트를 삭제하실건가요?\n이 작업은 되돌릴 수 없어요!',
      confirmMessage: '위시리스트 삭제',
      cancelMessage: '취소',
      onConfirm: () {
        ref
            .read(wishlistViewModelProvider.notifier)
            .deleteCategory(model);
        context.pop();
        context.goNamed(RootTab.routeName);
      },
      isWarning: true,
    );
  }
}
