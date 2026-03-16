import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/base/widgets/address_box.dart';
import 'package:to_camp/presentation/camping/base/widgets/image_box.dart';
import 'package:to_camp/presentation/camping/base/widgets/name_box.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/like_button.dart';

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
              child: AddressBox(
                doNm: campingModel.doNm,
                sigunguNm: campingModel.sigunguNm,
                address: campingModel.address,
                isDetail: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
