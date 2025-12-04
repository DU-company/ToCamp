import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/common/widgets/error_message_widget.dart';
import 'package:to_camp/features/common/widgets/loading_widget.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/features/camping/base/based_list_view_model.dart';
import 'package:to_camp/features/camping/location/location_camping_view_model.dart';
import 'package:to_camp/features/camping/wishlist/wishlist_view_model.dart';
import 'package:to_camp/features/camping/wishlist/utils/like_utils.dart';
import 'package:to_camp/features/location/view/widgets/location_camping_card.dart';
import 'package:to_camp/features/location/view/widgets/platform_map_widget.dart';
import 'package:to_camp/features/location/view/widgets/show_card_button.dart';
import 'package:to_camp/features/location/view_model/location_state.dart';
import 'package:to_camp/features/location/view/widgets/refresh_button.dart';
import 'package:to_camp/core/models/pagination_state.dart';

/// 받아온 위치 정보로 지도를 띄우는 화면
class LocationSuccessView extends ConsumerWidget {
  final LocationSuccess location;
  const LocationSuccessView({super.key, required this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(locationCampingViewModelProvider);
    final locationIndex = ref.watch(locationIndexProvider);
    final showCard = ref.watch(showCardProvider);
    final wishlist = ref.watch(wishlistViewModelProvider);

    if (data is PaginationLoadingV2) {
      return const LoadingWidget();
    }
    if (data is PaginationErrorV2) {
      return ErrorMessageWidget(
        message: data.message,
        onTap: () => ref
            .read(locationCampingViewModelProvider.notifier)
            .paginate(),
      );
    }

    data as PaginationSuccessV2<CampingModel>;

    /// 위치기반 + 좋아요 목록 합치기
    final totalModels = [
      ...data.items,
      ...LikeUtils.getTotalLike(wishlist),
    ];
    return Stack(
      children: [
        PlatformMapWidget(location: location, models: totalModels),
        Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const SizedBox(height: 64),
              LocationRefreshButton(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              if (data is PaginationFetchingMoreV2) LoadingWidget(),
            ],
          ),
        ),

        /// Card
        Align(
          alignment: context.layout(
            Alignment.bottomCenter,
            desktop: Alignment.bottomRight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (totalModels.isNotEmpty)
                ShowCardButton(items: totalModels),
              const SizedBox(height: 4),
              if (totalModels.isNotEmpty && showCard)
                Flexible(
                  child: GestureDetector(
                    onTap: () => ref
                        .read(basedListViewModelProvider.notifier)
                        .onCampingCardTap(
                          context,
                          totalModels[locationIndex],
                        ),

                    // ref
                    //     .read(campingServiceProvider)
                    //     .onCampingCardTap(
                    //       context,
                    //       totalModels[locationIndex],
                    //     );
                    child: LocationCampingCard(
                      model:
                          totalModels[totalModels.length -
                                      locationIndex >=
                                  1
                              ? locationIndex
                              : 0],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
