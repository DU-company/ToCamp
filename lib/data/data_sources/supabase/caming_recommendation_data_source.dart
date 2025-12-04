import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_camp/core/provider/supabase_provider.dart';

final recommendationDataSourceProvider = Provider((ref) {
  final supabase = ref.read(supabaseProvider);
  return RecommendationDataSource(supabase: supabase);
});

class RecommendationDataSource {
  final SupabaseClient supabase;

  RecommendationDataSource({required this.supabase});

  Future<List<Map<String, dynamic>>> fetchRecommendations() async {
    final resp = await supabase
        .from('camping_recommendations')
        .select()
        .order('priority', ascending: true)
        .limit(10);
    return resp;
  }
}
