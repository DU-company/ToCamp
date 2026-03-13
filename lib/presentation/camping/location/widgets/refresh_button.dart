import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_camping_view_model.dart';

class LocationRefreshButton extends ConsumerWidget {
  const LocationRefreshButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: PrimaryButton(
          padding: 8,
          radius: 12,
          onPressed: ref
              .read(locationCampingViewModelProvider.notifier)
              .onTapRefresh,
          text: '이 지역 재탐색',
          icon: PhosphorIconsBold.arrowClockwise,
          foregroundColor: theme.color.primary,
          backgroundColor: theme.color.surface,
        ),
      ),
    );
  }
}
