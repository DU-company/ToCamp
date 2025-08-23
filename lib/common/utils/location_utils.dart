import 'package:geolocator/geolocator.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

class LocationUtils {
  static double radiusByZoom(double zoom) {
    if (zoom > 9.0) {
      return 30000;
    } else {
      return 50000;
    }
  }

  static int takeByZoom(double zoom) {
    if (zoom > 9.0) {
      return 30;
    } else {
      return 50;
    }
  }

  static List<CampingModel> sortByDistance(
    List<CampingModel> models,
    double lat,
    double lng,
  ) {
    models.sort((a, b) {
      final distanceA = Geolocator.distanceBetween(
        lat,
        lng,
        a.lat,
        a.lng,
      );
      final distanceB = Geolocator.distanceBetween(
        lat,
        lng,
        b.lat,
        b.lng,
      );

      return distanceA.compareTo(distanceB);
    });
    return models;
  }
}
