import 'package:flutter/material.dart';
import 'package:to_camp/common/theme/foundation/app_theme.dart';
import 'package:to_camp/common/theme/res/layout.dart';

class NameBox extends StatelessWidget {
  final String name;
  final AppTheme theme;
  const NameBox({super.key, required this.name, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      maxLines: 2,
      style: context.layout(
        theme.typo.headline6,
        tablet: theme.typo.headline3,
        desktop: theme.typo.headline1,
      ),
    );
  }
}
