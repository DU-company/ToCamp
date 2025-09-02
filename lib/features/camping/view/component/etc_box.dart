import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/foundation/app_theme.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';

class EtcBox extends StatelessWidget {
  final AppTheme theme;
  final String pet;
  final String fire;
  final String caravan;
  final String siteBottomCl1;
  final String siteBottomCl2;
  final String siteBottomCl3;
  final String siteBottomCl4;
  final String siteBottomCl5;

  const EtcBox({
    super.key,
    required this.theme,
    required this.pet,
    required this.fire,
    required this.caravan,
    required this.siteBottomCl1,
    required this.siteBottomCl2,
    required this.siteBottomCl3,
    required this.siteBottomCl4,
    required this.siteBottomCl5,
  });

  @override
  Widget build(BuildContext context) {
    final isPetAllowed = pet.isNotEmpty && pet != '불가능';
    final isCaravanAllowed = caravan.isNotEmpty && caravan != 'N';
    final isFireAllowed = fire.isNotEmpty && fire != '불가능';
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      runSpacing: 4,
      spacing: 4,
      children: [
        if (isFireAllowed)
          _IconWithLabel(icon: PhosphorIcons.campfire(), label: '화로'),

        /// Pet
        if (isPetAllowed) renderDot(theme),
        if (isPetAllowed)
          _IconWithLabel(icon: PhosphorIcons.dog(), label: pet),

        /// Caravan
        if (isCaravanAllowed) renderDot(theme),
        if (isCaravanAllowed)
          _IconWithLabel(
            icon: PhosphorIcons.truckTrailer(),
            label: '카라반',
          ),

        if (siteBottomCl1 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl1, type: '잔디'),

        if (siteBottomCl2 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl2, type: '파쇄석'),

        if (siteBottomCl3 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl3, type: '데크'),

        if (siteBottomCl4 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl4, type: '자갈'),

        if (siteBottomCl5 != '0') renderDot(theme),
        _SiteType(siteCount: siteBottomCl5, type: '흙'),
      ],
    );
  }

  Text renderDot(AppTheme theme) => Text(
    '•',
    style: theme.typo.subtitle2.copyWith(color: theme.color.primary),
  );
}

class _IconWithLabel extends ConsumerWidget {
  final IconData icon;
  final String label;
  const _IconWithLabel({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: theme.color.primary,
              size: context.layout(28, mobile: 24),
            ),
            const SizedBox(width: 4),
            Text(
              label,

              style: context.layout(
                theme.typo.headline6.copyWith(
                  color: theme.color.primary,
                ),
                mobile: theme.typo.subtitle1.copyWith(
                  color: theme.color.primary,
                  fontWeight: theme.typo.semiBold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SiteType extends ConsumerWidget {
  final String siteCount;
  final String type;
  const _SiteType({
    super.key,
    required this.siteCount,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    if (siteCount == '0') return SizedBox();
    return Text(
      '$type $siteCount',
      style: context.layout(
        theme.typo.headline6.copyWith(
          color: theme.color.primary,
        ),
        mobile: theme.typo.subtitle1.copyWith(
          color: theme.color.primary,
          fontWeight: theme.typo.semiBold,
        ),
      ),
    );
  }
}
