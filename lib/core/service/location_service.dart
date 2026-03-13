import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:to_camp/core/exception/location_exception.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

class LocationService {
  Future<Position> getCurrentPosition() async {
    try {
      await _checkPermission();

      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          timeLimit: Duration(seconds: 3),
          accuracy: LocationAccuracy.medium,
        ),
      );
    } catch (e) {
      final last = await Geolocator.getLastKnownPosition();
      if (last != null) return last;

      rethrow;
    }
  }

  Future<void> _checkPermission() async {
    // GPS Check
    final isLocationEnabled =
        await Geolocator.isLocationServiceEnabled();
    if (!isLocationEnabled) {
      throw LocationServiceException();
    }

    // Permission Check
    try {
      final permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        final newPermission = await Geolocator.requestPermission();

        if (newPermission == LocationPermission.denied ||
            newPermission == LocationPermission.deniedForever) {
          throw LocationPermissionDeniedException();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw LocationPermissionDeniedException();
      }
    } catch (e) {
      throw LocationPermissionDeniedException();
    }
  }
}
