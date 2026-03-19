import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/data/models/like_category_model.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/dialog/delete_wishlist_confirm_dialog.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/category_card.dart';

class WishlistGridView extends ConsumerWidget {
  final bool isAdding;
  final CampingModel? campingModel;
  const WishlistGridView({required this.isAdding, this.campingModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistViewModelProvider);
    final theme = ref.watch(themeServiceProvider);

    /// TODO : 이거 그냥 ListView로 넣어도 되지 않나?
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          /// AppBar
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

          if (wishlist.isEmpty)
            SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 3,
                  ),
                  child: Text(
                    '카테고리가 존재하지 않습니다.',
                    style: theme.typo.subtitle1,
                  ),
                ),
              ),
            ),

          /// hasData
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: context.layout(
                2,
                tablet: 3,
                desktop: 4,
              ),
              mainAxisSpacing: 16,
              crossAxisSpacing: 8,
            ),
            itemCount: wishlist.length,
            itemBuilder: (context, index) {
              final wishlistModel = wishlist[index];

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onLongPress: isAdding
                    ? null
                    : () => onLongPress(context, wishlistModel),
                onTap: () => ref
                    .read(wishlistViewModelProvider.notifier)
                    .onTapCategory(
                      isAdding: isAdding,
                      context: context,
                      wishlistModel: wishlistModel,
                      campingModel: campingModel,
                    ),
                child: WishlistCard(model: wishlistModel),
              );
            },
          ),
        ],
      ),
    );
  }

  void onLongPress(
    BuildContext context,
    LikeCategoryModel categoryModel,
  ) {
    showDialog(
      context: context,
      builder: (context) =>
          DeleteCategoryConfirmDialog(model: categoryModel),
    );
  }
}
