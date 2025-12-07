import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/models/pagination_state.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/base/based_list_view_model.dart';
import 'package:to_camp/presentation/camping/location/widgets/location_camping_card.dart';
import 'package:to_camp/presentation/camping/location/widgets/location_camping_map.dart';
import 'package:to_camp/presentation/camping/location/widgets/refresh_button.dart';
import 'package:to_camp/presentation/camping/location/widgets/show_card_button.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';
import 'package:to_camp/presentation/camping/wishlist/utils/wishlist_utils.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:to_camp/presentation/common/layout/default_layout.dart';

class LocationCampingSuccessView extends ConsumerWidget {
  final PaginationSuccess<CampingModel> state;
  final LocationSuccess location;
  const LocationCampingSuccessView({
    super.key,
    required this.state,
    required this.location,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistViewModelProvider);

    final locationIndex = ref.watch(locationIndexProvider);
    final showCard = ref.watch(showCardProvider);
    final showRefresh = ref.watch(showRefreshProvider);

    /// 위치기반 + 좋아요 목록 합치기
    final totalModels = [
      ...state.items,
      ...WishlistUtils.extractCampingList(wishlist),
    ];

    final hasItem = totalModels.isNotEmpty;

    final isValidIndex = locationIndex < totalModels.length; // 필요할까?
    final targetModel = !hasItem
        ? null
        : totalModels[isValidIndex ? locationIndex : 0];

    return DefaultLayout(
      isLoading: state is PaginationFetchingMore,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Show Card / List Button
          if (hasItem)
            ShowCardButton(
              models: totalModels,
              showCard: showCard,
              targetModel: targetModel!,
            ),

          /// CampingCard
          const SizedBox(height: 4),
          if (hasItem && showCard)
            Flexible(
              child: GestureDetector(
                child: LocationCampingCard(model: targetModel!),
                onTap: () => ref
                    .read(basedListViewModelProvider.notifier)
                    .onCampingCardTap(context, targetModel),
              ),
            ),
        ],
      ),
      child: Stack(
        children: [
          /// Map
          LocationCampingMap(location: location, models: totalModels),

          /// Refresh Button
          if (showRefresh) LocationRefreshButton(),
        ],
      ),
    );
  }
}
