import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';
import 'package:to_camp/features/like/view/component/bottom_sheet/add_category_bottom_sheet.dart';
import 'package:to_camp/features/like/view/component/like_category_view.dart';

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
            child: LikeCategoryView(
              onTap: (categoryId, name) {
                ref
                    .read(campingLikeProvider.notifier)
                    .addToCategory(categoryId, campingModel);
                ref
                    .read(toastUtilsProvider)
                    .showToast(
                      text: '"$name"에 추가되었습니다.',
                      isError: false,
                    );
                context.pop();
              },
              onLongPress: (categoryId) {},
            ),
          ),

          Padding(
            padding: EdgeInsets.all(8.0),
            child: PrimaryButton(
              onPressed: () {
                context.pop();
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(
                          context,
                        ).viewInsets.bottom,
                      ),
                      child: AddCategoryBottomSheet(
                        campingModel: campingModel,
                      ),
                    );
                  },
                );
              },
              text: '위시리스트 만들기',
              padding: 16,
            ),
          ),
        ],
      ),
    );
  }
}
