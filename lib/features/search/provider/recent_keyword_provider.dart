import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/search/model/recent_keyword_model.dart';
import 'package:to_camp/features/search/service/recent_keyword_service.dart';

final recentKeywordProvider = StateNotifierProvider((ref) {
  final recentKeywordService = ref.watch(
    recentKeywordServiceProvider,
  );
  return RecentKeywordStateNotifier(
    recentKeywordService: recentKeywordService,
  );
});

class RecentKeywordStateNotifier
    extends StateNotifier<List<RecentKeywordModel>> {
  final RecentKeywordService recentKeywordService;

  RecentKeywordStateNotifier({required this.recentKeywordService})
    : super([]) {
    getRecentKeywords();
  }

  Future<void> getRecentKeywords() async {
    try {
      final resp = recentKeywordService.getKeywords();
      state = resp;
    } catch (e) {
      print(e);
    }
  }

  Future<void> addKeyword(String keyword) async {
    final resp = await recentKeywordService.addKeyword(keyword);
    state = resp;
  }

  Future<void> deleteKeyword(String keyword) async {
    final resp = await recentKeywordService.deleteKeyword(keyword);
    state = resp;
  }
}
