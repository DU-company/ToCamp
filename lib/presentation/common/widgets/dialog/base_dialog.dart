import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';

class BaseDialog extends ConsumerWidget {
  final Widget child;
  const BaseDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: theme.color.surface,
      constraints: BoxConstraints(minWidth: 400, maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: child,
      ),
    );
  }
}
