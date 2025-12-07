import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/common/widgets/dialog/base_confirm_dialog.dart';
import 'package:to_camp/data/models/wishlist_model.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';

class DeleteWishlistConfirmDialog extends ConsumerWidget {
  final WishlistModel wishlistModel;
  const DeleteWishlistConfirmDialog({
    super.key,
    required this.wishlistModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseConfirmDialog(
      title: '${wishlistModel.name} 위시리스트를\n삭제하시겠습니까?',
      content: '해당 위시리스트에 속해 있는\n캠핑장들도 삭제됩니다.',
      confirmMessage: '위시리스트 삭제',
      cancelMessage: '취소',
      onConfirm: () {
        ref
            .read(wishlistViewModelProvider.notifier)
            .deleteCategory(wishlistModel);
        context.pop();
      },
    );
  }
}
