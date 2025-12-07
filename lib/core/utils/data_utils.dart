abstract class DataUtils {
  static int toJsonDateToInt(DateTime time) {
    return time.toUtc().microsecondsSinceEpoch;
  }

  static DateTime fromJsonIntToDate(int number) {
    return DateTime.fromMicrosecondsSinceEpoch(number).toLocal();
  }

  /// 참이면 1, 거짓이면 0
  static int toJsonBoolToInt(bool value) {
    return value ? 1 : 0;
  }

  static bool fromJsonIntToBool(int number) {
    return number == 1;
  }
}
