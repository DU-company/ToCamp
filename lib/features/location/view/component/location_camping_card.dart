import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';
import 'package:to_camp/features/like/view/component/like_button.dart';

class LocationCampingCard extends ConsumerWidget {
  final CampingModel model;
  const LocationCampingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Container(
      decoration: BoxDecoration(
        color: theme.color.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: theme.deco.shadow,
      ),
      child: CampingCard.fromModel(
        model: model,
        likeButton: LikeButton(
          campingModel: model,
          size: 24,
          position: 0,
        ),
        isHorizontal: true,
      ),
    );
  }
}
