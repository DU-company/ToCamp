import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/presentation/common/widgets/custom_icon_button.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';

class ShowCardButton extends ConsumerWidget {
  final bool showCard;
  final VoidCallback onTapShowCard;
  final VoidCallback onTapMyLocation;
  const ShowCardButton({
    super.key,
    required this.showCard,
    required this.onTapShowCard,
    required this.onTapMyLocation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.only(
        bottom: showCard ? 0 : safeAreaBottom + 88,
        right: 12,
        left: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 48),
          PrimaryButton(
            padding: 8,
            radius: 12,
            text: showCard ? '목록' : null,
            icon: showCard
                ? PhosphorIcons.list()
                : PhosphorIconsBold.caretDoubleUp,
            onPressed: onTapShowCard,
            backgroundColor: theme.color.surface,
            foregroundColor: theme.color.primary,
          ),
          CustomIconButton(
            size: 32,
            foregroundColor: theme.color.primary,
            icon: PhosphorIcons.crosshair(),
            onTap: onTapMyLocation,
          ),
        ],
      ),
    );
  }
}
