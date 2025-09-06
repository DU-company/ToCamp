import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class AppInfo extends ConsumerWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return Align(
      alignment: AlignmentGeometry.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              theme.brightness == Brightness.light
                  ? LOGO_BLACK
                  : LOGO_WHITE,
              height: 42,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Text(
              '상호명 : 디유(DU) | 대표 : 백승훈 \n'
              '문의 : du0788754@gmail.com',
              style: theme.typo.body1,
            ),
            const SizedBox(height: 8.0),
            Text(
              '투캠은 통신판매 중개자로서 통신판매의 당사자가 아니며,\n'
              '상품의 예약,이용 및 환불 등과 관련된 의무와 책임은 각 판매자에게 있습니다.',
              style: theme.typo.body1,
            ),
            SizedBox(height: Platform.isAndroid ? 30 : 60),
          ],
        ),
      ),
    );
  }
}
