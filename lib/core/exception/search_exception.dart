import 'package:to_camp/core/exception/custom_exception.dart';

class SearchCampingException extends CustomException {
  final String keyword;
  SearchCampingException(this.keyword)
    : super('"$keyword" 검색 중 오류가 발생했습니다.');
}
