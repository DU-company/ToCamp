import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/camping/base/widgets/image_box.dart';
import 'package:to_camp/data/models/like_category_model.dart';

class WishlistCard extends ConsumerWidget {
  final LikeCategoryModel model;
  const WishlistCard.LikeCategoryCard({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    final campingModels = model.items;
    final hasData = campingModels.isNotEmpty;
    return SizedBox(
      height: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Image
          ImageBox(
            thumbUrl: hasData ? campingModels.first.thumbUrl : "",
            likeButton: null,
            aspectRatio: 1,
            radius: 28,
          ),

          /// Title
          const SizedBox(height: 2),
          Text(
            model.name,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.typo.headline6,
          ),

          /// Count
          const SizedBox(height: 2),
          Text(
            '${model.items.length}개 저장됨',
            style: theme.typo.body1.copyWith(
              color: theme.color.subtext,
              fontWeight: theme.typo.regular
            ),
          ),
        ],
      ),
    );
  }
}
