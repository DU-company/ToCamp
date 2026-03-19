import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/core/service/toast_service.dart';
import 'package:to_camp/data/models/like_category_model.dart';
import 'package:to_camp/presentation/common/widgets/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/presentation/common/widgets/input_field.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_view_model.dart';
import 'package:flutter_riverpod/legacy.dart';

class CategoryFormBottomSheet extends ConsumerStatefulWidget {
  final bool isEdit;
  final CampingModel? campingModel;
  final LikeCategoryModel? categoryModel;
  const CategoryFormBottomSheet({
    super.key,
    required this.isEdit,
    this.campingModel,
    this.categoryModel,
  });

  @override
  ConsumerState<CategoryFormBottomSheet> createState() =>
      _CategoryFormBottomSheetState();
}

class _CategoryFormBottomSheetState
    extends ConsumerState<CategoryFormBottomSheet> {
  final TextEditingController nameController =
      TextEditingController();
  String categoryName = '';

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      nameController.text = widget.categoryModel!.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

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
            onChanged: (text) => setState(() {
              categoryName = text;
            }),
            controller: nameController,
          ),

          /// Submit Button
          const SizedBox(height: 8),
          PrimaryButton(
            text: widget.isEdit ? '이름 변경' : '카테고리 만들기',
            onPressed: categoryName.trim().isEmpty
                ? null
                : handleSubmit,
          ),
        ],
      ),
    );
  }

  Future<void> handleSubmit() async {
    final viewModel = ref.read(wishlistViewModelProvider.notifier);
    try {
      if (widget.isEdit) {
        await _editCategory(viewModel);
        ToastService.show(text: '이름이 변경되었습니다');
      } else {
        await _createCategory(viewModel);
        ToastService.show(text: '"$categoryName"에 추가되었습니다');
      }
      context.pop();
    } catch (e) {
      ToastService.show(text: e.toString(), isError: true);
    }
  }

  Future<void> _createCategory(WishlistViewModel vm) async {
    await vm.createCategory(
      name: categoryName,
      campingModel: widget.campingModel!,
    );
  }

  Future<void> _editCategory(WishlistViewModel vm) async {
    await vm.editCategoryName(
      categoryId: widget.categoryModel!.id,
      name: categoryName,
    );
  }
}
