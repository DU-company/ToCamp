import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/supabase/model/camping_recommendation_model.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class CampingRecommendCard extends ConsumerWidget {
  final String region;
  final int order;
  final bool isTopRank;
  const CampingRecommendCard({
    super.key,
    required this.region,
    required this.order,
    required this.isTopRank,
  });

  factory CampingRecommendCard.fromModel({
    required CampingRecommendationModel model,
    required bool isTopRank,
  }) {
    return CampingRecommendCard(
      region: model.region,
      order: model.order,
      isTopRank: isTopRank,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        '$order. $region',
        style: theme.typo.headline6.copyWith(
          color: isTopRank ? theme.color.primary : null,
          fontWeight: isTopRank ? theme.typo.semiBold : null,
        ),
      ),
    );
  }
}
