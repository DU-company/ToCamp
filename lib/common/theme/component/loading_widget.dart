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
        size: 42, // 전체 위젯 크기
        // color: theme.color.primary,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1.0), // ✅ 간격 추가
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: theme.color.primary,
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }
}
