import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/supabase/model/error_state_model.dart';
import 'package:to_camp/common/supabase/repository/supabase_repository.dart';

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
