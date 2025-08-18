import 'package:flutter/cupertino.dart';

abstract class Breakpoint {
  static const double mobile = 600;
  static const double tablet = 1000;
  static const double desktop = 1190;

  static const double bottomSheet = 600;
}

extension LayoutExt on BuildContext {
  double get width => MediaQuery.of(this).size.width;

  T layout<T>(T base, {T? mobile, T? tablet, T? desktop}) {
    if (width < Breakpoint.mobile) {
      return mobile ?? base;
    } else if (width < Breakpoint.tablet) {
      return tablet ?? base;
    } else {
      return desktop ?? base;
    }
  }
}
