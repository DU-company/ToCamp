import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/common/model/pagination_params.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/provider/current_camping_provider.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/repository/camping_repository.dart';
import 'package:to_camp/features/camping_detail/view/screen/camping_detail_screen.dart';

final campingServiceProvider = Provider<CampingService>((ref) {
  final campingRepository = ref.watch(campingRepositoryProvider);
  return CampingService(
    campingRepository: campingRepository,
    ref: ref,
  );
});

class CampingService {
  final CampingRepository campingRepository;
  final Ref ref;
  CampingService({
    required this.campingRepository,
    required this.ref,
  });

  Future<PaginationSuccess<CampingModel>> paginate({
    required int pageNo,
    required int take,
  }) async {
    try {
      final params = PaginationParams(pageNo: pageNo, take: take);
      final resp = await campingRepository.paginate(params);

      return PaginationSuccess(
        items: resp.response.body.items.item,
        hasMore: true,
      );
    } catch (e, s) {
      print('Camping_Pagination_Error : $e $s');
      throw Exception(e);
    }
  }

  void onCampingCardTap(BuildContext context, CampingModel model) {
    ref.read(currentCampingProvider.notifier).state = model;
    context.pushNamed(
      CampingDetailScreen.routeName,
      queryParameters: {'id': model.id},
    );
  }
}
