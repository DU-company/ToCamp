import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/component/camping_card.dart';

class LocationCampingCard extends ConsumerWidget {
  final CampingModel model;
  const LocationCampingCard({super.key, required this.model});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.bounceIn,
      decoration: BoxDecoration(
        color: theme.color.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: theme.deco.shadow,
      ),
      child: CampingCard.fromModel(model: model, isHorizontal: true),
    );
  }
}
