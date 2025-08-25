import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/model/camping_like_model.dart';

final campingLikeServiceProvider = Provider((ref) {
  return CampingLikeService(ref: ref);
});

class CampingLikeService {
  final Ref ref;

  CampingLikeService({required this.ref});

  final box = Hive.box<CampingLikeModel>(CAMPING_LIKE_BOX);

  List<CampingModel> getLikeData() {
    /// CampingLikeModel
    final resp = box.values.toList().reversed;

    /// CampingModel로 Parsing
    final pList = resp.map((e) => e.toCampingModel()).toList();
    return pList;
  }

  Future<List<CampingModel>> onLikePressed(
    CampingModel campingModel,
  ) async {
    final values = box.values;
    final isExists = values.any((e) => e.id == campingModel.id);

    /// 존재하는 캠핑장이면 삭제
    if (isExists) {
      return _removeCampingLike(campingModel);

      /// 새로운 캠핑장이면 추가
    } else {
      return _addCampingLike(campingModel);
    }
  }

  Future<List<CampingModel>> _addCampingLike(
    CampingModel campingModel,
  ) async {
    final length = box.values.length;
    String message;
    bool isError = false;
    if (length > 10) {
      message = '좋아요는 최대 100개의 캠핑장만 가능합니다.';
      isError = true;
      throw 'Error';
    } else {
      message = '찜 목록에 추가했습니다.';
      final likeModel = CampingLikeModel.fromCampingModel(
        campingModel,
      );
      await box.add(likeModel);
    }

    ref
        .read(toastUtilsProvider)
        .showToast(text: message, isError: isError);
    return getLikeData();
  }

  Future<List<CampingModel>> _removeCampingLike(
    CampingModel model,
  ) async {
    final index = box.values.toList().indexWhere(
      (e) => e.id == model.id,
    );
    await box.deleteAt(index);
    ref.read(toastUtilsProvider).showToast(text: '찜 목록에서 삭제했습니다.');
    return getLikeData();
  }
}
