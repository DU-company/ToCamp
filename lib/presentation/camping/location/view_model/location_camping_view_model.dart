import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/models/pagination_params.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/repositories/camping_repository.dart';
import 'package:to_camp/presentation/camping/location/screen/location_camping_screen.dart';
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

  Future<void> paginate({bool isReFetch = false}) async {
    PaginationParams params = PaginationParams(
      take: 30,
      pageNo: 0,
      radius: 20000,
    );

    try {
      /// 초기값 정의
      if (isReFetch) {
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
          radius: LocationUtils.radiusByZoom(cameraPosition.zoom),
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
}
