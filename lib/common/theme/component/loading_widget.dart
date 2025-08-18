import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class LoadingWidget extends ConsumerWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Center(
      child: SpinKitThreeInOut(
        color: theme.color.primary,
        size: 32,
        // itemBuilder: (context, index) {
        //
        // },
      ),
    );
  }
}
