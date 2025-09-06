import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/search/provider/recent_keyword_provider.dart';
import 'package:to_camp/features/search/service/search_camping_service.dart';
import 'package:to_camp/features/search/view/search/component/recent_keyword_card.dart';
import 'package:to_camp/features/search/view/search/component/search_app_bar.dart';

class RecentKeywordView extends ConsumerWidget {
  const RecentKeywordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentKeywords = ref.watch(recentKeywordProvider);
    final controller = ref.watch(searchTextEditingController);
    final theme = ref.watch(themeServiceProvider);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '최근 검색 기록',
              style: context.layout(
                theme.typo.headline5,
                mobile: theme.typo.headline6,
              ),
            ),
            if (recentKeywords.isEmpty)
              ErrorMessageWidget(
                message: '최근 검색 기록이 없어요!',
                onTap: null,
              ),

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
            CustomDivider(),
          ],
        ),
      ),
    );
  }
}
