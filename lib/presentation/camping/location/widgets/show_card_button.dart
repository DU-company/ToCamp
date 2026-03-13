import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_camping_view_model.dart';

class ShowCardButton extends ConsumerWidget {
  final List<CampingModel> models;
  final bool showCard;
  final CampingModel targetModel;
  const ShowCardButton({
    super.key,
    required this.models,
    required this.showCard,
    required this.targetModel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final safeAreaBottom = MediaQuery.of(context).padding.bottom;
    return Padding(
      padding: EdgeInsets.only(
        bottom: showCard ? 0 : safeAreaBottom + 88,
        right: 12,
        left: 12,
      ),
      child: PrimaryButton(
        padding: 8,
        radius: 12,
        text: showCard ? '목록' : null,
        icon: showCard
            ? PhosphorIcons.list()
            : PhosphorIconsBold.caretDoubleUp,
        onPressed: () => ref
            .read(locationCampingViewModelProvider.notifier)
            .onTapShowCard(context, models, targetModel),
        backgroundColor: theme.color.surface,
        foregroundColor: theme.color.primary,
      ),
    );
  }
}
