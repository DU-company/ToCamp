import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/like/model/camping_like_model.dart';

class LikeCategoryCard extends ConsumerWidget {
  final CampingLikeModel campingLikeModel;
  const LikeCategoryCard({super.key, required this.campingLikeModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    final campingModels = campingLikeModel.campingModels;
    final hasData = campingModels.isNotEmpty;
    return SizedBox(
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImageBox(
            thumbUrl: hasData ? campingModels.first.thumbUrl : "",
            likeButton: null,
            aspectRatio: 1,
            radius: 28,
          ),
          const SizedBox(height: 2),
          Text(
            campingLikeModel.likeCategory.name,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.typo.headline6,
          ),
          const SizedBox(height: 2),
          Text(
            '${campingLikeModel.campingModels.length}개 저장됨',
            style: theme.typo.subtitle1.copyWith(
              color: theme.color.subtext,
            ),
          ),
        ],
      ),
    );
  }
}

// /// Badge
// Positioned(
// top: 0,
// right: 8,
// child: Container(
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: theme.color.primary,
// ),
// padding: EdgeInsets.all(12),
// child: Center(
// child: Text(
// '${campingLikeModel.campingModels.length}',
// style: theme.typo.subtitle1.copyWith(
// color: theme.color.onPrimary,
// fontWeight: theme.typo.semiBold,
// ),
// ),
// ),
// ),
// ),
