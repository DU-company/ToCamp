import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/supabase/model/error_state_model.dart';
import 'package:to_camp/common/supabase/repository/supabase_repository.dart';

final errorStateProvider = StateNotifierProvider((ref) {
  final repository = ref.read(supabaseRepositoryProvider);
  return ErrorStateProvider(repository);
});

class ErrorStateProvider extends StateNotifier<ErrorStateModel?> {
  final SupabaseRepository repository;

  ErrorStateProvider(this.repository) : super(null) {
    getErrorState();
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
