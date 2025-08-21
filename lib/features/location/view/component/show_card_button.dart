import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/location/view/component/platform_map_widget.dart';
import 'package:to_camp/features/location/view/screen/location_camping_screen.dart';

class ShowCardButton extends ConsumerWidget {
  const ShowCardButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final showCard = ref.watch(showCardProvider);
    return PrimaryButton(
      backgroundColor: theme.color.surface,
      foregroundColor: theme.color.primary,
      onPressed: () {
        if (showCard) {
          context.pushNamed(LocationCampingScreen.routeName);
        } else {
          ref.read(showCardProvider.notifier).state = true;
        }
      },
      icon: showCard
          ? PhosphorIcons.list()
          : PhosphorIconsBold.caretDoubleUp,
      text: showCard ? '목록' : null,
    );
  }
}
