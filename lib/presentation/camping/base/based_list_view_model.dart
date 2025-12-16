import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/camping/recent/recent_camping_view_model.dart';
import 'package:to_camp/core/models/pagination_state.dart';
import 'package:to_camp/core/models/pagination_params.dart';
import 'package:to_camp/core/provider/current_camping_provider.dart';
import 'package:to_camp/data/repositories/camping_repository.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
import 'package:to_camp/presentation/camping/detail/screen/camping_detail_screen.dart';

final basedListViewModelProvider = NotifierProvider(
  () => BasedListViewModel(),
);

class BasedListViewModel extends Notifier<PaginationState> {
  CampingRepository get repository =>
      ref.read(campingRepositoryProvider);
  @override
  PaginationState build() {
    paginate();
    return PaginationLoading();
  }

  Future<void> paginate({bool fetchMore = false}) async {
    try {
      state = PaginationLoading();

      final params = PaginationParams(take: 5000, pageNo: 1);
      final resp = await repository.getBasedList(params);
      final items = resp.items;
      items.shuffle();

      state = resp.copyWith(items: items);
    } catch (e) {
      state = PaginationError(message: e.toString());
    }
  }

  void onCampingCardTap(BuildContext context, CampingModel model) {
    ref.read(selectedCampingProvider.notifier).state = model;
    context.pushNamed(
      CampingDetailScreen.routeName,
      pathParameters: {'id': model.id},
    );

    // 최근 조회 캠핑장에 추가
    ref
        .read(recentCampingViewModelProvider.notifier)
        .addRecentCamping(model);
  }

  void routeToCampingScreen(BuildContext context) {
    if (state is PaginationSuccess<CampingModel>) {
      final pState = state as PaginationSuccess<CampingModel>;
      context.pushNamed(
        CampingScreen.routeName,
        extra: pState.items,
        pathParameters: {'title': '이런 캠핑장은 어때요?'},
      );
    }
  }
}
