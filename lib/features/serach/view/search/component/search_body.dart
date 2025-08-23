import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/supabase/provider/recommend_provider.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/serach/provider/recent_keyword_provider.dart';
import 'package:to_camp/features/serach/service/recent_keyword_service.dart';
import 'package:to_camp/features/serach/service/search_camping_service.dart';
import 'package:to_camp/features/serach/view/search/component/recent_keyword_card.dart';
import 'package:to_camp/features/serach/view/search/component/search_app_bar.dart';

class SearchBody extends ConsumerWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final recommendData = ref.watch(recommendProvider);
    final recentKeywords = ref.watch(recentKeywordProvider);
    final controller = ref.watch(searchTextEditingController);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ...List.generate(recentKeywords.length, (index) {
              final model = recentKeywords[index];
              return GestureDetector(
                onTap: () => onKeywordTap(
                  context,
                  ref,
                  controller,
                  model.keyword,
                ),
                child: RecentKeywordCard.fromModel(model: model),
              );
            }),
            Divider(),
            Text(
              '투캠 추천 HOT 캠핑지!',
              style: theme.typo.headline3.copyWith(
                color: theme.color.primary,
                fontWeight: theme.typo.semiBold,
              ),
            ),
            const SizedBox(height: 8),
            if (recommendData.isNotEmpty)
              ...List.generate(recommendData.length, (index) {
                final isTopRank = index < 3;
                final recommendModel = recommendData[index];
                return GestureDetector(
                  onTap: () => onKeywordTap(
                    context,
                    ref,
                    controller,
                    recommendModel.region,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      '${recommendModel.order}. ${recommendModel.region}',
                      style: theme.typo.headline6.copyWith(
                        color: isTopRank ? theme.color.primary : null,
                        fontWeight: isTopRank
                            ? theme.typo.semiBold
                            : null,
                      ),
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  void onKeywordTap(
    BuildContext context,
    WidgetRef ref,
    TextEditingController controller,
    String keyword,
  ) {
    controller.text = keyword;
    ref.read(keywordProvider.notifier).state = keyword;
    ref.read(searchCampingServiceProvider).onSearch(context, keyword);
  }
}
