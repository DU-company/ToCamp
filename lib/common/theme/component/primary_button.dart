import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class PrimaryButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String? text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? theme.color.primary,
        foregroundColor: foregroundColor ?? theme.color.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        disabledBackgroundColor: theme.color.inactiveContainer,
        disabledForegroundColor: theme.color.onInactiveContainer,
        // textStyle: theme.typo.subtitle1,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: foregroundColor ?? theme.color.onPrimary,
            ),

          if (text != null && icon != null) const SizedBox(width: 8),

          if (text != null)
            Text(
              text!,
              style: theme.typo.subtitle2.copyWith(
                fontWeight: theme.typo.semiBold,
                color: foregroundColor ?? theme.color.onPrimary,
              ),
              textAlign: TextAlign.center,
            ),

          // AssetIcon(icon!, color: theme.color.onPrimary),
        ],
      ),
    );
  }
}
