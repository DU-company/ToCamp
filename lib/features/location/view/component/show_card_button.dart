import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/location/service/location_camping_service.dart';
import 'package:to_camp/features/location/view/component/platform_map_widget.dart';

class ShowCardButton extends ConsumerWidget {
  final List<CampingModel> items;
  const ShowCardButton({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final showCard = ref.watch(showCardProvider);
    final locationIndex = ref.watch(locationIndexProvider);
    return Padding(
      padding: EdgeInsets.only(
        bottom: showCard ? 0 : 112,
        right: 12,
        left: 12,
      ),
      child: PrimaryButton(
        backgroundColor: theme.color.surface,
        foregroundColor: theme.color.primary,
        onPressed: () {
          if (showCard) {
            context.pushNamed(
              CampingScreen.routeName,
              extra: items,
              pathParameters: {'title': '이 지역 캠핑장'},
            );
          } else {
            ref
                .read(locationCampingServiceProvider)
                .onMarkerTap(
                  models: items,
                  model: items[locationIndex],
                );
          }
        },
        icon: showCard
            ? PhosphorIcons.list()
            : PhosphorIconsBold.caretDoubleUp,
        text: showCard ? '목록' : null,
      ),
    );
  }
}
