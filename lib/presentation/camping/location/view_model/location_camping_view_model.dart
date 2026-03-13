import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/models/pagination_params.dart';
import 'package:to_camp/core/service/toast_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/repositories/camping_repository.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
import 'package:to_camp/presentation/camping/location/widgets/location_camping_map.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_view_model.dart';
import 'package:to_camp/presentation/camping/location/utils/location_utils.dart';
import 'package:to_camp/core/models/pagination_state.dart';

final locationCampingViewModelProvider = NotifierProvider(
  () => LocationCampingViewModel(),
);

class LocationCampingViewModel extends Notifier<PaginationState> {
  CampingRepository get repository =>
      ref.read(campingRepositoryProvider);

  @override
  PaginationState build() {
    paginate();
    return PaginationLoading();
  }

  Future<void> paginate({bool fetchMore = false}) async {
    const radius = 20000.0;
    const take = 30;

    PaginationParams params = PaginationParams(
      take: take,
      pageNo: 0,
      radius: radius,
    );

    try {
      /// 초기값 정의
      if (fetchMore) {
        final pState = state as PaginationSuccess<CampingModel>;
        state = PaginationFetchingMore(
          items: pState.items,
          hasMore: pState.hasMore,
        );
      } else {
        state = PaginationLoading();
      }

      final cameraPosition = ref.read(cameraPositionProvider);

      /// 지도를 움직인 적이 있다면
      if (cameraPosition != null) {
        params = params.copyWith(
          lat: cameraPosition.target.latitude,
          lng: cameraPosition.target.longitude,
          radius: radius,
          take: take,
          // radius: LocationUtils.radiusByZoom(cameraPosition.zoom),
          // take: LocationUtils.takeByZoom(cameraPosition.zoom),
        );

        /// 그렇지 않으면 초기 페이지네이션
      } else {
        final location = ref.read(locationViewModelProvider);

        // 위치 정보를 받아왔다면 내 주변 기준
        if (location is LocationSuccess) {
          params = params.copyWith(
            lat: location.lat,
            lng: location.lng,
          );

          // 에러가 났다면 서울 기준
        } else {
          params = params.copyWith(
            lat: LAT_OF_SEOUL,
            lng: LNG_OF_SEOUL,
          );
        }
      }

      final resp = await repository.getLocationBasedList(params);

      /// 거리순 정렬
      final pItems = LocationUtils.sortByDistance(
        resp.items,
        params.lat!,
        params.lng!,
      );

      state = PaginationSuccess(items: pItems, hasMore: true);
    } catch (e) {
      if (state is PaginationSuccess) {
        final pState = state as PaginationSuccess<CampingModel>;
        state = PaginationFetchingError(
          message: e.toString(),
          items: pState.items,
          hasMore: pState.hasMore,
        );
      } else {
        state = PaginationError(message: e.toString());
      }
    }
  }

  Future<void> onTapMarker({
    required List<CampingModel> models,
    required CampingModel targetModel,
  }) async {
    if (models.isEmpty) return;

    final mapController = ref.read(mapControllerProvider);
    if (mapController != null) {
      /// index 변경
      final index = models.indexWhere((e) => e.id == targetModel.id);
      ref.read(locationIndexProvider.notifier).state = index;

      /// 카메라 이동 (선)
      await _animateCameraByZoom(mapController, targetModel);

      /// 카드 띄우기 (후)
      ref.read(showCardProvider.notifier).state = true;

      /// info 보여주기
      mapController.showMarkerInfoWindow(MarkerId(targetModel.id));
    }
  }

  void onTapShowCard(
    BuildContext context,
    List<CampingModel> models,
    CampingModel targetModel,
  ) {
    final showCard = ref.read(showCardProvider);

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
        /// UI 숨기기
        ref.read(showRefreshProvider.notifier).state = false;
        ref.read(showCardProvider.notifier).state = false;

        await paginate(fetchMore: true);

        if (state is PaginationSuccess<CampingModel>) {
          final pState = state as PaginationSuccess<CampingModel>;
          final models = pState.items;

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
        }
      },
    );
  }

  Future<void> _animateCameraByZoom(
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
