import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/common/widgets/dialog/base_dialog.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';

class BaseConfirmDialog extends ConsumerWidget {
  final String title;
  final String? content;
  final String confirmMessage;
  final VoidCallback onConfirm;
  final String? cancelMessage;
  final bool isWarning;

  const BaseConfirmDialog({
    super.key,
    required this.title,
    this.content,
    required this.confirmMessage,
    required this.onConfirm,
    this.cancelMessage,
    this.isWarning = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return BaseDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Title
          Text(title, style: theme.typo.headline3),
          const SizedBox(height: 8),

          /// Content
          if (content != null)
            Text(
              content!,
              style: theme.typo.subtitle1.copyWith(
                color: theme.color.onHintContainer,
              ),
            ),
          if (content != null) const SizedBox(height: 16),

          /// Confirm Button
          PrimaryButton(
            text: confirmMessage,
            onPressed: onConfirm,
            radius: 8,
            backgroundColor: isWarning ? theme.color.secondary : null,
          ),

          /// Cancel Button
          if (cancelMessage != null) const SizedBox(height: 8),
          if (cancelMessage != null)
            PrimaryButton(
              text: cancelMessage,
              onPressed: () => context.pop(),
              backgroundColor: theme.color.surface,
              foregroundColor: theme.color.text,
              borderColor: theme.color.subtext,
              radius: 8,
            ),
        ],
      ),
    );
  }
}
