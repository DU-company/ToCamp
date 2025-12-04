import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/data_sources/local/recent_keyword_local_data_source.dart';
import 'package:to_camp/data/models/recent_keyword_model.dart';

final recentKeywordRepositoryProvider = Provider((ref) {
  final recentKeywordLocalDataSource = ref.read(
    recentKeywordLocalDataSourceProvider,
  );

  return RecentKeywordRepository(recentKeywordLocalDataSource);
});

class RecentKeywordRepository {
  final RecentKeywordLocalDataSource recentKeywordLocalDataSource;

  RecentKeywordRepository(this.recentKeywordLocalDataSource);

  Future<List<RecentKeywordModel>> getRecentKeywords() async {
    final resp = await recentKeywordLocalDataSource.fetchKeywords();
    return resp.map((e) => e.toModel()).toList();
  }

  Future<RecentKeywordModel> addKeyword(String keyword) async {
    final now = DateTime.now();
    final model = RecentKeywordModel(
      keyword: keyword,
      createdAt: now,
    );
    await recentKeywordLocalDataSource.insertKeyword(model);
    return model;
  }

  Future<void> removeKeyword(String keyword) async {
    await recentKeywordLocalDataSource.deleteKeyword(keyword);
  }
}
