import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class Tile extends ConsumerWidget {
  final VoidCallback? onTap;
  final Color? color;
  final String text;
  final IconData? icon;
  final EdgeInsets? padding;
  const Tile({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.icon,
    this.padding,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (icon != null) Icon(icon),

              if (icon != null) SizedBox(width: 8),

              Text(
                text,
                style: theme.typo.headline6.copyWith(
                  color: color ?? theme.color.text,
                ),
              ),

              Spacer(),
              if (onTap != null)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color ?? theme.color.text,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
