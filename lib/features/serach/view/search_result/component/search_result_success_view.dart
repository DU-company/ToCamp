import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/service/camping_service.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';
import 'package:to_camp/features/serach/view/search/component/search_app_bar.dart';

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
    if (data.items.isEmpty) {
      return SliverPadding(
        padding: EdgeInsetsGeometry.symmetric(
          horizontal: 16,
          vertical: 64,
        ),
        sliver: SliverToBoxAdapter(
          child: Text(
            textAlign: TextAlign.center,
            '"$keyword"에 대한 검색 결과가 존재하지 않습니다.',
            style: theme.typo.subtitle1,
          ),
        ),
      );
    }

    return SliverList.separated(
      itemCount: data.items.length,
      itemBuilder: (context, index) {
        final model = data.items[index];
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
      separatorBuilder: (context, index) => CustomDivider(),
    );
  }
}
