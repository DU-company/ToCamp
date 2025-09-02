import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';
import 'package:to_camp/features/like/utils/like_utils.dart';
import 'package:to_camp/features/location/model/location_model.dart';
import 'package:to_camp/features/location/provider/location_camping_provider.dart';
import 'package:to_camp/features/location/view/component/location_camping_card.dart';
import 'package:to_camp/features/location/view/component/platform_map_widget.dart';
import 'package:to_camp/features/location/view/component/refresh_button.dart';
import 'package:to_camp/features/location/view/component/show_card_button.dart';

class MapScreen extends ConsumerWidget {
  final LocationSuccess location;
  const MapScreen({super.key, required this.location});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(locationCampingProvider);
    final locationIndex = ref.watch(locationIndexProvider);
    final showCard = ref.watch(showCardProvider);
    final likeModels = ref.watch(campingLikeProvider);

    if (data is PaginationLoading) {
      return LoadingWidget();
    }
    if (data is PaginationError) {
      return ErrorMessageWidget(
        message: data.message,
        onTap: () {
          ref.read(locationCampingProvider.notifier).paginate();
        },
      );
    }

    data as PaginationSuccess<CampingModel>;

    /// 위치기반 + 좋아요 목록 합치기
    final totalModels = [
      ...data.items,
      ...LikeUtils.getTotalLike(likeModels),
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
              if (data is PaginationFetchingMore) LoadingWidget(),
            ],
          ),
        ),
        Align(
          alignment: context.layout(
            Alignment.bottomCenter,
            desktop: Alignment.bottomRight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (data.items.isNotEmpty)
                ShowCardButton(items: data.items),
              const SizedBox(height: 4),
              if (totalModels.isNotEmpty && showCard)
                GestureDetector(
                  onTap: () {
                    ref
                        .read(campingServiceProvider)
                        .onCampingCardTap(
                          context,
                          totalModels[locationIndex],
                        );
                  },
                  child: LocationCampingCard(
                    model: totalModels[locationIndex],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
