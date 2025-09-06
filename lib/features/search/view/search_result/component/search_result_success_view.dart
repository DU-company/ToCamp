import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';
import 'package:to_camp/features/search/utils/search_utils.dart';

class SearchResultSuccessView extends ConsumerWidget {
  final PaginationSuccess<CampingModel> data;
  final String keyword;
  const SearchResultSuccessView({
    super.key,
    required this.data,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final filteredItem = SearchUtils.filterByKeyword(
      keyword,
      data.items,
    );

    if (filteredItem.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 32,
          ),
          child: Text(
            textAlign: TextAlign.center,
            '"$keyword"에 대한 검색 결과가 존재하지 않습니다.',
            style: theme.typo.subtitle1,
          ),
        ),
      );
    }

    return SliverList.separated(
      itemCount: filteredItem.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              '${filteredItem.length}개의 검색결과',
              textAlign: TextAlign.center,
              style: theme.typo.subtitle2,
            ),
          );
        }
        final model = filteredItem[index - 1];
        return GestureDetector(
          onTap: () {
            ref
                .read(campingServiceProvider)
                .onCampingCardTap(context, model);
          },
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
