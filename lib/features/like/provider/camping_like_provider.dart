import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/service/camping_like_service.dart';

final campingLikeProvider =
    StateNotifierProvider<
      CampingLikeStateNotifier,
      List<CampingModel>
    >((ref) {
      final campingLikeService = ref.watch(
        campingLikeServiceProvider,
      );
      return CampingLikeStateNotifier(
        campingLikeService: campingLikeService,
      );
    });

class CampingLikeStateNotifier
    extends StateNotifier<List<CampingModel>> {
  final CampingLikeService campingLikeService;

  CampingLikeStateNotifier({required this.campingLikeService})
    : super([]) {
    getLikeData();
  }

  void getLikeData() {
    try {
      final resp = campingLikeService.getLikeData();
      state = resp;
    } catch (e, s) {
      print('좋아요 목록 Fetch 실패 : $e $s');
      state = [];
    }
  }

  Future<void> onLikePressed(CampingModel campingModel) async {
    try {
      final resp = await campingLikeService.onLikePressed(
        campingModel,
      );
      state = resp;
    } catch (e, s) {
      print('onPressed 에러 발생 : $e $s');
      getLikeData();
    }
  }
}
