import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

class DataUtils {
  static String intToNumberFormat(int price) {
    final f = NumberFormat('###,###,###,###');
    return f.format(price);
  }

  static String addPadLeft(int time) {
    return time.toString().padLeft(2, '0');
  }
}
