import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/provider/marker_icon_provider.dart';
import 'package:to_camp/core/service/toast_service.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/presentation/camping/base/based_list_view_model.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
import 'package:to_camp/presentation/camping/location/utils/location_utils.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_view_model.dart';
import 'package:to_camp/presentation/camping/location/widgets/dialog/gps_enable_dialog.dart';
import 'package:to_camp/presentation/camping/location/widgets/dialog/location_permission_dialog.dart';
import 'package:to_camp/presentation/camping/location/widgets/location_camping_card.dart';
import 'package:to_camp/presentation/camping/location/widgets/refresh_button.dart';
import 'package:to_camp/presentation/camping/location/widgets/show_card_button.dart';
import 'package:to_camp/presentation/camping/wishlist/utils/wishlist_utils.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:to_camp/presentation/common/layout/default_layout.dart';
import 'package:to_camp/presentation/common/widgets/custom_map_view.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_camping_view_model.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';
import 'package:to_camp/core/models/pagination_state.dart';

final cameraPositionProvider = StateProvider<CameraPosition?>(
  (ref) => null,
);

class LocationCampingScreen extends ConsumerStatefulWidget {
  final LocationState location;
  final void Function(PlatformMapController controller)
  onTapMyLocation;
  const LocationCampingScreen({
    super.key,
    required this.location,
    required this.onTapMyLocation,
  });

  @override
  ConsumerState<LocationCampingScreen> createState() =>
      _LocationCampingScreenState();
}

class _LocationCampingScreenState
    extends ConsumerState<LocationCampingScreen>
    with AutomaticKeepAliveClientMixin {
  bool showRefresh = false;
  bool showCard = true;
  bool userDrag = false;
  int locationIndex = 0;

  late final PlatformMapController mapController;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late LatLng initialLatLng;

  @override
  void initState() {
    super.initState();
    if (widget.location is LocationSuccess) {
      final location = widget.location as LocationSuccess;
      initialLatLng = LatLng(location.lat, location.lng);
    } else {
      // 서울의 lat lng
      initialLatLng = const LatLng(LAT_OF_SEOUL, LNG_OF_SEOUL);
    }
  }

  // home에서 Pagination이 끝나지 않았다면,showCard를 해주기 위해서
  listenLocationCampingState() {
    ref.listen(locationCampingViewModelProvider, (p, n) {
      if (p is! PaginationSuccess &&
          n is PaginationSuccess<CampingModel> &&
          n.items.isNotEmpty) {
        onTapMarker(models: n.items, targetModel: n.items.first);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    listenLocationCampingState();

    final markerIcons = ref.watch(markerIconProvider);
    final wishlist = ref.watch(wishlistViewModelProvider);
    final locationCampingState = ref.watch(
      locationCampingViewModelProvider,
    );
    final totalModels =
        locationCampingState is PaginationSuccess<CampingModel>
        ? [
            ...locationCampingState.items,
            ...WishlistUtils.extractCampingList(wishlist),
          ]
        : <CampingModel>[];

    final hasItem = totalModels.isNotEmpty;

    // 필요할까? >> 지도에서 좋아요 해제하면 totalItems의 range가 줄어들기 때문에
    final isValidIndex = locationIndex < totalModels.length;
    final targetModel = !hasItem
        ? null
        : totalModels[isValidIndex ? locationIndex : 0];

    return DefaultLayout(
      isLoading:
          locationCampingState is PaginationFetchingMore ||
          locationCampingState is PaginationLoading,
      bottomNavigationBar: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Show Card / List Button
            if (hasItem)
              SizedBox(
                width: context.layout(
                  null,
                  desktop: MediaQuery.of(context).size.width / 2,
                ),
                child: ShowCardButton(
                  showCard: showCard,
                  onTapShowCard: () =>
                      onTapShowCard(totalModels, targetModel!),
                  onTapMyLocation: () =>
                      widget.onTapMyLocation(mapController),
                ),
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
      ),
      child: Stack(
        children: [
          CustomMapView(
            initialCameraPosition: CameraPosition(
              target: initialLatLng,
              zoom: 12,
            ),
            markers: Set.from(
              LocationUtils.createMarkers(
                totalModels: totalModels,
                wishlist: wishlist,
                markerIcons: markerIcons,
                onTap: (model) => onTapMarker(
                  models: totalModels,
                  targetModel: model,
                ),
              ),
            ),
            onMapCreated: (controller) =>
                onMapCreated(controller, totalModels),
            onCameraMoveStarted: () => setState(() {
              showCard = false;
            }),
            onCameraMove: (cameraPosition) {
              ref.read(cameraPositionProvider.notifier).state =
                  cameraPosition;
            },

            onCameraIdle: () => setState(() {
              showRefresh = true;
            }),
          ),
          if (showRefresh)
            LocationRefreshButton(onRefresh: onTapRefresh),
        ],
      ),
    );
  }

  void onMapCreated(
    PlatformMapController controller,
    List<CampingModel> totalModels,
  ) async {
    mapController = controller;
    await Future.delayed(Duration(milliseconds: 333));
    if (totalModels.isNotEmpty) {
      onTapMarker(
        models: totalModels,
        targetModel: totalModels.first,
      );
    }
  }

  Future<void> onTapMarker({
    required List<CampingModel> models,
    required CampingModel targetModel,
  }) async {
    if (models.isEmpty) return;

    /// 카메라 이동 (선)
    await mapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(targetModel.lat, targetModel.lng),
      ),
    );

    /// index 변경
    final index = models.indexWhere((e) => e.id == targetModel.id);

    /// 카드 띄우기 (후)
    setState(() {
      locationIndex = index;
      showCard = true;
    });

    /// 새로운 마커들이 생성될때까지 기다리기
    await Future.delayed(Duration(milliseconds: 222));

    /// info 보여주기
    mapController.showMarkerInfoWindow(MarkerId(targetModel.id));
  }

  void onTapShowCard(
    List<CampingModel> models,
    CampingModel targetModel,
  ) {
    /// 이미 카드가 띄워져 있다면
    if (showCard) {
      /// 캠핑장 목록으로 라우팅
      context.pushNamed(
        CampingScreen.routeName,
        extra: models,
        pathParameters: {'title': '이 지역 캠핑장'},
      );
    } else {
      /// 현재 index에 대한 카드 띄우기
      onTapMarker(models: models, targetModel: targetModel);
    }
  }

  Future<void> onTapRefresh() async {
    await ref
        .read(locationCampingViewModelProvider.notifier)
        .paginate(isReFetch: true);

    final state = ref.read(locationCampingViewModelProvider);

    if (state is PaginationSuccess<CampingModel>) {
      final models = state.items;

      /// 에러가 난다면
      if (state is PaginationFetchingError) {
        final pState = state as PaginationFetchingError;
        ref
            .read(toastServiceProvider)
            .showToast(text: pState.message);

        /// 응닶값이 비어있다면
      } else if (models.isEmpty) {
        ref
            .read(toastServiceProvider)
            .showToast(text: '근처 캠핑장을 찾을 수 없어요');

        /// 응답값이 존재하면
      } else {
        onTapMarker(models: models, targetModel: models.first);
      }
      await Future.delayed(Duration(milliseconds: 222));
      setState(() {
        showRefresh = false;
      });
    }
  }
}
