import 'package:flutter/material.dart';
import 'package:to_camp/core/theme/foundation/app_theme.dart';
import 'package:to_camp/core/theme/res/layout.dart';

class FeatureBox extends StatelessWidget {
  final AppTheme theme;
  final String sbrsCl;
  final String posblFcltyCl;

  final int maxLine;
  const FeatureBox({
    super.key,
    required this.theme,
    required this.sbrsCl,
    required this.posblFcltyCl,
    this.maxLine = 2,
  });

  @override
  Widget build(BuildContext context) {
    final hasFeatures = sbrsCl.isNotEmpty || posblFcltyCl.isNotEmpty;

    if (hasFeatures) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Features
            Text(
              splitText(sbrsCl + posblFcltyCl),
              maxLines: maxLine,
              overflow: TextOverflow.ellipsis,
              style: context.layout(
                mobile: theme.typo.subtitle2.copyWith(
                  color: theme.color.onHintContainer,
                ),
                theme.typo.subtitle1.copyWith(
                  color: theme.color.onHintContainer,
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox();
  }

  String splitText(String text) {
    if (text.isEmpty) return '';
    final split = text.split(',');
    final joined = split.join(' · ');
    return joined;
  }
}
