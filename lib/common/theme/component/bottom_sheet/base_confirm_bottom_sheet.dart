import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class BaseConfirmBottomSheet extends ConsumerWidget {
  final String title;
  final String confirmMessage;
  final String cancelMessage;
  final VoidCallback onConfirm;
  // final VoidCallback onCancel;
  final Color color;

  const BaseConfirmBottomSheet({
    super.key,
    required this.title,
    required this.confirmMessage,
    required this.cancelMessage,
    required this.onConfirm,
    // required this.onCancel,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: theme.typo.headline6),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // onCancel();
                  },
                  child: Text(
                    cancelMessage,
                    textAlign: TextAlign.center,
                    style: theme.typo.subtitle2,
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: onConfirm,
                  child: Text(
                    confirmMessage,
                    textAlign: TextAlign.center,
                    style: theme.typo.subtitle2.copyWith(
                      color: color,
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
