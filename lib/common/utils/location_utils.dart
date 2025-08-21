import 'package:geolocator/geolocator.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

class LocationUtils {
  static double radiusByZoom(double zoom) {
    if (zoom > 9.0) {
      //
      return 30000;
    } else {
      //max zoom일떄는 전국을 다 보려는 의도가 있기때문에 그냥 최대치로 넣어준다.
      return 500000;
    }
  }

  static int takeByZoom(double zoom) {
    if (zoom > 9.0) {
      return 50;
    } else {
      return 100;
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
