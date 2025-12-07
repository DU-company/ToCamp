import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/recent_keyword_model.dart';
import 'package:to_camp/presentation/camping/search/search/view_model/recent_keyword_view_model.dart';

class RecentKeywordCard extends ConsumerWidget {
  final RecentKeywordModel model;
  const RecentKeywordCard({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final subtext = theme.color.subtext;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          /// Clock Icon
          Icon(PhosphorIcons.clockClockwise(), color: subtext),
          const SizedBox(width: 8),

          /// Keyword
          Expanded(
            child: Text(
              model.keyword,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.typo.subtitle1.copyWith(color: subtext),
            ),
          ),

          /// Delete Button
          GestureDetector(
            onTap: () => ref
                .read(recentKeywordViewModelProvider.notifier)
                .removeKeyword(model.keyword),
            child: Icon(PhosphorIcons.x(), color: subtext),
          ),
        ],
      ),
    );
  }
}
