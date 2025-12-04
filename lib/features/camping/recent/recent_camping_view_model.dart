import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/repositories/recent_camping_repository.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';

final recentCampingViewModelProvider = NotifierProvider(
  () => RecentCampingViewModel(),
);

class RecentCampingViewModel extends Notifier<List<CampingModel>> {
  RecentCampingRepository get repository =>
      ref.read(recentCampingRepositoryProvider);
  @override
  List<CampingModel> build() {
    paginate();
    return [];
  }

  Future<void> paginate() async {
    final resp = await repository.getRecentCampingList();
    state = resp;
  }

  Future<void> addRecentCamping(CampingModel model) async {
    await repository.addRecentCamping(model);
    final index = state.indexWhere((e) => e.id == model.id);

    if (index == -1) {
      final items = [model, ...state];
      if (items.length > 30) {
        items.removeLast();
      }
      state = items;
    } else {
      final restItems = state.where((e) => e.id != model.id);
      state = [model, ...restItems];
    }
  }

  removeRecentCamping() {}

  void onRecentCampingTap(BuildContext context) {
    context.pushNamed(
      CampingScreen.routeName,
      extra: state,
      pathParameters: {'title': '최근 본 캠핑장'},
    );
  }
}
