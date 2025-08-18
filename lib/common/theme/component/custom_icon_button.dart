import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class CustomIconButton extends ConsumerWidget {
  final VoidCallback? onTap;
  final IconData icon;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final double size;
  const CustomIconButton({
    super.key,
    required this.onTap,
    required this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SizedBox(
        width: size * 1.5,
        height: size * 1.5,
        child: ElevatedButton(
          style: IconButton.styleFrom(
            backgroundColor: backgroundColor ?? theme.color.surface,
            foregroundColor: foregroundColor ?? theme.color.text,
            disabledBackgroundColor: theme.color.inactive,
            disabledForegroundColor: theme.color.onInactiveContainer,
            shape: CircleBorder(),
            padding: EdgeInsets.zero,
            elevation: 2,
          ),
          onPressed: onTap,
          child: Center(child: Icon(icon, size: size)),
        ),
      ),
    );
  }
}
