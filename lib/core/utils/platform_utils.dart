import 'dart:io';

abstract class PlatformUtils {
  static String getPlatformType() {
    return Platform.isIOS ? 'IOS' : 'ANDROID';
  }

  static int setMarkerSize() {
    return Platform.isAndroid ? 100 : 120;
  }
}
