import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';
import 'package:to_camp/features/like/view/component/like_camping_card.dart';

class CampingLikeScreen extends ConsumerWidget {
  static String get routeName => 'like';
  final String id;
  const CampingLikeScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeList = ref.watch(campingLikeProvider);
    final theme = ref.watch(themeServiceProvider);
    // final hasItem = likeList.any(
    //   (e) => e.likeCategory.id == int.parse(id),
    // );
    //
    // if (!hasItem) {
    //   return DefaultLayout(
    //     child: Center(child: Text('해당 카테고리는 비어있습니다.')),
    //   );
    // }

    final data = likeList.firstWhere(
      (e) => e.likeCategory.id.toString() == id,
    );
    final hasData = data.campingModels.isNotEmpty;

    return DefaultLayout(
      appBar: AppBar(),
      child: hasData
          ? ListView.separated(
              itemBuilder: (context, index) {
                final model = data.campingModels[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ref
                        .read(campingServiceProvider)
                        .onCampingCardTap(context, model);
                  },
                  child: LikeCampingCard.fromModel(
                    model: model,
                    likeButton: LikeButton(
                      campingModel: model,
                      position: 0,
                      size: 24,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: data.campingModels.length,
            )
          : Center(
              child: Text(
                '해당 카테고리는 비어있습니다.',
                style: theme.typo.headline6,
              ),
            ),
    );
  }
}
