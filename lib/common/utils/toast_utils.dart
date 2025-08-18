import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

final toastUtilsProvider = Provider(
  (ref) => ToastUtils(ref: ref),
);

class ToastUtils {
  final Ref ref;

  ToastUtils({required this.ref});

  Future<bool> onWillPop(DateTime? pressTime) {
    final theme = ref.read(themeServiceProvider);

    DateTime now = DateTime.now();

    if (pressTime == null ||
        now.difference(pressTime) > const Duration(seconds: 2)) {
      pressTime = now;
      const msg = "'뒤로' 버튼을 한 번 더 누르면 종료됩니다.";

      Fluttertoast.showToast(
        msg: msg,
        textColor: theme.color.hint,
        backgroundColor: theme.color.hintContainer,
      );
      return Future.value(false);
    }

    return Future.value(true);
  }
}
