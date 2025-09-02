import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/image/view/component/base_network_image.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';

class CampingMiniCard extends ConsumerWidget {
  final CampingModel campingModel;

  const CampingMiniCard({super.key, required this.campingModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: SizedBox(
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageBox(
              thumbUrl: campingModel.thumbUrl,
              likeButton: LikeButton(
                campingModel: campingModel,
                size: 24,
              ),
            ),

            NameBox(name: campingModel.name, theme: theme),

            Expanded(
              child: Text(
                '${campingModel.doNm} ${campingModel.sigunguNm}',
                maxLines: 2,
                style: theme.typo.subtitle2.copyWith(
                  color: theme.color.subtext,
                  fontWeight: theme.typo.semiBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
