import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:to_camp/common/theme/component/primary_button.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class DetailFooter extends ConsumerWidget {
  const DetailFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return BaseBottomSheet(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: SizedBox(
              height: 64,
              child: PrimaryButton(
                backgroundColor: theme.color.surface,
                foregroundColor: theme.color.subtext,
                onPressed: () {},
                text: '전화 걸기',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 64,
              child: PrimaryButton(
                onPressed: () {},
                text: '예약 사이트로 이동',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
