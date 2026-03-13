import 'package:to_camp/core/exception/custom_exception.dart';

class LocationServiceException extends CustomException {
  LocationServiceException() : super('');
}

class LocationPermissionDeniedException extends CustomException {
  LocationPermissionDeniedException() : super('');
}


class LocationBasedException extends CustomException {
  LocationBasedException() : super('주변 캠핑장 정보를 가져올 수 없습니다.');
}
