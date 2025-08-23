import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/serach/service/search_camping_service.dart';

final searchCampingProvider =
    StateNotifierProvider.family<
      SearchCampingStateNotifier,
      PaginationState,
      String
    >((ref, keyword) {
      final searchCampingService = ref.watch(
        searchCampingServiceProvider,
      );
      return SearchCampingStateNotifier(
        searchCampingService: searchCampingService,
        keyword: keyword,
      );
    });

class SearchCampingStateNotifier
    extends StateNotifier<PaginationState> {
  final SearchCampingService searchCampingService;
  final String keyword;
  SearchCampingStateNotifier({
    required this.searchCampingService,
    required this.keyword,
  }) : super(PaginationLoading()) {
    paginate();
  }

  Future<void> paginate({int take = 30, int pageNo = 1}) async {
    try {
      state = PaginationLoading();
      final resp = await searchCampingService.paginate(
        keyword,
        take,
        pageNo,
      );
      state = resp;
    } catch (e) {
      if (state is PaginationSuccess) {
        final pState = state as PaginationSuccess<CampingModel>;
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
