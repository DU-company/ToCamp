import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/features/camping/repository/camping_repository.dart';
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

  Future<void> paginate() async {
    try {
      state = PaginationLoading();

      final resp = await campingService.paginate(pageNo: 1, take: 20);

      state = resp;
    } catch (e) {
      /// Pagination을 한 번 이상 한 경우에 에러가 발생했다면 기존 상태 유지
      if (state is PaginationSuccess) {
        final pState = state as PaginationSuccess;
        state = PaginationErrorHasData(
          items: pState.items,
          hasMore: pState.hasMore,
        );
      } else {
        state = PaginationError(message: e.toString());
      }
    }
  }
}
