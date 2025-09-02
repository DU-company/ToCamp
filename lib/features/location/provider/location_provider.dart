import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:to_camp/features/location/model/location_model.dart';
import 'package:to_camp/features/location/service/location_service.dart';

final locationProvider =
    StateNotifierProvider<LocationProvider, LocationState>((ref) {
      final locationService = ref.watch(locationServiceProvider);
      return LocationProvider(locationService: locationService);
    });

class LocationProvider extends StateNotifier<LocationState> {
  final LocationService locationService;
  LocationProvider({required this.locationService})
    : super(LocationLoading()) {
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      state = LocationLoading();
      final resp = await locationService.getLocation();
      state = resp;
    } catch (e, s) {
      state = LocationError(message: e.toString());
    }
  }
}
