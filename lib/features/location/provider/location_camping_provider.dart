import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/location/service/location_camping_service.dart';

final locationCampingProvider =
    StateNotifierProvider<
      LocationCampingStateNotifier,
      PaginationState
    >((ref) {
      final locationCampingService = ref.watch(
        locationCampingServiceProvider,
      );
      return LocationCampingStateNotifier(
        locationCampingService: locationCampingService,
      );
    });

class LocationCampingStateNotifier
    extends StateNotifier<PaginationState> {
  final LocationCampingService locationCampingService;
  LocationCampingStateNotifier({required this.locationCampingService})
    : super(PaginationLoading()) {
    paginate();
  }

  Future<void> paginate({bool fetchingMore = false}) async {
    try {
      /// 지도를 옮겨 데이터를 다시 가져오는 경우
      if (fetchingMore) {
        final pState = state as PaginationSuccess<CampingModel>;
        state = PaginationFetchingMore<CampingModel>(
          items: pState.items,
          totalCount: pState.totalCount,
        );

        /// 데이터를 처음 가져오는 경우
      } else {
        state = PaginationLoading();
      }
      final resp = await locationCampingService.paginate();
      state = resp;
    } catch (e) {
      if (state is PaginationSuccess) {
        final pState = state as PaginationSuccess<CampingModel>;
        state = PaginationErrorHasData(
          items: pState.items,
          totalCount: pState.totalCount,
        );
      } else {
        state = PaginationError(message: e.toString());
      }
    }
  }
}
