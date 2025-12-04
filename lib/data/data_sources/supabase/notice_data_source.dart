import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:to_camp/core/provider/supabase_provider.dart';

final noticeDataSourceProvider = Provider((ref) {
  final supabase = ref.read(supabaseProvider);
  return NoticeDataSource(supabase: supabase);
});

class NoticeDataSource {
  final SupabaseClient supabase;

  NoticeDataSource({required this.supabase});

  Future<Map<String, dynamic>?> fetchNotice() async {
    final resp = await supabase
        .from('notice')
        .select('title, content')
        .maybeSingle();

    return resp;
  }
}
