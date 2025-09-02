import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:to_camp/common/exception/location_exception.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/model/pagination_params.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/repository/camping_repository.dart';
import 'package:to_camp/features/location/model/location_model.dart';
import 'package:to_camp/features/location/provider/location_provider.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService(ref: ref);
});

class LocationService {
  final Ref ref;

  LocationService({required this.ref});

  Future<Position> requestPermission() async {
    bool isLocationEnabled;
    LocationPermission permission;

    /// GPS 사용 가능 여부 체크
    isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      throw GPSNotEnabledException();
    }

    /// 위치 권한 허용 여부 체크
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationPermissionDeniedException();
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw LocationPermissionDeniedException();
    }

    /// 위 단계를 모두 통과하면 위치 권한을 사용할 수 있는 환경임.
    return await Geolocator.getCurrentPosition();
  }

  Future<LocationSuccess> getLocation() async {
    try {
      final position = await requestPermission();

      return LocationSuccess(
        lat: position.latitude,
        lng: position.longitude,
      );
    } catch (e, s) {
      throw FailedGetLocationInfo();
    }
  }
}
