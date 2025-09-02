import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/pagination/model/pagination_params.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';

final campingProvider =
    StateNotifierProvider<CampingStateNotifier, PaginationState>((
      ref,
    ) {
      final campingService = ref.watch(campingServiceProvider);
      return CampingStateNotifier(campingService: campingService);
    });

class CampingStateNotifier extends StateNotifier<PaginationState> {
  final CampingService campingService;

  CampingStateNotifier({required this.campingService})
    : super(PaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int take = 5000,
    bool fetchingMore = false,
    bool forceReFetching = false,
  }) async {
    try {
      final params = PaginationParams(take: take, pageNo: 1);
      state = await campingService.paginate(params);
    } catch (e) {
      /// Pagination을 한 번 이상 한 경우에 에러가 발생했다면 기존 상태 유지
      if (state is PaginationSuccess) {
        final pState = state as PaginationSuccess<CampingModel>;
        state = PaginationErrorHasData<CampingModel>(
          items: pState.items,
          totalCount: pState.totalCount,
        );
      } else {
        state = PaginationError(message: e.toString());
      }
    }
  }
}
