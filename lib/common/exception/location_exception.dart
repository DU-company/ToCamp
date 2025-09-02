import 'package:to_camp/common/exception/custom_exception.dart';

class GPSNotEnabledException extends CustomException {
  GPSNotEnabledException() : super('GPS를 사용할 수 없습니다.');
}

class LocationPermissionDeniedException extends CustomException {
  LocationPermissionDeniedException()
    : super(
        '위치 권한 접근이 거부되었습니다.'
        '\n기기의 환경설정에서 위치 권한을 허용해주세요.',
      );
}

class FailedGetLocationInfo extends CustomException {
  FailedGetLocationInfo()
    : super(
        '일시적으로 위치 정보를 가져올 수 없습니다.'
        '\n잠시 후 다시 시도해 주세요.',
      );
}

class FailedLocationPaginate extends CustomException {
  FailedLocationPaginate() : super('주변 캠핑장 정보를 가져올 수 없습니다.');
}
