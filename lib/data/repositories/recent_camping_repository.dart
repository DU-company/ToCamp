import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/data/data_sources/local/recent_camping_local_data_source.dart';
import 'package:to_camp/data/models/camping_model.dart';

final recentCampingRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(recentCampingLocalDataSourceProvider);
  return RecentCampingRepository(dataSource);
});

class RecentCampingRepository {
  final RecentCampingLocalDataSource dataSource;
  RecentCampingRepository(this.dataSource);

  Future<List<CampingModel>> getRecentCampingList() async {
    final resp = await dataSource.fetchRecentCampingList();
    return resp.map((e) => e.toCampingModel()).toList();
  }

  Future<void> addRecentCamping(CampingModel model) async {
    await dataSource.insertRecentCamping(model);
  }

  Future<void> removeRecentCamping(String id) async {
    await dataSource.deleteRecentCamping(id);
  }
}
