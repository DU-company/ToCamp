import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/features/common/widgets/dialog/base_confirm_dialog.dart';
import 'package:to_camp/data/models/wishlist_model.dart';
import 'package:to_camp/features/camping/wishlist/wishlist_view_model.dart';

class DeleteWishlistConfirmDialog extends ConsumerWidget {
  final WishlistModel wishlistModel;
  const DeleteWishlistConfirmDialog({
    super.key,
    required this.wishlistModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseConfirmDialog(
      title: '해당 카테고리를 삭제하시겠습니까?',
      confirmMessage: '네',
      cancelMessage: '아니오',
      onConfirm: () {
        ref
            .read(wishlistViewModelProvider.notifier)
            .deleteCategory(wishlistModel);
        context.pop();
      },
    );
  }
}
