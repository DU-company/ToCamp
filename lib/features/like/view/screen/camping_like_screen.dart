import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';

class CampingLikeScreen extends ConsumerWidget {
  static String get routeName => 'like';
  final String categoryId;
  final String categoryName;
  const CampingLikeScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likeList = ref.watch(campingLikeProvider);
    final theme = ref.watch(themeServiceProvider);

    final hasItem = likeList.any(
      (e) => e.likeCategory.id.toString() == categoryId,
    );

    if (!hasItem) {
      return DefaultLayout(
        appBar: AppBar(title: Text(categoryName)),
        child: ErrorMessageWidget(
          message: '해당 카테고리는 비어있습니다.',
          onTap: null,
        ),
      );
    }

    final data = likeList.firstWhere(
      (e) => e.likeCategory.id.toString() == categoryId,
    );
    final hasData = data.campingModels.isNotEmpty;

    return DefaultLayout(
      appBar: AppBar(title: Text(categoryName), centerTitle: true),
      child: hasData
          ? ListView.separated(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              itemBuilder: (context, index) {
                final model = data.campingModels[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    ref
                        .read(campingServiceProvider)
                        .onCampingCardTap(context, model);
                  },
                  child: CampingCard.fromModel(
                    model: model,
                    likeButton: LikeButton(
                      campingModel: model,
                      position: 0,
                      size: 24,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => CustomDivider(),
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
