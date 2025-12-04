import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/features/common/widgets/primary_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/core/service/toast_utils.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/features/camping/location/location_camping_view_model.dart';
import 'package:to_camp/core/models/pagination_state.dart';
import 'package:to_camp/features/location/view/widgets/platform_map_widget.dart';

class LocationRefreshButton extends ConsumerWidget {
  const LocationRefreshButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final showRefreshButton = ref.watch(showRefreshProvider);

    if (showRefreshButton) {
      return PrimaryButton(
        onPressed: () => onRefresh(ref),
        text: '이 지역 재탐색',
        icon: PhosphorIconsBold.arrowClockwise,
        foregroundColor: theme.color.primary,
        backgroundColor: theme.color.surface,
      );
    } else {
      return SizedBox();
    }
  }

  void onRefresh(WidgetRef ref) {
    EasyThrottle.throttle(
      'location_refresh',
      Duration(seconds: 3),
      () async {
        /// State
        ref.read(locationIndexProvider.notifier).state = 0;
        ref.read(showRefreshProvider.notifier).state = false;

        await ref
            .read(locationCampingViewModelProvider.notifier)
            .paginate(fetchMore: true);

        final data = ref.read(locationCampingViewModelProvider);

        if (data is PaginationSuccessV2<CampingModel>) {
          final models = data.items;

          /// 응답값이 비어있거나 에러가 난다면
          if (models.isEmpty || data is PaginationFetchingErrorV2) {
            ref
                .read(toastServiceProvider)
                .showToast(text: '근처 캠핑장이 존재하지 않습니다.');

            /// 응답값이 존재하면
          } else {
            ref
                .read(locationCampingViewModelProvider.notifier)
                .onMarkerTap(
                  models: models,
                  targetModel: models.first,
                );
          }
        }
      },
    );
  }
}
