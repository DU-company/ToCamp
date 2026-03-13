import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/wishlist_model.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/dialog/delete_wishlist_confirm_dialog.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:collection/collection.dart';
import 'package:to_camp/presentation/common/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/presentation/common/widgets/tile.dart';

class WishlistDetailScreen extends ConsumerWidget {
  static String get routeName => 'wishlist-detail';

  final String id;
  final String name;
  const WishlistDetailScreen({
    super.key,
    required this.id,
    required this.name,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.read(themeServiceProvider);
    final wishlist = ref.watch(wishlistViewModelProvider);

    final items = wishlist
        .firstWhereOrNull((e) => e.id.toString() == id)
        ?.items;

    return CampingScreen(
      items: items ?? [],
      title: name,
      emptyMessage: '위시리스트가 비어있어요!',
      onPressed: () => showModalBottomSheet(
        context: context,
        builder: (context) => BaseBottomSheet(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tile(
                text: '이름 변경',
                onTap: () {},
                icon: PhosphorIcons.pencilSimpleLine(),
              ),
              Tile(
                text: '위시리스트 삭제',
                onTap: () {
                  context.pop();
                  showDialog(
                    context: context,
                    builder: (context) => DeleteWishlistConfirmDialog(
                      wishlistModel: wishlist.firstWhere(
                        (e) => e.id.toString() == id,
                      ),
                    ),
                  );
                },
                icon: PhosphorIcons.trashSimple(),
                color: theme.color.secondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
