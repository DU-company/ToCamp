import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
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

  List<int> pageList = List.generate(50, (index) => index + 1)
    ..shuffle();

  Future<void> paginate({
    int take = 100,
    bool fetchingMore = false,
    bool forceReFetching = false,
  }) async {
    try {
      if (state is PaginationSuccess) {
        final pState = state as PaginationSuccess;
        final hasMore = pState.totalCount > pState.items.length;
        if (!hasMore || pageList.isEmpty) {
          print('hasMore : false');
          return;
        }
      }

      final isLoading = state is PaginationLoading;
      final isFetchingMore = state is PaginationFetchingMore;
      final isForceReFetching = state is PaginationReFetching;

      if (fetchingMore && isLoading ||
          isFetchingMore ||
          isForceReFetching) {
        print('로딩중');
        return;
      }

      int pageNo = pageList.last;

      if (fetchingMore) {
        final pState = state as PaginationSuccess<CampingModel>;
        state = PaginationFetchingMore(
          items: pState.items,
          totalCount: pState.totalCount,
        );
      } else {
        state = PaginationLoading();
      }

      final resp = await campingService.paginate(
        pageNo: pageNo,
        take: take,
      );

      pageList.removeLast();

      if (state is PaginationFetchingMore) {
        final pState = state as PaginationSuccess<CampingModel>;

        state = pState.copyWith(
          items: [...pState.items, ...resp.items],
          totalCount: resp.totalCount,
        );
      } else {
        state = PaginationSuccess<CampingModel>(
          items: resp.items,
          totalCount: resp.totalCount,
        );
      }
    } catch (e) {
      /// Pagination을 한 번 이상 한 경우에 에러가 발생했다면 기존 상태 유지
      if (state is PaginationSuccess) {
        final pState = state as PaginationSuccess<CampingModel>;
        state = PaginationErrorHasData<CampingModel>(
          items: pState.items,
          totalCount: pState.totalCount,
          // hasMore: pState.hasMore,
        );
      } else {
        state = PaginationError(message: e.toString());
      }
    }
  }
}
