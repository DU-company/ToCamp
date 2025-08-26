import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/common/theme/dark_theme.dart';
import 'package:to_camp/common/theme/foundation/app_theme.dart';
import 'package:to_camp/common/theme/light_theme.dart';
import 'package:to_camp/common/theme/res/layout.dart';

final themeServiceProvider =
    StateNotifierProvider<ThemeService, AppTheme>((ref) {
      return ThemeService();
    });

class ThemeService extends StateNotifier<AppTheme> {
  final box = Hive.box<bool>(THEME_BOX);

  ThemeService() : super(LightTheme()) {
    getTheme();
  }

  void getTheme() {
    /// Hive에 저장된 theme 가져오기
    final isLightTheme = box.get('isLightTheme');
    if (isLightTheme == null || isLightTheme) {
      state = LightTheme();
    } else {
      state = DarkTheme();
    }
  }

  Future<void> toggleTheme() async {
    if (state.brightness == Brightness.light) {
      state = DarkTheme();
      await box.put('isLightTheme', false);
    } else {
      state = LightTheme();
      await box.put('isLightTheme', true);
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
      titleTextStyle: theme.typo.subtitle1.copyWith(),
    ),

    iconTheme: IconThemeData(color: theme.color.text),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: theme.color.surface,
      selectedItemColor: theme.color.primary,
      unselectedItemColor: theme.color.inactive,
      type: BottomNavigationBarType.fixed,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      constraints: BoxConstraints(maxWidth: Breakpoint.bottomSheet),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: theme.color.primary,
      foregroundColor: theme.color.onPrimary,
      shape: CircleBorder(),
    ),
  );
});
