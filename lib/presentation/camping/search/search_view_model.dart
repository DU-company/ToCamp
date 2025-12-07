import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/core/models/pagination_params.dart';
import 'package:to_camp/core/provider/current_camping_provider.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/repositories/camping_repository.dart';
import 'package:to_camp/core/models/pagination_state.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';

/// 실제 서버에서 키워드 기반 검색 결과(Category & Shared 에서 사용)
final searchViewModelProvider = NotifierProvider.family(
  (String keyword) => SearchViewModel(keyword),
);

class SearchViewModel extends Notifier<PaginationState> {
  final String keyword;
  SearchViewModel(this.keyword);

  CampingRepository get repository =>
      ref.read(campingRepositoryProvider);
  @override
  PaginationState build() {
    paginate();
    return PaginationLoading();
  }

  Future<void> paginate() async {
    try {
      state = PaginationLoading();

      final params = PaginationParams(
        take: 500,
        pageNo: 1,
        keyword: keyword,
      );
      final resp = await repository.getSearchList(params);
      ref.read(selectedCampingProvider.notifier).state =
          resp.items.firstOrNull;

      state = resp;
    } catch (e) {
      state = PaginationError(message: e.toString());
    }
  }

  void routeToCampingScreen(BuildContext context) {
    if (state is PaginationSuccess) {
      final pState = state as PaginationSuccess<CampingModel>;
      context.pushNamed(
        CampingScreen.routeName,
        extra: pState.items,
        pathParameters: {'title': keyword},
      );
    }
  }
}
