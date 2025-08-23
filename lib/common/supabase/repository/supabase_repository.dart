import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_camp/common/supabase/model/camping_recommendation_model.dart';
import 'package:to_camp/common/supabase/provider/supabase_provider.dart';

final supabaseRepositoryProvider = Provider((ref) {
  final supabase = ref.watch(supabaseProvider);
  return SupabaseRepository(supabase: supabase);
});

class SupabaseRepository {
  final SupabaseClient supabase;

  SupabaseRepository({required this.supabase});

  Future<List<CampingRecommendationModel>>
  getRecommendations() async {
    try {
      final resp = await supabase
          .from('camping_recommendations')
          .select()
          .order('order', ascending: true)
          .limit(10);

      final models = resp
          .map((e) => CampingRecommendationModel.fromJson(e))
          .toList();

      return models;
    } catch (e) {
      return [];
    }
  }
}
