import 'dart:io';

class PlatformUtils {
  static String getPlatformType() {
    return Platform.isIOS ? 'IOS' : 'ANDROID';
  }
}
