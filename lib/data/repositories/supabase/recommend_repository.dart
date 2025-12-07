import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/data_sources/supabase/caming_recommendation_data_source.dart';
import 'package:to_camp/data/models/recommendation_model.dart';

final recommendationRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(recommendationDataSourceProvider);
  return RecommendRepository(dataSource);
});

class RecommendRepository {
  final RecommendationDataSource dataSource;

  RecommendRepository(this.dataSource);

  Future<List<RecommendationModel>> getRecommendations() async {
    final resp = await dataSource.fetchRecommendations();

    final models = resp
        .map((e) => RecommendationModel.fromJson(e))
        .toList();

    return models;
  }
}
