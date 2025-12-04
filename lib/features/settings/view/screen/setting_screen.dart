import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/core/const/data.dart';
import 'package:to_camp/features/common/widgets/custom_divider.dart';
import 'package:to_camp/features/common/widgets/tile.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/recent/recent_camping_view_model.dart';
import 'package:to_camp/features/common/widgets/app_info.dart';
import 'package:to_camp/core/utils/deep_link_utils.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Tile(
                text: '테마 변경',
                trailing: theme.brightness == Brightness.light
                    ? PhosphorIconsBold.sun
                    : PhosphorIconsBold.moon,
                onTap: () => ref
                    .read(themeServiceProvider.notifier)
                    .toggleTheme(),
              ),
              const CustomDivider(),
              Tile(
                text: '최근 본 캠핑장',
                trailing: PhosphorIcons.tent(),
                onTap: () => ref
                    .read(recentCampingViewModelProvider.notifier)
                    .onRecentCampingTap(context),
              ),
              const CustomDivider(),
              Tile(
                text: EMAIL_ADDRESS,
                trailing: PhosphorIcons.envelopeSimple(),
                onTap: () =>
                    DeepLinkUtils.shareEmail(context, EMAIL_ADDRESS),
              ),

              const CustomDivider(),

              const Tile(text: '버전 정보 $APP_VERSION', onTap: null),
            ],
          ),
        ),
        const AppInfo(),
        const SizedBox(height: 60),
      ],
    );
  }
}
