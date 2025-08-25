import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/supabase/provider/recommend_provider.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/serach/provider/recent_keyword_provider.dart';
import 'package:to_camp/features/serach/service/recent_keyword_service.dart';
import 'package:to_camp/features/serach/service/search_camping_service.dart';
import 'package:to_camp/features/serach/view/search/component/camping_recommend_card.dart';
import 'package:to_camp/features/serach/view/search/component/camping_recommend_view.dart';
import 'package:to_camp/features/serach/view/search/component/recent_keyword_card.dart';
import 'package:to_camp/features/serach/view/search/component/search_app_bar.dart';

class SearchBody extends ConsumerWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              return InkWell(
                onTap: () => ref
                    .read(searchCampingServiceProvider)
                    .onKeywordTap(
                      context,
                      ref,
                      controller,
                      model.keyword,
                    ),
                child: RecentKeywordCard.fromModel(model: model),
              );
            }),
            Divider(),
            CampingRecommendView(),
          ],
        ),
      ),
    );
  }
}
