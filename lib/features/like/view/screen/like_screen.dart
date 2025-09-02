import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/features/like/view/component/dialog/delete_category_confirm_dialog.dart';
import 'package:to_camp/features/like/view/screen/camping_like_screen.dart';
import 'package:to_camp/features/like/view/component/like_category_view.dart';

class LikeScreen extends ConsumerWidget {
  const LikeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: LikeCategoryView(
            onTap: (categoryId, name) {
              context.pushNamed(
                CampingLikeScreen.routeName,
                queryParameters: {
                  'id': categoryId.toString(),
                  'name': name,
                },
              );
            },
            onLongPress: (categoryId) {
              showDialog(
                context: context,
                builder: (context) => DeleteCategoryConfirmDialog(
                  categoryId: categoryId,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
