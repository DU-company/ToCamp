import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_camp/core/provider/supabase_provider.dart';

final bannerAdDataSourceProvider = Provider((ref) {
  final supabase = ref.read(supabaseProvider);
  return BannerAdDataSource(supabase: supabase);
});

class BannerAdDataSource {
  final SupabaseClient supabase;

  BannerAdDataSource({required this.supabase});

  Future<List<Map<String, dynamic>>> fetchBannerAd() async {
    final resp = await supabase
        .from('banner_ad')
        .select()
        .order('priority', ascending: true)
        .limit(10);

    return resp;
  }
}
