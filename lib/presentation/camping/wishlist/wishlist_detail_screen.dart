import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/data/models/wishlist_model.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/wishlist_options_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/dialog/delete_wishlist_confirm_dialog.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:collection/collection.dart';

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
    final wishlist = ref.watch(wishlistViewModelProvider);

    final items = wishlist
        .firstWhereOrNull((e) => e.id.toString() == id)
        ?.items;

    return CampingScreen(
      items: items ?? [],
      title: name,
      emptyMessage: '위시리스트가 비어있어요!',
      onPressed: () =>
          showWishlistOptionsBottomSheet(context, wishlist),
    );
  }

  void showWishlistOptionsBottomSheet(
    BuildContext context,
    List<WishlistModel> wishlist,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) => WishlistOptionsBottomSheet(
        onTapDelete: () => _deleteWishlist(context, wishlist),
      ),
    );
  }

  void _deleteWishlist(
    BuildContext context,
    List<WishlistModel> wishlist,
  ) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => DeleteWishlistConfirmDialog(
        wishlistModel: wishlist.firstWhere(
          (e) => e.id.toString() == id,
        ),
      ),
    );
  }
}
