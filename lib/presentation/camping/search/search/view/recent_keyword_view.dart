import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/common/widgets/custom_divider.dart';
import 'package:to_camp/presentation/common/widgets/error_message_widget.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/camping/search/search/view_model/recent_keyword_view_model.dart';
import 'package:to_camp/presentation/camping/search/search_result/search_result_view_model.dart';
import 'package:to_camp/presentation/camping/search/search/view/widgets/recent_keyword_card.dart';

class RecentKeywordView extends ConsumerWidget {
  const RecentKeywordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final keywordState = ref.watch(recentKeywordViewModelProvider);
    final theme = ref.watch(themeServiceProvider);
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Title
            Text('최근 검색 기록', style: theme.typo.headline6),

            /// Empty
            if (keywordState.isEmpty)
              const ErrorMessageWidget(
                message: '최근 검색 기록이 없어요!',
                onTap: null,
              ),

            /// Card List
            ...List.generate(keywordState.length, (index) {
              final model = keywordState[index];
              return InkWell(
                onTap: () => ref
                    .read(
                      searchResultViewModelProvider(model.keyword).notifier,
                    )
                    .onKeywordTap(context),
                child: RecentKeywordCard(model: model),
              );
            }),
            const CustomDivider(),
          ],
        ),
      ),
    );
  }
}
