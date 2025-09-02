import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/location/provider/location_camping_provider.dart';
import 'package:to_camp/features/location/service/location_camping_service.dart';
import 'package:to_camp/features/location/view/component/platform_map_widget.dart';

class LocationRefreshButton extends ConsumerWidget {
  const LocationRefreshButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final entity = ref.watch(locationCampingProvider);
    final theme = ref.watch(themeServiceProvider);
    final mapController = ref.watch(mapControllerProvider);
    final showRefreshButton = ref.watch(showRefreshProvider);

    if (showRefreshButton) {
      return PrimaryButton(
        onPressed: () => onRefresh(ref, mapController),
        text: '이 지역 재탐색',
        icon: PhosphorIconsBold.arrowClockwise,
        foregroundColor: theme.color.primary,
        backgroundColor: theme.color.surface,
      );
    } else {
      return SizedBox();
    }
  }

  void onRefresh(
    WidgetRef ref,
    PlatformMapController? mapController,
    // PaginationState entity,
  ) {
    EasyThrottle.throttle(
      'location_refresh',
      Duration(seconds: 3),
      () async {
        ref.read(locationIndexProvider.notifier).state = 0;
        ref.read(showRefreshProvider.notifier).state = false;
        await ref
            .read(locationCampingProvider.notifier)
            .paginate(fetchingMore: true);

        final data = ref.read(locationCampingProvider);

        if (data is PaginationSuccess<CampingModel>) {
          final models = data.items;

          /// 응답값이 비어있거나 에러가 난다면
          if (models.isEmpty || data is PaginationErrorHasData) {
            ref
                .read(toastUtilsProvider)
                .showToast(text: '근처 캠핑장이 존재하지 않습니다.');

            /// 응답값이 존재하면
          } else {
            ref
                .read(locationCampingServiceProvider)
                .onMarkerTap(models: models, model: models.first);
          }
        }
      },
    );
  }
}
