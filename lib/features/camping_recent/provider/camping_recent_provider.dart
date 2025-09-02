import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping_recent/service/camping_recent_service.dart';

final campingRecentProvider =
    StateNotifierProvider<
      CampingRecentStateNotifier,
      PaginationState
    >((ref) {
      final campingRecentService = ref.watch(
        campingRecentServiceProvider,
      );
      return CampingRecentStateNotifier(
        campingRecentService: campingRecentService,
      );
    });

class CampingRecentStateNotifier
    extends StateNotifier<PaginationState> {
  final CampingRecentService campingRecentService;

  CampingRecentStateNotifier({required this.campingRecentService})
    : super(PaginationLoading()) {
    getAll();
  }

  Future<void> getAll() async {
    try {
      state = PaginationLoading();
      final resp = await campingRecentService.getAllData();
      state = PaginationSuccess(items: resp, totalCount: 1);
    } catch (e) {
      print(e);
      state = PaginationError(message: '최근 캠핑장 조회 목록을 가져올 수 없습니다.');
    }
  }

  Future<void> addToRecent(CampingModel campingModel) async {
    try {
      state = PaginationLoading();

      final resp = await campingRecentService.insertRecentCamping(
        campingModel,
      );

      state = PaginationSuccess(items: resp, totalCount: 1);
    } catch (e) {
      print('추가 에러 : $e');
      state = PaginationError(message: '최근 캠핑장 조회 목록을 가져올 수 없습니다.');
    }
  }

  Future<void> deleteFromRecent(String id) async {
    try {
      state = PaginationLoading();
      final resp = await campingRecentService.deleteRecentCamping(id);
      state = PaginationSuccess(items: resp, totalCount: 1);
    } catch (e) {
      print('삭제 에러 : $e');
      state = PaginationError(message: '최근 캠핑장 조회 목록을 가져올 수 없습니다.');
    }
  }
}
