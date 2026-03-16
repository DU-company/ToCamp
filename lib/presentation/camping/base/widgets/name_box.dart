import 'package:flutter/material.dart';
import 'package:to_camp/core/theme/foundation/app_theme.dart';
import 'package:to_camp/core/theme/res/layout.dart';

class NameBox extends StatelessWidget {
  final String name;
  final AppTheme theme;
  const NameBox({super.key, required this.name, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        name,
        maxLines: 2,
        style: context.layout(
          theme.typo.headline3,
          mobile: theme.typo.headline5,
        ),
      ),
    );
  }
}
