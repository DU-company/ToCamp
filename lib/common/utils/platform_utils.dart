import 'dart:io';

abstract class PlatformUtils {
  static String getPlatformType() {
    return Platform.isIOS ? 'IOS' : 'ANDROID';
  }

  static double setMapBottomPadding() {
    return Platform.isAndroid ? 92.0 : 112.0;
  }

  static int setMarkerSize() {
    return Platform.isAndroid ? 90 : 120;
  }
}
