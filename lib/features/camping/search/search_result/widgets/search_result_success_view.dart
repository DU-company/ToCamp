import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/theme/component/custom_divider.dart';
import 'package:to_camp/core/theme/component/error_message_widget.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/features/camping/based_list_view_model.dart';
import 'package:to_camp/features/camping/search/utils/search_utils.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';
import 'package:to_camp/core/models/pagination_state.dart';

class SearchResultSuccessView extends ConsumerWidget {
  final List<CampingModel> items;
  final String keyword;
  const SearchResultSuccessView({
    super.key,
    required this.items,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    if (items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ErrorMessageWidget(
          message: '"$keyword"에 대한 검색 결과가 존재하지 않습니다.',
          onTap: null,
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: NeverScrollableScrollPhysics(), // 스크롤 제거
      shrinkWrap: true,
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '${items.length}개의 검색결과',
              textAlign: TextAlign.center,
              style: theme.typo.subtitle2,
            ),
          );
        }
        final model = items[index - 1];
        return GestureDetector(
          onTap: () => ref
              .read(basedListViewModelProvider.notifier)
              .onCampingCardTap(context, model),

          child: CampingCard.fromModel(
            model: model,
            likeButton: LikeButton(campingModel: model),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          index == 0 ? SizedBox() : CustomDivider(),
    );
  }
}
