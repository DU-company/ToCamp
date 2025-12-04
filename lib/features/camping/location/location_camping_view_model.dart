import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/core/models/pagination_params.dart';
import 'package:to_camp/core/service/location_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/repositories/camping_repository.dart';
import 'package:to_camp/features/location/view/widgets/platform_map_widget.dart';
import 'package:to_camp/features/location/view_model/location_state.dart';
import 'package:to_camp/features/location/view_model/location_view_model.dart';
import 'package:to_camp/features/location/utils/location_utils.dart';
import 'package:to_camp/core/models/pagination_state.dart';

final locationCampingViewModelProvider = NotifierProvider(
  () => LocationCampingViewModel(),
);

class LocationCampingViewModel extends Notifier<PaginationStateV2> {
  CampingRepository get repository =>
      ref.read(campingRepositoryProvider);
  LocationService get locationService =>
      ref.read(locationServiceProvider);

  @override
  PaginationStateV2 build() {
    paginate();
    return PaginationLoadingV2();
  }

  Future<void> paginate({bool fetchMore = false}) async {
    PaginationParams params = PaginationParams(
      take: 30,
      pageNo: 0,
      radius: 20000,
    );

    try {
      /// 초기값 정의
      if (fetchMore) {
        final pState = state as PaginationSuccessV2<CampingModel>;
        state = PaginationFetchingMoreV2(
          items: pState.items,
          hasMore: pState.hasMore,
        );
      } else {
        state = PaginationLoadingV2();
      }

      final cameraPosition = ref.read(cameraPositionProvider);

      /// 지도를 움직인 적이 있다면
      if (cameraPosition != null) {
        params = params.copyWith(
          lat: cameraPosition.target.latitude,
          lng: cameraPosition.target.longitude,
          radius: LocationUtils.radiusByZoom(cameraPosition.zoom),
          take: LocationUtils.takeByZoom(cameraPosition.zoom),
        );

        /// 그렇지 않으면 초기 페이지네이션
      } else {
        final location = ref.read(locationViewModelProvider);

        /// Success가 아니면?
        location as LocationSuccess;
        params = params.copyWith(
          lat: location.lat,
          lng: location.lng,
        );
      }

      final resp = await repository.getLocationBasedList(params);

      /// 거리순 정렬
      final pItems = LocationUtils.sortByDistance(
        resp.items,
        params.lat!,
        params.lng!,
      );

      state = PaginationSuccessV2(items: pItems, hasMore: true);
    } catch (e) {
      if (state is PaginationSuccessV2) {
        final pState = state as PaginationSuccessV2<CampingModel>;
        state = PaginationFetchingErrorV2(
          items: pState.items,
          hasMore: pState.hasMore,
        );
      } else {
        state = PaginationErrorV2(message: e.toString());
      }
    }
  }

  Future<void> onMarkerTap({
    required List<CampingModel> models,
    required CampingModel targetModel,
  }) async {
    if (models.isEmpty) return;

    final mapController = ref.read(mapControllerProvider);

    final index = models.indexWhere((e) => e.id == targetModel.id);

    if (mapController != null) {
      ref.read(locationIndexProvider.notifier).state = index;

      await animateCameraByZoom(mapController, targetModel);

      ref.read(showCardProvider.notifier).state = true;

      mapController.showMarkerInfoWindow(MarkerId(targetModel.id));
    }
  }

  Future<void> animateCameraByZoom(
    PlatformMapController mapController,
    CampingModel model,
  ) async {
    final currentPosition = ref.read(cameraPositionProvider);

    if (currentPosition == null) return;

    if (currentPosition.zoom > 10) {
      await mapController.animateCamera(
        CameraUpdate.newLatLng(LatLng(model.lat, model.lng)),
      );
    } else {
      /// 너무 축소시킨 경우에는 Zoom 해주기
      await mapController.animateCamera(
        CameraUpdate.newLatLngZoom(LatLng(model.lat, model.lng), 12),
      );
    }
  }
}
