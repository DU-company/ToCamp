import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping/wishlist/widgets/wishlist_category_view.dart';

class WishlistCategoryScreen extends ConsumerWidget {
  const WishlistCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        Expanded(child: WishlistCategoryView(isAdding: false)),
        SizedBox(height: 80),
      ],
    );
  }
}
