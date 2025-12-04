
abstract class LocationState {}

class LocationLoading extends LocationState {}

class LocationError extends LocationState {
  final String message;
  LocationError({required this.message});
}

class LocationSuccess extends LocationState {
  final double lat;
  final double lng;

  LocationSuccess({required this.lat, required this.lng});
}
