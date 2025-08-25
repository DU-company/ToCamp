import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class BaseBottomSheet extends ConsumerWidget {
  final Widget child;
  final EdgeInsets? padding;
  const BaseBottomSheet({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: theme.color.surface,
        boxShadow: theme.deco.shadow,
      ),
      padding: padding ?? const EdgeInsets.only(top: 32, bottom: 16),
      child: SafeArea(top: false, child: child),
    );
  }
}
