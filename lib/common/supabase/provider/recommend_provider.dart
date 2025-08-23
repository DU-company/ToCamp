import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/supabase/model/camping_recommendation_model.dart';
import 'package:to_camp/common/supabase/repository/supabase_repository.dart';

final recommendProvider =
    StateNotifierProvider<
      RecommendProvider,
      List<CampingRecommendationModel>
    >((ref) {
      final repository = ref.watch(supabaseRepositoryProvider);
      return RecommendProvider(repository: repository);
    });

class RecommendProvider
    extends StateNotifier<List<CampingRecommendationModel>> {
  final SupabaseRepository repository;

  RecommendProvider({required this.repository}) : super([]) {
    getRecommendations();
  }

  Future<void> getRecommendations() async {
    final resp = await repository.getRecommendations();
    state = resp;
  }
}
