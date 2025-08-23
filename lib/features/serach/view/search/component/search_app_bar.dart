import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/component/input_field.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/features/serach/provider/recent_keyword_provider.dart';
import 'package:to_camp/features/serach/service/search_camping_service.dart';
import 'package:to_camp/features/serach/view/search_result/screen/search_result_screen.dart';

final searchTextEditingController = Provider(
  (ref) => TextEditingController(),
);

final keywordProvider = StateProvider<String>((ref) => '');

class SearchAppBar extends ConsumerWidget {
  const SearchAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(searchTextEditingController);
    final keyword = ref.watch(keywordProvider);
    return SliverAppBar(
      titleSpacing: 8,
      title: InputField(
        hint: '이번 캠핑은 어디로 가시나요?',
        maxLine: 1,
        onChanged: (text) {
          ref.read(keywordProvider.notifier).state = text;
        },
        onSubmitted: (text) {
          final isOk = checkKeyword(keyword, ref);
          if (isOk) {
            ref
                .read(searchCampingServiceProvider)
                .onSearch(context, keyword);
          }
        },
        controller: controller,
        onClear: keyword.isEmpty
            ? null
            : () {
                ref.read(keywordProvider.notifier).state = '';
                controller.clear();
              },
      ),
    );
  }

  bool checkKeyword(
    String keyword,
    WidgetRef ref,
    // FocusNode focusNode,
  ) {
    String? msg;
    if (keyword.trim().isEmpty) {
      msg = '올바른 검색어를 입력해 주세요.';
    } else if (keyword.trim().length < 2) {
      msg = '최소 두 글자 이상의 검색어를 입력해 주세요.';
    } else if (keyword.trim().length > 50) {
      msg = '최대 50자 이하의 검색어를 입력해 주세요.';
    }
    if (msg != null) {
      ref.read(toastUtilsProvider).showToast(text: msg);
      return false;
    }
    return true;
  }
}

refactor: Search 리팩토링
chore: Firebase 없애고 supabase 연결
feat: 키워드 기반 Pagination 구현
feat: 검색 기록 저장 구현