import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/features/serach/model/recent_keyword_model.dart';
import 'package:collection/collection.dart';

final recentKeywordServiceProvider = Provider((ref) {
  return RecentKeywordService();
});

class RecentKeywordService {
  final box = Hive.box<RecentKeywordModel>(RECENT_KEYWORD_BOX);

  List<RecentKeywordModel> getKeywords() {
    final resp = box.values.toList().reversed.toList();
    return resp;
  }

  Future<List<RecentKeywordModel>> addKeyword(String keyword) async {
    final length = box.values.length;
    final model = RecentKeywordModel(
      keyword: keyword,
      createdAt: DateTime.now(),
    );

    /// 같은 단어가 존재하는 지 확인
    final isExists =
        box.values.firstWhereOrNull((e) => e.keyword == keyword) !=
        null;

    if (isExists) {
      final existingKeyword = box.values.firstWhere(
        (e) => e.keyword == keyword,
      );
      await existingKeyword.delete();
    }

    /// 최대 검색기록 저장은 10개까지
    if (length >= 10) {
      box.deleteAt(0);
      await box.add(model);
    } else {
      await box.add(model);
    }

    return getKeywords();
  }

  Future<List<RecentKeywordModel>> deleteKeyword(
    String keyword,
  ) async {
    final recent = box.values.toList().reversed.toList();
    final model = recent.firstWhere((e) => e.keyword == keyword);
    await model.delete();
    return getKeywords();
  }
}
