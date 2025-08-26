import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/location/provider/location_provider.dart';

class ErrorMessageWidget extends ConsumerWidget {
  final String message;
  final VoidCallback onTap;
  const ErrorMessageWidget({
    super.key,
    required this.message,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          message,
          style: theme.typo.subtitle1,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        CustomIconButton(
          onTap: onTap,
          icon: PhosphorIcons.arrowClockwise(),
        ),
      ],
    );
  }
}
