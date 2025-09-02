import 'package:flutter/material.dart';
import 'package:to_camp/common/theme/foundation/app_theme.dart';
import 'package:to_camp/common/theme/res/layout.dart';

class FeaturesAndAddressBox extends StatelessWidget {
  final AppTheme theme;
  final String sbrsCl;
  final String posblFcltyCl;
  final String doNm;
  final String sigunguNm;
  final String address;
  final bool isDetail;
  final int maxLine;
  const FeaturesAndAddressBox({
    super.key,
    required this.theme,
    required this.sbrsCl,
    required this.posblFcltyCl,
    required this.doNm,
    required this.address,
    required this.sigunguNm,
    this.isDetail = false,
    this.maxLine = 2,
  });

  @override
  Widget build(BuildContext context) {
    final hasFeatures = sbrsCl.isNotEmpty || posblFcltyCl.isNotEmpty;
    final pAddress = isDetail ? address : '$doNm $sigunguNm';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// Features
        if (hasFeatures) const SizedBox(height: 8),
        if (hasFeatures)
          Text(
            splitText(sbrsCl + posblFcltyCl),
            maxLines: maxLine,
            overflow: TextOverflow.ellipsis,
            style: context.layout(
              theme.typo.subtitle1.copyWith(
                color: theme.color.onHintContainer,
              ),
              tablet: theme.typo.headline6.copyWith(
                color: theme.color.onHintContainer,
              ),
              desktop: theme.typo.headline5.copyWith(
                color: theme.color.onHintContainer,
              ),
            ),
          ),

        /// Address
        const SizedBox(height: 8),
        Text(
          pAddress,
          style: context.layout(
            theme.typo.subtitle1.copyWith(
              color: theme.color.subtext,
            ),
            tablet: theme.typo.headline6.copyWith(
              color: theme.color.subtext,
            ),
            desktop: theme.typo.headline5.copyWith(
              color: theme.color.subtext,
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  String splitText(String text) {
    if (text.isEmpty) return '';
    final split = text.split(',');
    final joined = split.join(' · ');
    return joined;
  }
}
