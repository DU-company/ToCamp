import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_camp/core/theme/foundation/app_theme.dart';
import 'package:to_camp/core/theme/light_theme.dart';
import 'package:to_camp/core/theme/res/palette.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';

abstract class ToastService {
  static Future<void> show({
    required String text,
    bool isError = false,
  }) async {
    final theme = LightTheme();

    final msg = text;

    await Fluttertoast.showToast(
      msg: msg,
      textColor: isError
          ? theme.color.onSecondary
          : theme.color.onPrimary,
      backgroundColor: isError
          ? theme.color.tertiary
          : theme.color.primary,
      gravity: ToastGravity.CENTER,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1,
    );
  }

  static DateTime? currentBackPressTime;

  static Future<bool> onWillPop(WidgetRef ref) async {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) >
            const Duration(seconds: 2)) {
      currentBackPressTime = now;

      show(text: "'뒤로' 버튼을 한 번 더 누르면 종료됩니다");
      return false;
    }
    return true;
  }
}
