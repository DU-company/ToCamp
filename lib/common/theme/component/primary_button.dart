import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class PrimaryButton extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String? text;
  final IconData? icon;
  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.color.primary,
        foregroundColor: theme.color.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(16),
        disabledBackgroundColor: theme.color.inactiveContainer,
        disabledForegroundColor: theme.color.onInactiveContainer,
        // textStyle: theme.typo.subtitle1,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (text != null)
            Expanded(
              child: Text(
                text!,
                style: theme.typo.subtitle2.copyWith(
                  fontWeight: theme.typo.semiBold,
                  color: theme.color.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          if (icon != null) Icon(icon, color: theme.color.onPrimary),
          // AssetIcon(icon!, color: theme.color.onPrimary),
        ],
      ),
    );
  }
}
