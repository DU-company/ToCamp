import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

class DataUtils {
  static String radiusByZoom(double zoom) {
    if (zoom > 9.0) {
      return '30000';
    } else {
      //max zoom일떄는 전국을 다 보려는 의도가 있기때문에 그냥 최대치로 넣어준다.
      return '300000';
    }
  }

  static Future<List<CampingModel>> distanceCompare(
    List<CampingModel> models,
    double lng,
    double lat,
  ) async {
    models.sort((a, b) {
      final distanceA =
          Geolocator.distanceBetween(lat, lng, a.lat, a.lng);
      final distanceB =
          Geolocator.distanceBetween(lat, lng, b.lat, b.lng);

      return distanceA.compareTo(distanceB);
    });
    return models;
  }

  static String intToNumberFormat(int price) {
    final f = NumberFormat('###,###,###,###');
    return f.format(price);
  }

  static String addPadLeft(int time) {
    return time.toString().padLeft(2, '0');
  }
}
