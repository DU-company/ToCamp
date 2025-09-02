import 'package:flutter/material.dart';
import 'package:to_camp/common/theme/foundation/app_theme.dart';
import 'package:to_camp/common/theme/res/layout.dart';

class IntroBox extends StatelessWidget {
  final String lineIntro;
  final String intro;
  final AppTheme theme;
  final int maxLine;
  const IntroBox({
    super.key,
    required this.lineIntro,
    required this.intro,
    required this.theme,
    required this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    final hasIntro = lineIntro.isNotEmpty || intro.isNotEmpty;
    final longerIntro = lineIntro.length > intro.length
        ? lineIntro
        : intro;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        if (hasIntro)
          Text(
            longerIntro,
            maxLines: maxLine,
            overflow: TextOverflow.ellipsis,
            style: context.layout(
              theme.typo.subtitle1.copyWith(
                height: 1.5,
                wordSpacing: 4,
              ),
              tablet: theme.typo.headline6.copyWith(
                height: 1.5,
                wordSpacing: 4,
                fontWeight: theme.typo.regular,
              ),
              desktop: theme.typo.headline5.copyWith(
                height: 1.5,
                wordSpacing: 4,
                fontWeight: theme.typo.regular,
              ),
            ),
          ),
      ],
    );
  }
}
