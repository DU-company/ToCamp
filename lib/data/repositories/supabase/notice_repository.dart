import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/data_sources/supabase/notice_data_source.dart';
import 'package:to_camp/data/models/notice_model.dart';

final noticeRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(noticeDataSourceProvider);
  return NoticeRepository(dataSource);
});

class NoticeRepository {
  final NoticeDataSource dataSource;

  NoticeRepository(this.dataSource);

  Future<NoticeModel?> getNotice() async {
    final resp = await dataSource.fetchNotice();

    if (resp == null) return null;
    return NoticeModel.fromJson(resp);
  }
}
