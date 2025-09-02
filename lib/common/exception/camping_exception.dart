import 'package:to_camp/common/exception/custom_exception.dart';

class PaginationException extends CustomException {
  PaginationException() : super('일시적으로 캠핑장 리스트를 불러올 수 없습니다.');
}

class FailedCampingDetailException extends CustomException {
  FailedCampingDetailException() : super('삭제되었거나 접근 불가능한 캠핑장입니다.');
}
