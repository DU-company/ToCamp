import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/common/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/bottom_sheet/category_form_bottom_sheet.dart';
import 'package:to_camp/presentation/camping/wishlist/widgets/wishlist_view.dart';

class SelectCategoryBottomSheet extends ConsumerWidget {
  final CampingModel campingModel;
  final bool isLiked;

  const SelectCategoryBottomSheet({
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
            child: WishlistGridView(
              isAdding: true,
              campingModel: campingModel,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: PrimaryButton(
              radius: 8,
              onPressed: () => showFormBottomSheet(context),
              text: '카테고리 만들기',
            ),
          ),
        ],
      ),
    );
  }

  void showFormBottomSheet(BuildContext context) {
    context.pop();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CategoryFormBottomSheet(
            isEdit: false,
            campingModel: campingModel,
          ),
        );
      },
    );
  }
}
