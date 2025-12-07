import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';

final toastServiceProvider = Provider(
  (ref) => ToastService(ref: ref),
);

class ToastService {
  final Ref ref;

  ToastService({required this.ref});

  Future<void> showToast({
    required String text,
    bool isError = true,
  }) async {
    final theme = ref.read(themeServiceProvider);

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
    );
  }

  static DateTime? currentBackPressTime;
  static Future<bool> onWillPop(WidgetRef ref) async {
    DateTime now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) >
            const Duration(seconds: 2)) {
      currentBackPressTime = now;

      ref
          .read(toastServiceProvider)
          .showToast(text: "'뒤로' 버튼을 한 번 더 누르면 종료됩니다.");
      return false;
    }
    return true;
  }
}
