import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/model/camping_like_model.dart';
import 'package:to_camp/features/like/service/camping_like_service.dart';

final campingLikeProvider =
    StateNotifierProvider<
      CampingLikeStateNotifier,
      List<CampingLikeModel>
    >((ref) {
      final campingLikeService = ref.watch(
        campingLikeServiceProvider,
      );
      return CampingLikeStateNotifier(
        campingLikeService: campingLikeService,
      );
    });

class CampingLikeStateNotifier
    extends StateNotifier<List<CampingLikeModel>> {
  final CampingLikeService campingLikeService;

  CampingLikeStateNotifier({required this.campingLikeService})
    : super([]) {
    getAllData();
  }

  void getAllData() async {
    try {
      // campingLikeService.deleteDB();
      final resp = await campingLikeService.getAllData();
      state = resp;
    } catch (e, s) {
      print('Error $e $s');
      state = [];
    }
  }

  /// 카테고리 생성
  Future<void> createCategory(
    String name,
    CampingModel campingModel,
  ) async {
    try {
      final resp = await campingLikeService.createCategoryAndAdd(
        name,
        campingModel,
      );
      state = resp;
    } catch (e, s) {
      print('카테고리 생성 에러 $e $s');
    }
  }

  Future<void> deleteCategory(int id) async {
    try {
      final resp = await campingLikeService.deleteCategory(id);
      state = resp;
    } catch (e, s) {
      print('카테고리 삭제 에러 $e $s');
    }
  }

  Future<void> addToCategory(
    int categoryId,
    CampingModel campingModel,
  ) async {
    try {
      final resp = await campingLikeService.addToCategory(
        categoryId,
        campingModel,
      );
      state = resp;
    } catch (e, s) {
      print('좋아요 추가 에러 $e $s');
    }
  }

  Future<void> removeFromCategory(CampingModel campingModel) async {
    try {
      final resp = await campingLikeService.removeFromCategory(
        campingId: campingModel.id,
      );
      state = resp;
    } catch (e, s) {
      print('좋아요 삭제 에러 $e $s');
    }
  }
}
