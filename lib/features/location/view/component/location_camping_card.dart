import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';
import 'package:to_camp/features/location/view/component/show_card_button.dart';

class LocationCampingCard extends ConsumerWidget {
  final CampingModel model;
  const LocationCampingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          width: context.layout(null, desktop: size.width / 3),
          // height: context.layout(null, desktop: size.height / 1.5),
          decoration: BoxDecoration(
            color: theme.color.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: theme.deco.shadow,
          ),
          margin: EdgeInsets.only(
            right: 12,
            left: context.layout(12, desktop: null),
            bottom: Platform.isAndroid ? 82 : 112,
          ),
          child: CampingCard.fromModel(
            model: model,
            likeButton: LikeButton(
              campingModel: model,
              size: 28,
              position: 0,
            ),
            isHorizontal: context.layout(true, desktop: false),
            showIntro: context.layout(false, desktop: true),
            // isDetail: context.layout(false, desktop: true),
          ),
          // Column(
          //   children: [
          //     Row(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Expanded(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.stretch,
          //             children: [
          //               NameBox(name: model.name, theme: theme),
          //               IntroBox(
          //                 lineIntro: model.lineIntro,
          //                 intro: model.intro,
          //                 theme: theme,
          //                 maxLine: 3,
          //               ),
          //             ],
          //           ),
          //         ),
          //         const SizedBox(width: 4),
          //         Expanded(
          //           child: AspectRatio(
          //             aspectRatio: 1.2,
          //             child: ImageBox(
          //               thumbUrl: model.thumbUrl,
          //               likeButton: LikeButton(
          //                 campingModel: model,
          //                 size: 24,
          //                 position: 0,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //     FeaturesAndAddressBox(
          //       sbrsCl: model.sbrsCl,
          //       posblFcltyCl: model.posblFcltyCl,
          //       theme: theme,
          //       doNm: model.doNm,
          //       address: model.address,
          //       sigunguNm: model.sigunguNm,
          //       isDetail: false,
          //     ),
          //   ],
          // ),
        ),
      ],
    );
  }
}
