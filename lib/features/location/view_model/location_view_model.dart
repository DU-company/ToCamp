import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:to_camp/features/location/view_model/location_state.dart';
import 'package:to_camp/core/service/location_service.dart';
import 'package:flutter_riverpod/legacy.dart';

final locationViewModelProvider = NotifierProvider(
  () => LocationViewModel(),
);

class LocationViewModel extends Notifier<LocationState> {
  LocationService get service => ref.read(locationServiceProvider);

  @override
  LocationState build() {
    getCurrentLocation();
    return LocationLoading();
  }

  Future<void> getCurrentLocation() async {
    try {
      state = LocationLoading();
      final resp = await service.getLocation();
      state = resp;
    } catch (e, s) {
      state = LocationError(message: e.toString());
    }
  }
}
