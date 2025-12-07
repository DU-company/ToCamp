import 'package:flutter/material.dart';
import 'foundation/app_theme.dart';
import 'res/palette.dart';
import 'res/typo.dart';

class LightTheme implements AppTheme {
  LightTheme();
  @override
  Brightness brightness = Brightness.light;

  @override
  AppColor color = AppColor(
    /// Surface
    surface: Palette.grey100,
    background: Palette.black.withValues(alpha: 0.55),

    /// Text
    text: Palette.black,
    subtext: Palette.grey700,

    /// Toast
    toastContainer: Palette.black.withValues(alpha: 0.85),
    onToastContainer: Palette.grey100,

    /// Hint
    hint: Palette.grey300,
    hintContainer: Palette.grey200,
    onHintContainer: Palette.grey500,

    /// Inactive
    inactive: Palette.grey400,
    inactiveContainer: Palette.grey250,
    onInactiveContainer: Palette.white,

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
        color: Palette.black.withValues(alpha: 0.15),
        blurRadius: 35,
      ),
    ],
  );
}
