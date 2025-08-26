import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/common/theme/component/dialog/base_confirm_dialog.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/features/like/model/camping_like_model.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';

class DeleteCategoryConfirmDialog extends ConsumerWidget {
  final int categoryId;
  const DeleteCategoryConfirmDialog({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseConfirmDialog(
      title: '해당 카테고리를 삭제하시겠습니까?',
      confirmMessage: '네',
      cancelMessage: '아니오',
      onConfirm: () {
        ref
            .read(campingLikeProvider.notifier)
            .deleteCategory(categoryId);
        ref
            .read(toastUtilsProvider)
            .showToast(text: '카테고리가 삭제되었습니다.');
        context.pop();
      },
    );
  }
}
