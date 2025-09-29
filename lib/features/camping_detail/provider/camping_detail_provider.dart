import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/camping_detail/service/camping_detail_service.dart';

final campingDetailProvider =
    StateNotifierProvider.family<
      CampingDetailStateNotifier,
      CampingDetailState,
      String
    >((ref, id) {
      final campingDetailService = ref.watch(
        campingDetailServiceProvider,
      );
      return CampingDetailStateNotifier(
        campingDetailService: campingDetailService,
        id: id,
      );
    });

class CampingDetailStateNotifier
    extends StateNotifier<CampingDetailState> {
  final CampingDetailService campingDetailService;
  final String id;

  CampingDetailStateNotifier({
    required this.campingDetailService,
    required this.id,
  }) : super(CampingDetailLoading()) {
    getDetail();
  }

  Future<void> getDetail() async {
    try {
      state = CampingDetailLoading();
      final resp = await campingDetailService.getDetailImages(id);
      state = resp;
    } catch (e, s) {
      state = CampingDetailError(message: e.toString());
    }
  }
}
