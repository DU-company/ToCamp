import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/view/custom_scroll_widget.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';

class CampingScreen extends ConsumerWidget {
  static String get routeName => 'camping';

  final List<CampingModel> items;
  final String? emptyMessage;
  final String? title;
  const CampingScreen({
    super.key,
    required this.items,
    required this.title,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final hasData = items.isNotEmpty;

    return DefaultLayout(
      child: CustomScrollWidget(
        slivers: [
          if (title != null)
            SliverAppBar(title: Text(title!), floating: true),

          if (hasData)
            SliverList.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final model = items[index];
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(campingServiceProvider)
                        .onCampingCardTap(context, model);
                  },
                  child: CampingCard.fromModel(
                    model: model,
                    likeButton: LikeButton(campingModel: model),
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const CustomDivider(),
            ),

          if (!hasData && emptyMessage != null)
            SliverToBoxAdapter(
              child: Text(emptyMessage!, style: theme.typo.subtitle1),
            ),
        ],
        hasBox: false,
      ),
    );
  }
}
