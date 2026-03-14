import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/provider/marker_icon_provider.dart';
import 'package:to_camp/core/service/toast_service.dart';
import 'package:to_camp/data/models/wishlist_model.dart';
import 'package:to_camp/presentation/camping/base/based_list_view_model.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
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

/// TODO : 에러든 로딩이든 성공이든 일단 지도는 떠 있어야 함!
///
///
final cameraPositionProvider = StateProvider<CameraPosition?>(
  (ref) => null,
);

class LocationCampingScreen extends ConsumerStatefulWidget {
  final LocationState location;
  const LocationCampingScreen({super.key, required this.location});

  @override
  ConsumerState<LocationCampingScreen> createState() =>
      _LocationCampingScreenState();
}

class _LocationCampingScreenState
    extends ConsumerState<LocationCampingScreen>
    with AutomaticKeepAliveClientMixin {
  bool showRefresh = false;
  bool showCard = false;
  int locationIndex = 0;
  late final PlatformMapController mapController;
  List<CampingModel> totalItems = [];

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final markerIcons = ref.watch(markerIconProvider);
    final wishlist = ref.watch(wishlistViewModelProvider);
    final locationCampingState = ref.watch(
      locationCampingViewModelProvider,
    );
    if (locationCampingState is PaginationSuccess<CampingModel>) {
      totalItems = [
        ...locationCampingState.items,
        ...WishlistUtils.extractCampingList(wishlist),
      ];
    }

    final hasItem = totalItems.isNotEmpty;

    // 필요할까? >> 지도에서 좋아요 해제하면 totalItems의 range가 줄어들기 때문에
    final isValidIndex = locationIndex < totalItems.length;
    final targetItem = !hasItem
        ? null
        : totalItems[isValidIndex ? locationIndex : 0];

    return DefaultLayout(
      isLoading: locationCampingState is PaginationFetchingMore,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Show Card / List Button
          if (hasItem)
            ShowCardButton(
              showCard: showCard,
              onTapShowCard: () =>
                  onTapShowCard(totalItems, targetItem!),
              onTapMyLocation: () {},
            ),

          /// CampingCard
          const SizedBox(height: 4),
          if (hasItem && showCard)
            Flexible(
              child: GestureDetector(
                child: LocationCampingCard(model: targetItem!),
                onTap: () => ref
                    .read(basedListViewModelProvider.notifier)
                    .onCampingCardTap(context, targetItem),
              ),
            ),
        ],
      ),
      child: Stack(
        children: [
          CustomMapView(
            initialCameraPosition: CameraPosition(
              target: initialLatLng,
              zoom: 12,
            ),
            markers: Set.from(
              setMarkersFromModels(wishlist, markerIcons),
            ),
            onMapCreated: _onMapCreated,
            onCameraMoveStarted: _onCameraMoveStarted,
            onCameraMove: (cameraPosition) =>
                _onCameraMove(cameraPosition),
            onCameraIdle: _onCameraIdle,
          ),
          if (showRefresh)
            LocationRefreshButton(onRefresh: onTapRefresh),
        ],
      ),
    );
  }

  List<Marker> setMarkersFromModels(
    List<WishlistModel> wishlist,
    List<Uint8List> markerIcons,
  ) {
    if (markerIcons.isEmpty) return [];

    return List.generate(totalItems.length, (index) {
      final model = totalItems[index];
      final isLiked = WishlistUtils.checkIsLiked(wishlist, model);
      final markerIcon = BitmapDescriptor.fromBytes(
        markerIcons[isLiked ? 1 : 0],
      );
      return Marker(
        markerId: MarkerId(model.id),
        icon: markerIcon,

        position: LatLng(model.lat, model.lng),
        onTap: () =>
            onTapMarker(models: totalItems, targetModel: model),
        consumeTapEvents: true,
        infoWindow: InfoWindow(
          title: model.name,
          snippet: model.address,
        ),
      );
    });
  }

  void _onCameraMove(CameraPosition cameraPosition) {
    ref.read(cameraPositionProvider.notifier).state = cameraPosition;
  }

  void _onMapCreated(PlatformMapController controller) async {
    await Future.delayed(const Duration(milliseconds: 200));
    mapController = controller;
    if (totalItems.isNotEmpty) {
      controller.showMarkerInfoWindow(MarkerId(totalItems.first.id));
    }
  }

  void _onCameraIdle() {
    setState(() {
      showRefresh = true;
    });
  }

  void _onCameraMoveStarted() {
    setState(() {
      showCard = false;
    });
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

  void onTapRefresh() {
    EasyThrottle.throttle(
      'location_refresh',
      Duration(seconds: 2),
      () async {
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
                .showToast(text: '근처 캠핑장이 존재하지 않습니다.');

            /// 응답값이 존재하면
          } else {
            onTapMarker(models: models, targetModel: models.first);
          }
          await Future.delayed(Duration(milliseconds: 222));
          setState(() {
            showRefresh = false;
          });
        }
      },
    );
  }
}
