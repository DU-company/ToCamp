import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_state.dart';
import 'package:to_camp/core/service/location_service.dart';

final locationViewModelProvider = NotifierProvider(
  () => LocationViewModel(),
);

class LocationViewModel extends Notifier<LocationState> {
  LocationService get service => ref.read(locationServiceProvider);

  @override
  LocationState build() {
    state = LocationLoading();
    getCurrentLocation();
    return state;
  }

  Future<void> getCurrentLocation() async {
    try {
      state = LocationLoading();

      final position = await service.getCurrentPosition();
      state = LocationSuccess(
        lat: position.latitude,
        lng: position.longitude,
      );
    } catch (e, s) {
      state = LocationError(message: e.toString());
    }
  }
}
