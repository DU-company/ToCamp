import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/base/widgets/image_box.dart';
import 'package:to_camp/data/models/wishlist_model.dart';

class WishlistCard extends ConsumerWidget {
  final WishlistModel wishlistModel;
  const WishlistCard({super.key, required this.wishlistModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    final campingModels = wishlistModel.items;
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
            wishlistModel.name,
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.typo.headline6,
          ),

          /// Count
          const SizedBox(height: 2),
          Text(
            '${wishlistModel.items.length}개 저장됨',
            style: theme.typo.subtitle1.copyWith(
              color: theme.color.subtext,
            ),
          ),
        ],
      ),
    );
  }
}
