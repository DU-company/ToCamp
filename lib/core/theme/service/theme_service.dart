import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_camp/core/theme/dark_theme.dart';
import 'package:to_camp/core/theme/foundation/app_theme.dart';
import 'package:to_camp/core/theme/light_theme.dart';
import 'package:to_camp/core/theme/res/layout.dart';

final sharedPreferencesProvider = FutureProvider<SharedPreferences>(
  (ref) async => await SharedPreferences.getInstance(),
);

final themeServiceProvider = NotifierProvider(() => ThemeService());

class ThemeService extends Notifier<AppTheme> {
  @override
  AppTheme build() {
    getTheme();
    return LightTheme();
  }

  void getTheme() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);

    /// Hive에 저장된 theme 가져오기
    final isLightTheme = prefs.getBool('isLightTheme');

    if (isLightTheme == null || isLightTheme) {
      state = LightTheme();
    } else {
      state = DarkTheme();
    }
  }

  Future<void> toggleTheme() async {
    final prefs = await ref.read(sharedPreferencesProvider.future);

    if (state.brightness == Brightness.light) {
      state = DarkTheme();
      await prefs.setBool('isLightTheme', false);
    } else {
      state = LightTheme();
      await prefs.setBool('isLightTheme', true);
    }
  }
}

final themeDataProvider = Provider<ThemeData>((ref) {
  final theme = ref.watch(themeServiceProvider);

  return ThemeData(
    /// Scaffold
    scaffoldBackgroundColor: theme.color.surface,

    /// AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: theme.color.surface,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
      iconTheme: IconThemeData(color: theme.color.text),
      titleTextStyle: theme.typo.headline6.copyWith(
        fontWeight: theme.typo.regular,
      ),
    ),

    iconTheme: IconThemeData(color: theme.color.text),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: theme.color.surface,
      selectedItemColor: theme.color.primary,
      unselectedItemColor: theme.color.inactive,
      type: BottomNavigationBarType.fixed,
    ),

    bottomSheetTheme: const BottomSheetThemeData(
      constraints: BoxConstraints(maxWidth: Breakpoint.bottomSheet),
    ),
  );
});
