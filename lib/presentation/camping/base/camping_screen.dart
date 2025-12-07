import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/common/widgets/custom_divider.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/common/widgets/base_custom_scroll_view.dart';
import 'package:to_camp/presentation/common/layout/default_layout.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/base/based_list_view_model.dart';
import 'package:to_camp/presentation/camping/base/widgets/camping_card.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/like_button.dart';

class CampingScreen extends ConsumerWidget {
  static String get routeName => 'camping';

  final List<CampingModel> items;
  final String? emptyMessage;
  final String title;
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
      child: BaseCustomScrollView(
        slivers: [
          SliverAppBar(title: Text(title), floating: true),

          if (hasData)
            SliverList.separated(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final model = items[index];
                return GestureDetector(
                  onTap: () => ref
                      .read(basedListViewModelProvider.notifier)
                      .onCampingCardTap(context, model),

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
              child: Center(
                child: Text(
                  emptyMessage!,
                  style: theme.typo.subtitle1,
                ),
              ),
            ),
        ],
        hasBox: false,
      ),
    );
  }
}
