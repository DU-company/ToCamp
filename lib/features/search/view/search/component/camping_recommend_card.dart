import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/supabase/model/camping_recommendation_model.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class CampingRecommendCard extends ConsumerWidget {
  final CampingRecommendationModel model;
  final int index;
  const CampingRecommendCard({
    super.key,
    required this.model,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTopRank = index < 3;
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        '${index + 1}. ${model.region}',
        style: context.layout(
          theme.typo.headline4.copyWith(
            color: isTopRank ? theme.color.primary : null,
          ),
          mobile: theme.typo.headline6.copyWith(
            color: isTopRank ? theme.color.primary : null,
          ),
        ),
      ),
    );
  }
}
