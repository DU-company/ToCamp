import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class Tile extends ConsumerWidget {
  final VoidCallback? onTap;
  final Color? color;
  final String text;
  final IconData? icon;
  final EdgeInsets? padding;
  final IconData? trailing;
  const Tile({
    super.key,
    required this.onTap,
    required this.text,
    this.color,
    this.icon,
    this.padding,
    this.trailing,
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
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.typo.headline6.copyWith(
                    color: color ?? theme.color.text,
                    fontWeight: theme.typo.regular,
                  ),
                ),
              ),
              if (trailing != null) Icon(trailing),
            ],
          ),
        ),
      ),
    );
  }
}
