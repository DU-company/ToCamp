import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/exception/camping_exception.dart';
import 'package:to_camp/common/pagination/model/pagination_params.dart';
import 'package:to_camp/common/provider/current_camping_provider.dart';
import 'package:to_camp/features/camping/repository/camping_repository.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';

final campingDetailServiceProvider = Provider((ref) {
  final campingRepository = ref.watch(campingRepositoryProvider);
  return CampingDetailService(
    campingRepository: campingRepository,
    ref: ref,
  );
});

class CampingDetailService {
  final CampingRepository campingRepository;
  final Ref ref;

  CampingDetailService({
    required this.campingRepository,
    required this.ref,
  });

  Future<CampingDetailModel> getDetailImages(String id) async {
    try {
      final campingModel = ref.read(currentCampingProvider)!;
      final params = PaginationParams(take: 30, pageNo: 1, id: id);
      final resp = await campingRepository.getImages(params);

      /// Parsing
      final imgUrls = resp.items.map((e) => e.imageUrl).toList();

      return CampingDetailModel(
        campingModel: campingModel,
        imgUrls: imgUrls,
      );
    } catch (e, s) {
      print('Camping_Detail_Error : $e $s');
      throw FailedCampingDetailException();
    }
  }
}
