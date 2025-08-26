import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
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

    return Stack(
      children: [
        PlatformMapWidget(location: location, models: data.items),
        Positioned(
          top: 64,
          right: 0,
          left: 0,
          child: Column(
            children: [
              LocationRefreshButton(),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              if (data is PaginationFetchingMore) LoadingWidget(),
            ],
          ),
        ),
        Positioned(
          bottom: 112,
          right: 12,
          left: 12,
          child: Column(
            children: [
              ShowCardButton(
                // model: data.items[locationIndex],
                models: data.items,
              ),
              const SizedBox(height: 4),
              if (data.items.isNotEmpty && showCard)
                GestureDetector(
                  onTap: () {
                    ref
                        .read(campingServiceProvider)
                        .onCampingCardTap(
                          context,
                          data.items[locationIndex],
                        );
                  },
                  child: LocationCampingCard(
                    model: data.items[locationIndex],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
