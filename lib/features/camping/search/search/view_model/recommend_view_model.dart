import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/supabase/model/camping_recommendation_model.dart';
import 'package:to_camp/core/supabase/repository/supabase_data_source.dart';

final recommendViewModelProvider = NotifierProvider(
  () => RecommendViewModel(),
);

class RecommendViewModel
    extends Notifier<List<CampingRecommendationModel>> {
  SupabaseRepository get repository =>
      ref.read(supabaseRepositoryProvider);
  @override
  List<CampingRecommendationModel> build() {
    getRecommendations();
    return [];
  }

  Future<void> getRecommendations() async {
    try {
      final resp = await repository.getRecommendations();
      state = resp;
    } catch (e) {
      /// 에러 발생 시, 1개의 데이터를 반환
      state = [CampingRecommendationModel(region: '에러', priority: 1)];
    }
  }
}
