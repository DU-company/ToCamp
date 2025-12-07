import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/camping/base/camping_screen.dart';
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
    );
  }
}
