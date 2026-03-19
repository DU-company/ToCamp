import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/presentation/common/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/presentation/common/widgets/input_field.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:flutter_riverpod/legacy.dart';

final likeCategoryNameProvider = StateProvider.autoDispose((ref) => '');

class AddCategoryBottomSheet extends ConsumerWidget {
  final CampingModel campingModel;
  const AddCategoryBottomSheet({
    super.key,
    required this.campingModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final categoryName = ref.watch(likeCategoryNameProvider);

    return BaseBottomSheet(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            '카테고리 이름을 작성해 주세요.',
            style: theme.typo.subtitle1.copyWith(
              fontWeight: theme.typo.semiBold,
              color: theme.color.onHintContainer,
            ),
          ),
          const SizedBox(height: 8),

          InputField(
            maxLine: 1,
            hint: 'ex) 글램핑',
            onChanged: (text) {
              ref.read(likeCategoryNameProvider.notifier).state = text;
            },
          ),

          /// Submit Button
          const SizedBox(height: 8),
          PrimaryButton(
            text: '카테고리 만들기',
            onPressed: categoryName.trim().isEmpty
                ? null
                : () {
                    ref
                        .read(wishlistViewModelProvider.notifier)
                        .createCategory(context, campingModel);
                  },
          ),
        ],
      ),
    );
  }
}
