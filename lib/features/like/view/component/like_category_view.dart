import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';
import 'package:to_camp/features/like/view/component/bottom_sheet/add_category_bottom_sheet.dart';
import 'package:to_camp/features/like/view/component/dialog/delete_category_confirm_dialog.dart';
import 'package:to_camp/features/like/view/component/like_category_card.dart';
import 'package:to_camp/features/like/view/screen/camping_like_screen.dart';

class LikeCategoryView extends ConsumerWidget {
  final void Function(int) onTap;
  final void Function(int) onLongPress;

  const LikeCategoryView({
    super.key,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(campingLikeProvider);
    final theme = ref.watch(themeServiceProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            titleSpacing: 0,
            centerTitle: false,
            title: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8,
              ),
              child: Text(
                '위시리스트',
                style: theme.typo.headline1.copyWith(fontSize: 32),
              ),
            ),
          ),

          if (data.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 3,
                  ),
                  child: Text(
                    '위시리스트가 존재하지 않습니다.',
                    style: theme.typo.subtitle1,
                  ),
                ),
              ),
            ),
          SliverGrid.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.7,
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 8,
                ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final campingLikeModel = data[index];
              final categoryId = campingLikeModel.likeCategory.id!;
              return GestureDetector(
                onLongPress: () => onLongPress(categoryId),
                onTap: () => onTap(categoryId),
                child: LikeCategoryCard(
                  campingLikeModel: campingLikeModel,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
