import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/component/custom_icon_button.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping_detail/provider/camping_detail_provider.dart';

class CampingDetailErrorScreen extends ConsumerWidget {
  final String id;
  const CampingDetailErrorScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            '캠핑장 정보를 불러올 수 없습니다.',
            textAlign: TextAlign.center,
            style: theme.typo.headline6,
          ),
          const SizedBox(height: 16),
          CustomIconButton(
            onTap: () {
              ref
                  .read(campingDetailProvider(id).notifier)
                  .getDetail();
            },
            icon: PhosphorIcons.arrowClockwise(),
          ),
        ],
      ),
    );
  }
}
