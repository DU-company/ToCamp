import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
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
                onTap: () {},
                text: '이름 변경',
                icon: PhosphorIcons.pencilSimpleLine(),
              ),
              Tile(
                onTap: () {},
                text: '위시리스트 삭제',
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
