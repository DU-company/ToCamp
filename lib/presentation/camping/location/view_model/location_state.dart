abstract class LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final double lat;
  final double lng;

  LocationSuccess({required this.lat, required this.lng});
}

class LocationError extends LocationState {
  final DeviceLocationErrorType errorType;
  LocationError({required this.errorType});
}

enum DeviceLocationErrorType {
  locationService,
  permissionDenied,
  load,
}
