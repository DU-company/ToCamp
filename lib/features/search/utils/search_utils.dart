import 'package:to_camp/features/camping/model/camping_model.dart';

abstract class SearchUtils {
  static List<CampingModel> filterByKeyword(
    String keyword,
    List<CampingModel> items,
  ) {
    return items
        .where(
          (e) =>
              e.name.contains(keyword) ||
              e.doNm.contains(keyword) ||
              e.sigunguNm.contains(keyword) ||
              e.address.contains(keyword) ||
              e.intro.contains(keyword) ||
              e.lineIntro.contains(keyword),
        )
        .toList();
  }
}
