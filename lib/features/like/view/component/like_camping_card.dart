import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';

class LikeCampingCard extends ConsumerWidget {
  final String thumbUrl;
  final String name;
  final String lineIntro;
  final String intro;
  final String doNm;
  final String sigunguNm;
  final String address;
  final String sbrsCl;
  final String posblFcltyCl;
  final Widget likeButton;
  const LikeCampingCard({
    super.key,
    required this.thumbUrl,
    required this.name,
    required this.lineIntro,
    required this.intro,
    required this.doNm,
    required this.sigunguNm,
    required this.address,
    required this.sbrsCl,
    required this.posblFcltyCl,
    required this.likeButton,
  });

  factory LikeCampingCard.fromModel({
    required CampingModel model,
    required Widget likeButton,
  }) {
    return LikeCampingCard(
      thumbUrl: model.thumbUrl,
      name: model.name,
      lineIntro: model.lineIntro,
      intro: model.intro,
      doNm: model.doNm,
      sigunguNm: model.sigunguNm,
      address: model.address,
      sbrsCl: model.sbrsCl,
      posblFcltyCl: model.posblFcltyCl,
      likeButton: likeButton,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                NameBox(name: name, theme: theme),
                Text(
                  '$doNm $sigunguNm',
                  style: theme.typo.subtitle1.copyWith(
                    color: theme.color.onHintContainer,
                  ),
                ),
                IntroBox(
                  lineIntro: lineIntro,
                  intro: intro,
                  theme: theme,
                  maxLine: 2,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: ImageBox(
              aspectRatio: 1,
              thumbUrl: thumbUrl,
              likeButton: likeButton,
            ),
          ),
        ],
      ),
    );
  }
}
