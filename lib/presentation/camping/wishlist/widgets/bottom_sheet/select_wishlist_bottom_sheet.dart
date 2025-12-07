import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/common/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/add_wishlist_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/wishlist_view.dart';

class SelectWishlistBottomSheet extends ConsumerWidget {
  final CampingModel campingModel;
  final bool isLiked;

  const SelectWishlistBottomSheet({
    super.key,
    required this.campingModel,
    required this.isLiked,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: WishlistView(
              isAdding: true,
              campingModel: campingModel,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: PrimaryButton(
              onPressed: () => onCreateTap(context),
              text: '위시리스트 만들기',
              padding: 16,
            ),
          ),
        ],
      ),
    );
  }

  void onCreateTap(BuildContext context) {
    context.pop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddWishlistBottomSheet(campingModel: campingModel),
        );
      },
    );
  }
}
