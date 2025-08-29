import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/model/pagination_params.dart';
import 'package:to_camp/common/provider/current_camping_provider.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/camping_detail/model/camping_image_item.dart';
import 'package:to_camp/features/camping_detail/repository/camping_detail_repository.dart';

final campingDetailServiceProvider = Provider((ref) {
  final campingDetailRepository = ref.watch(
    campingDetailRepositoryProvider,
  );
  return CampingDetailService(
    campingDetailRepository: campingDetailRepository,
    ref: ref,
  );
});

class CampingDetailService {
  final CampingDetailRepository campingDetailRepository;
  final Ref ref;

  CampingDetailService({
    required this.campingDetailRepository,
    required this.ref,
  });

  Future<CampingDetailModel> getDetailImages(String id) async {
    try {
      final campingModel = ref.read(currentCampingProvider)!;
      final params = PaginationParams(take: 30, pageNo: 1, id: id);
      final resp = await campingDetailRepository.getImages(params);

      /// Parsing
      final imgUrls = resp.response.body.items.item
          .map((e) => e.imageUrl)
          .toList();

      return CampingDetailModel(
        campingModel: campingModel,
        imgUrls: imgUrls,
      );
    } catch (e, s) {
      print('Camping_Detail_Error : $e $s');
      rethrow;
    }
  }
}
