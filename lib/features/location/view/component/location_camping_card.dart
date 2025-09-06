import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/features_box.dart';
import 'package:to_camp/features/camping/view/component/etc_box.dart';
import 'package:to_camp/features/camping/view/component/image_box.dart';
import 'package:to_camp/features/camping/view/component/intro_box.dart';
import 'package:to_camp/features/camping/view/component/name_box.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';

class LocationCampingCard extends ConsumerWidget {
  final CampingModel model;
  const LocationCampingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return _ResponsiveLocationCampingCard(
      imageBox: ImageBox(
        radius: 12,
        thumbUrl: model.thumbUrl,
        aspectRatio: 1.2,
        likeButton: LikeButton(
          campingModel: model,
          position: 0,
          size: context.layout(28, mobile: 24),
        ),
      ),
      nameBox: NameBox(name: model.name, theme: theme),
      introBox: IntroBox(
        lineIntro: model.lineIntro,
        intro: model.intro,
        theme: theme,
        maxLine: 3,
      ),
      addressBox: FeaturesAndAddressBox(
        sbrsCl: model.sbrsCl,
        posblFcltyCl: model.posblFcltyCl,
        theme: theme,
        doNm: model.doNm,
        address: model.address,
        sigunguNm: model.sigunguNm,
        maxLine: 1,
      ),
      etcBox: EtcBox(
        theme: theme,
        pet: model.pet,
        fire: model.fire,
        caravan: model.caravan,
        siteBottomCl1: model.siteBottomCl1,
        siteBottomCl2: model.siteBottomCl2,
        siteBottomCl3: model.siteBottomCl3,
        siteBottomCl4: model.siteBottomCl4,
        siteBottomCl5: model.siteBottomCl5,
      ),
    );
  }
}

class _ResponsiveLocationCampingCard extends ConsumerWidget {
  final Widget imageBox;
  final Widget nameBox;
  final Widget introBox;
  final Widget addressBox;
  final Widget etcBox;
  const _ResponsiveLocationCampingCard({
    super.key,
    required this.imageBox,
    required this.nameBox,
    required this.introBox,
    required this.addressBox,
    required this.etcBox,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final size = MediaQuery.of(context).size;

    return Container(
      width: context.layout(null, desktop: size.width / 2.5),
      decoration: BoxDecoration(
        color: theme.color.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: theme.deco.shadow,
      ),
      margin: EdgeInsets.only(
        right: 12,
        left: context.layout(12, desktop: null),
        bottom: 112,
      ),
      padding: EdgeInsets.all(8),

      /// Responsive UI
      child: context.layout(
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [nameBox, introBox],
                  ),
                ),
                const SizedBox(width: 4),

                Expanded(flex: 2, child: imageBox),
              ],
            ),
            addressBox,
            etcBox,
          ],
        ),
        desktop: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [nameBox, Spacer(), addressBox],
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(child: imageBox),
                ],
              ),
            ),
            const SizedBox(height: 8),
            etcBox,
            introBox,
          ],
        ),
      ),
    );
  }
}
