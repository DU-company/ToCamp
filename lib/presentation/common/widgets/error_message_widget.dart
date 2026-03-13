import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/presentation/common/widgets/custom_icon_button.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/camping/location/view_model/location_view_model.dart';
import 'package:to_camp/presentation/common/widgets/primary_button.dart';

class ErrorMessageWidget extends ConsumerWidget {
  final String message;
  final VoidCallback? onTap;
  const ErrorMessageWidget({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            message,
            style: theme.typo.subtitle1,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (onTap != null)
            PrimaryButton(
              onPressed: () {},
              icon: PhosphorIcons.arrowClockwise(),
              text: '새로고침',
              backgroundColor: theme.color.surface,
              borderColor: theme.color.onHintContainer,
            ),
        ],
      ),
    );
  }
}
