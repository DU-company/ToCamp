import 'package:easy_debounce/easy_throttle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/common/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/common/theme/component/input_field.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/like/provider/camping_like_provider.dart';

final categoryNameProvider = StateProvider.autoDispose((ref) => '');

class AddCategoryBottomSheet extends ConsumerWidget {
  final CampingModel campingModel;
  const AddCategoryBottomSheet({
    super.key,
    required this.campingModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final categoryName = ref.watch(categoryNameProvider);

    return BaseBottomSheet(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            '위시리스트 이름을 작성해 주세요.',
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
              ref.read(categoryNameProvider.notifier).state = text;
            },
          ),
          const SizedBox(height: 8),
          PrimaryButton(
            padding: 16,
            radius: 8,
            onPressed: categoryName.trim().isEmpty
                ? null
                : () => onSubmitted(
                    context,
                    ref,
                    categoryName,
                    campingModel,
                  ),
            text: '위시리스트 만들기',
          ),
        ],
      ),
    );
  }

  bool checkName(String name, WidgetRef ref) {
    String? msg;
    if (name.trim().length < 2) {
      msg = '2자 이상을 입력해 주세요.';
    }
    if (name.length > 21) {
      msg = '20자 이하로 작성해 주세요.';
    }
    if (msg != null) {
      ref.read(toastUtilsProvider).showToast(text: msg);
      return false;
    } else {
      return true;
    }
  }

  void onSubmitted(
    BuildContext context,
    WidgetRef ref,
    String categoryName,
    CampingModel campingModel,
  ) {
    EasyThrottle.throttle(
      'create_category',
      Duration(seconds: 1),
      () async {
        final isOk = checkName(categoryName, ref);
        if (isOk) {
          await ref
              .read(campingLikeProvider.notifier)
              .createCategory(categoryName, campingModel);
          ref
              .read(toastUtilsProvider)
              .showToast(text: '위시리스트에 추가되었습니다.', isError: false);
          context.pop();
        }
      },
    );
  }
}
