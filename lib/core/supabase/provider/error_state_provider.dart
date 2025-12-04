import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/supabase/model/error_state_model.dart';
import 'package:to_camp/core/supabase/repository/supabase_data_source.dart';

final errorStateProvider = NotifierProvider(
  () => ErrorStateProvider(),
);

class ErrorStateProvider extends Notifier<ErrorStateModel?> {
  SupabaseRepository get repository =>
      ref.read(supabaseRepositoryProvider);
  @override
  ErrorStateModel? build() {
    getErrorState();
    return null;
  }

  Future<void> getErrorState() async {
    try {
      final resp = await repository.getErrorState();
      state = resp;
    } catch (e) {
      state = null;
    }
  }
}
