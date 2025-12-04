import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/models/recent_keyword_model.dart';
import 'package:to_camp/data/repositories/recent_keyword_repository.dart';

final recentKeywordViewModelProvider = NotifierProvider(
  () => RecentKeywordViewModel(),
);

class RecentKeywordViewModel
    extends Notifier<List<RecentKeywordModel>> {
  RecentKeywordRepository get repository =>
      ref.read(recentKeywordRepositoryProvider);
  @override
  List<RecentKeywordModel> build() {
    loadKeywords();
    return [];
  }

  Future<void> loadKeywords() async {
    final resp = await repository.getRecentKeywords();
    state = resp;
  }

  Future<void> addKeyword(String keyword) async {
    final model = await repository.addKeyword(keyword);

    final index = state.indexWhere((e) => e.keyword == keyword);

    /// 존재하지 않는 단어라면
    if (index == -1) {
      final items = [model, ...state];
      if (items.length > 10) {
        items.removeLast();
      }
      state = items;

      /// 존재한다면
    } else {
      final restItems = state.where((e) => e.keyword != keyword);
      state = [model, ...restItems];
    }
  }

  Future<void> removeKeyword(String keyword) async {
    await repository.removeKeyword(keyword);

    state = state.where((e) => e.keyword != keyword).toList();
  }
}
