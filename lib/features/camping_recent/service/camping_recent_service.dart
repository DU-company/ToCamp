import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping_recent/entity/recent_camping_entity.dart';
import 'package:to_camp/features/camping_recent/repository/recent_camping_repository.dart';

final campingRecentServiceProvider = Provider((ref) {
  final recentCampingRepository = ref.watch(
    recentCampingRepositoryProvider,
  );
  return CampingRecentService(
    recentCampingRepository: recentCampingRepository,
  );
});

class CampingRecentService {
  final RecentCampingRepository recentCampingRepository;

  CampingRecentService({required this.recentCampingRepository});

  Future<List<CampingModel>> getAllData() async {
    final resp = await recentCampingRepository.getRecentCampings();
    return resp.map((e) => e.toCampingModel()).toList();
  }

  Future<List<CampingModel>> insertRecentCamping(
    CampingModel campingModel,
  ) async {
    final resp = await getAllData();
    List<CampingModel> models = [...resp];

    /// 같은 ID를 가진 캠핑장이 존재하면 해당 캠핑장 삭제
    if (resp.any((e) => e.id == campingModel.id)) {
      print('삭제1');
      await recentCampingRepository.deleteRecentCamping(
        campingModel.id,
      );
      models.removeWhere((e) => e.id == campingModel.id);
    }

    /// 30개가 넘으면 삭제 후 추가
    if (models.length >= 30) {
      print('삭제2');
      final id = resp.last.id;
      await recentCampingRepository.deleteRecentCamping(id);
    }

    final entity = RecentCampingEntity.fromCampingModel(
      model: campingModel,
    );
    await recentCampingRepository.insertRecentCamping(entity);
    return getAllData();
  }

  Future<List<CampingModel>> deleteRecentCamping(String id) async {
    await recentCampingRepository.deleteRecentCamping(id);
    return getAllData();
  }
}
