import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/models/notice_model.dart';
import 'package:to_camp/data/repositories/supabase/notice_repository.dart';

final noticeViewModelProvider = NotifierProvider(
  () => NoticeViewModel(),
);

class NoticeViewModel extends Notifier<NoticeModel?> {
  NoticeRepository get repository =>
      ref.read(noticeRepositoryProvider);

  @override
  NoticeModel? build() {
    getNotice();
    return null;
  }

  Future<void> getNotice() async {
    try {
      final resp = await repository.getNotice();
      state = resp;
    } catch (e) {
      state = null;
    }
  }
}
