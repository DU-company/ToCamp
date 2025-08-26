import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:to_camp/common/theme/component/dialog/base_dialog.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class BaseConfirmDialog extends ConsumerWidget {
  final String title;
  final String confirmMessage;
  final String cancelMessage;
  final VoidCallback onConfirm;
  // final VoidCallback onCancel;
  final Color? color;

  const BaseConfirmDialog({
    super.key,
    required this.title,
    required this.confirmMessage,
    required this.cancelMessage,
    required this.onConfirm,
    // required this.onCancel,
    this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return BaseDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.typo.subtitle1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              /// Cancel Button
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Navigator.pop(context);
                    // onCancel();
                  },
                  child: Text(
                    cancelMessage,
                    textAlign: TextAlign.center,
                    style: theme.typo.body1,
                  ),
                ),
              ),
              SizedBox(
                height:
                    24, // 또는 double.infinity (Row 외부에서 높이 제한이 있을 경우)
                child: VerticalDivider(
                  color: theme.color.hint,
                  thickness: 1,
                  width: 20, // 여유 공간 포함
                ),
              ),

              /// Confirm Button
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: onConfirm,
                  child: Text(
                    confirmMessage,
                    textAlign: TextAlign.center,
                    style: theme.typo.body1.copyWith(
                      color: color ?? theme.color.secondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
