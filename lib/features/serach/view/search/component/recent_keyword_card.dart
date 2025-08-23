import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/serach/model/recent_keyword_model.dart';
import 'package:to_camp/features/serach/provider/recent_keyword_provider.dart';

class RecentKeywordCard extends ConsumerWidget {
  final String keyword;
  const RecentKeywordCard({super.key, required this.keyword});

  factory RecentKeywordCard.fromModel({
    required RecentKeywordModel model,
  }) {
    return RecentKeywordCard(keyword: model.keyword);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(
            PhosphorIcons.clockClockwise(),
            color: theme.color.subtext,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              keyword,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.typo.subtitle1.copyWith(
                color: theme.color.subtext,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              ref
                  .read(recentKeywordProvider.notifier)
                  .deleteKeyword(keyword);
            },
            child: Icon(
              PhosphorIcons.x(),
              color: theme.color.subtext,
            ),
          ),
        ],
      ),
    );
  }
}
