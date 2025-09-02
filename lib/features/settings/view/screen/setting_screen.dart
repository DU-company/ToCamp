import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/component/tile.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/camping_recent/provider/camping_recent_provider.dart';
import 'package:to_camp/features/home/view/screen/home_screen.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final recent = ref.watch(campingRecentProvider);

    return Column(
      children: [
        Expanded(
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: [
              Tile(
                onTap: () {
                  ref
                      .read(themeServiceProvider.notifier)
                      .toggleTheme();
                },
                text: '테마 변경',
                trailing: theme.brightness == Brightness.light
                    ? PhosphorIconsBold.sun
                    : PhosphorIconsBold.moon,
              ),
              const CustomDivider(),
              Tile(
                onTap: () {
                  if (recent is PaginationSuccess<CampingModel>) {
                    context.pushNamed(
                      CampingScreen.routeName,
                      extra: recent.items,
                      pathParameters: {'title': '최근 본 캠핑장'},
                    );
                  }
                },
                text: '최근 본 캠핑장',
                trailing: PhosphorIcons.tent(),
              ),
              const CustomDivider(),
              Tile(
                onTap: () async {
                  final params = ShareParams(
                    text: 'du0788754@gmail.com',
                  );
                  await SharePlus.instance.share(params);
                },
                text: 'du0788754@gmail.com',
                trailing: PhosphorIcons.envelopeSimple(),
              ),

              const CustomDivider(),

              Tile(onTap: null, text: '버전 정보 v2.0.0'),
            ],
          ),
        ),
        AppInfo(),
        const SizedBox(height: 60),
      ],
    );
  }
}
