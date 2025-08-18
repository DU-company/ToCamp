import 'package:flutter/material.dart';
import 'foundation/app_theme.dart';
import 'res/palette.dart';
import 'res/typo.dart';

class DarkTheme implements AppTheme {
  DarkTheme();

  @override
  Brightness brightness = Brightness.dark;

  @override
  AppColor color = AppColor(
    /// Surface
    surface: Palette.grey800,
    background: Palette.black.withValues(alpha: 0.55),

    /// Text
    text: Palette.grey100,
    subtext: Palette.grey500,

    ///Toast
    toastContainer: Palette.grey100.withValues(alpha: 0.85),
    onToastContainer: Palette.grey800,

    /// Hint
    hint: Palette.grey600,
    hintContainer: Palette.grey770,
    onHintContainer: Palette.grey350,

    /// Inactive
    inactive: Palette.grey500,
    inactiveContainer: Palette.grey700,
    onInactiveContainer: Palette.grey400,

    /// Accent
    primary: Palette.green,
    onPrimary: Palette.white,
    secondary: Palette.red,
    onSecondary: Palette.white,
    tertiary: Palette.yellow,
    onTertiary: Palette.white,
  );

  @override
  late AppTypo typo = AppTypo(typo: NotoSans(), fontColor: color.text);

  @override
  AppDeco deco = AppDeco(
    shadow: [
      BoxShadow(
        color: Palette.black.withValues(alpha: 0.35),
        blurRadius: 35,
      ),
    ],
  );
}
