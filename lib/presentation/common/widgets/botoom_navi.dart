import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';

class BottomNavi extends ConsumerWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const BottomNavi({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 12),
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.color.surface,
          boxShadow: theme.deco.shadow,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _BottomNaviItem(
              selectedIcon: PhosphorIconsBold.houseSimple,
              unselectedIcon: PhosphorIcons.houseSimple(),
              label: '홈',
              onTap: () => onTap(0),
              isSelected: currentIndex == 0,
            ),

            _BottomNaviItem(
              selectedIcon: PhosphorIconsBold.listMagnifyingGlass,
              unselectedIcon: PhosphorIcons.listMagnifyingGlass(),
              label: '검색',
              onTap: () => onTap(1),
              isSelected: currentIndex == 1,
            ),

            _BottomNaviItem(
              selectedIcon: PhosphorIconsBold.mapPinLine,
              unselectedIcon: PhosphorIcons.mapPinLine(),
              label: '내 근처',
              onTap: () => onTap(2),
              isSelected: currentIndex == 2,
            ),

            _BottomNaviItem(
              selectedIcon: PhosphorIconsBold.heart,
              unselectedIcon: PhosphorIcons.heart(),
              label: '위시리스트',
              onTap: () => onTap(3),
              isSelected: currentIndex == 3,
            ),
            _BottomNaviItem(
              selectedIcon: PhosphorIconsBold.dotsThreeOutline,
              unselectedIcon: PhosphorIcons.dotsThreeOutline(),
              label: '더보기',
              onTap: () => onTap(4),
              isSelected: currentIndex == 4,
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNaviItem extends ConsumerWidget {
  final IconData unselectedIcon;
  final IconData selectedIcon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const _BottomNaviItem({
    super.key,
    required this.unselectedIcon,
    required this.selectedIcon,
    required this.label,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    final color = isSelected
        ? theme.color.primary
        : theme.color.subtext;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Expanded(
                child: Icon(
                  isSelected ? selectedIcon : unselectedIcon,
                  color: color,
                ),
              ),
              const SizedBox(height: 4),
              Expanded(
                child: Center(
                  child: Text(
                    label,
                    style: theme.typo.body3.copyWith(
                      color: color,
                      fontWeight: isSelected
                          ? theme.typo.semiBold
                          : null,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
