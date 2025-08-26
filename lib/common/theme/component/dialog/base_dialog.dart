import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class BaseDialog extends ConsumerWidget {
  final Widget child;
  const BaseDialog({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return AlertDialog(
      elevation: 10,
      title: child,
      titlePadding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 32,
      ),
      backgroundColor: theme.color.surface,
    );
  }
}
