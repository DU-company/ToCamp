import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/supabase/provider/recommend_provider.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/serach/service/search_camping_service.dart';
import 'package:to_camp/features/serach/view/search/component/camping_recommend_card.dart';
import 'package:to_camp/features/serach/view/search/component/search_app_bar.dart';

class CampingRecommendView extends ConsumerWidget {
  const CampingRecommendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recommendData = ref.watch(recommendProvider);
    final controller = ref.watch(searchTextEditingController);
    final theme = ref.watch(themeServiceProvider);
    final isLoading = recommendData.isEmpty;
    final hasError = recommendData.length == 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '투캠 추천 HOT 캠핑지!',
          style: theme.typo.headline3.copyWith(
            color: theme.color.primary,
          ),
        ),
        const SizedBox(height: 8),

        if (isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: LoadingWidget(),
          ),

        if (hasError)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Text(
              textAlign: TextAlign.center,
              '일시적으로 추천 캠핑장 정보를 받아올 수 없습니다.',
              style: theme.typo.subtitle1.copyWith(
                color: theme.color.primary,
              ),
            ),
          ),

        if (!isLoading && !hasError)
          ...List.generate(recommendData.length, (index) {
            final isTopRank = index < 3;
            final recommendModel = recommendData[index];
            return InkWell(
              onTap: () => ref
                  .read(searchCampingServiceProvider)
                  .onKeywordTap(
                    context,
                    ref,
                    controller,
                    recommendModel.region,
                  ),
              child: CampingRecommendCard.fromModel(
                model: recommendModel,
                isTopRank: isTopRank,
              ),
            );
          }),
      ],
    );
  }
}
