import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/data/model/recent_keyword_model.dart';

class RecentKeywordCard extends ConsumerWidget {
  final RecentKeywordModel model;
  const RecentKeywordCard({super.key, required this.model});

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
              model.keyword,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.layout(
                theme.typo.headline6.copyWith(
                  color: theme.color.subtext,
                  fontWeight: theme.typo.regular,
                ),
                mobile: theme.typo.subtitle1.copyWith(
                  color: theme.color.subtext,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // ref
              //     .read(recentKeywordProvider.notifier)
              //     .deleteKeyword(keyword);
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
