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
  final String cancelMessage;
  final VoidCallback onConfirm;

  const BaseConfirmDialog({
    super.key,
    required this.title,
    this.content,
    required this.confirmMessage,
    required this.cancelMessage,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return BaseDialog(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: theme.typo.headline3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (content != null)
            Text(
              content!,
              style: theme.typo.headline6.copyWith(
                color: theme.color.onHintContainer,
              ),
              textAlign: TextAlign.center,
            ),
          if (content != null) const SizedBox(height: 32),
          PrimaryButton(
            radius: 8,
            onPressed: onConfirm,
            text: confirmMessage,
            padding: 16,
          ),
          const SizedBox(height: 8),
          PrimaryButton(
            radius: 8,
            onPressed: () => context.pop(),
            text: cancelMessage,
            backgroundColor: theme.color.surface,
            foregroundColor: theme.color.text,
            borderColor: theme.color.subtext,
            padding: 16,
          ),
        ],
      ),
    );
  }
}
