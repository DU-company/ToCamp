import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/features/camping/search/search/view_model/recommend_view_model.dart';
import 'package:to_camp/core/theme/component/loading_widget.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/search/search/view/widgets/camping_recommend_card.dart';
import 'package:to_camp/features/camping/search/search/view/widgets/search_app_bar.dart';

class CampingRecommendView extends ConsumerWidget {
  const CampingRecommendView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final recommendState = ref.watch(recommendViewModelProvider);

    /// Boolean
    final isLoading = recommendState.isEmpty;
    final hasError = recommendState.length == 1;

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '투캠 추천 HOT 캠핑지!',
              style: context.layout(
                theme.typo.headline3.copyWith(
                  color: theme.color.primary,
                ),
                mobile: theme.typo.headline4.copyWith(
                  color: theme.color.primary,
                ),
              ),
            ),
            const SizedBox(height: 8),

            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32.0),
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
              ...List.generate(recommendState.length, (index) {
                final recommendModel = recommendState[index];
                return InkWell(
                  onTap: () {},

                  child: CampingRecommendCard(
                    model: recommendModel,
                    index: index,
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
