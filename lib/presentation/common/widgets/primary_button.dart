import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';

class PrimaryButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String? text;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final double radius;
  final double padding;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
    this.borderColor,
    this.radius = 16,
    this.padding = 16,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        /// Shape
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        padding: EdgeInsets.all(padding),

        /// Color
        splashFactory: InkSparkle.splashFactory,
        backgroundColor: backgroundColor ?? theme.color.primary,
        foregroundColor: foregroundColor ?? theme.color.onPrimary,
        disabledBackgroundColor: theme.color.inactiveContainer,
        disabledForegroundColor: theme.color.onInactiveContainer,
        side: BorderSide(
          color: borderColor ?? Colors.transparent,
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: foregroundColor ?? theme.color.onPrimary,
              size: 24,
            ),

          if (text != null && icon != null) const SizedBox(width: 8),

          if (text != null)
            Flexible(
              child: Text(
                text!,
                style: theme.typo.subtitle1.copyWith(
                  color: foregroundColor ?? theme.color.onPrimary,
                  fontWeight: theme.typo.semiBold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
