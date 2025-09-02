import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class CustomDivider extends ConsumerWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(color: theme.color.onHintContainer),
    );
  }
}
