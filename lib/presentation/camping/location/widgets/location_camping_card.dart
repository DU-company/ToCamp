import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/base/widgets/address_box.dart';
import 'package:to_camp/presentation/camping/base/widgets/features_box.dart';
import 'package:to_camp/presentation/camping/base/widgets/etc_box.dart';
import 'package:to_camp/presentation/camping/base/widgets/image_box.dart';
import 'package:to_camp/presentation/camping/base/widgets/intro_box.dart';
import 'package:to_camp/presentation/camping/base/widgets/name_box.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/like_button.dart';

class LocationCampingCard extends ConsumerWidget {
  final CampingModel model;
  const LocationCampingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    final size = MediaQuery.of(context).size;
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      height: context.layout(200, mobile: 120),
      width: context.layout(null, desktop: size.width / 2),
      decoration: BoxDecoration(
        color: theme.color.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.only(
        right: 12,
        left: context.layout(12, tablet: null, desktop: null),
        bottom: safeAreaBottom + 88,
      ),
      padding: const EdgeInsets.all(8),

      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameBox(name: model.name, theme: theme),
                  AddressBox(
                    doNm: model.doNm,
                    sigunguNm: model.sigunguNm,
                    address: model.address,
                    isDetail: false,
                  ),
                ],
              ),
            ),
            ImageBox(
              radius: 6,
              thumbUrl: model.thumbUrl,
              aspectRatio: 1,
              likeButton: LikeButton(
                campingModel: model,
                position: 0,
                size: context.layout(32, mobile: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
