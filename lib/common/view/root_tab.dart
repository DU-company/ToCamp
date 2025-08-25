import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/like/view/screen/camping_like_screen.dart';
import 'package:to_camp/features/location/view/screen/location_screen.dart';
import 'package:to_camp/features/serach/view/search/screen/search_screen.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const RootTab({super.key});

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  Future<bool> onWillPop() async {
    return ref
        .read(toastUtilsProvider)
        .onWillPop(currentBackPressTime);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) async {
        await onWillPop();
      },
      // onWillPop: onWillPop,
      child: DefaultLayout(
        // bottomNavigationBar: _BottomNavi(
        //   currentIndex: tabController.index,
        //   onTap: (index) {
        //     setState(() {
        //       tabController.index = index;
        //     });
        //   },
        // ),
        child: Stack(
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                CampingScreen(),
                SearchScreen(),
                LocationScreen(),
                CampingLikeScreen(),
                Center(child: Text('설정')),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _BottomNavi(
                currentIndex: tabController.index,
                onTap: (index) {
                  setState(() {
                    tabController.index = index;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  locationOnPressed() {
    setState(() {
      tabController.animateTo(2);
    });
  }

  likeOnPressed() {
    setState(() {
      tabController.animateTo(3);
    });
  }
}

class _BottomNavi extends ConsumerWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const _BottomNavi({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);

    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 12),
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
              label: '찜',
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? selectedIcon : unselectedIcon,
                color: color,
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: theme.typo.body3.copyWith(
                  color: color,
                  fontWeight: isSelected ? theme.typo.semiBold : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavigationBar extends ConsumerWidget {
  final Function(int) onTap;
  final int index;

  const _BottomNavigationBar({
    super.key,
    required this.onTap,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeServiceProvider);
    return Container();
    return BottomNavigationBar(
      // elevation: 10,
      onTap: onTap,
      currentIndex: index,
      selectedFontSize: 14.0,
      unselectedFontSize: 14.0,
      selectedItemColor: theme.color.primary,
      items: [
        BottomNavigationBarItem(
          icon: index == 0
              ? Icon(PhosphorIconsBold.tipi)
              : Icon(PhosphorIcons.tipi()),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: index == 1
              ? Icon(PhosphorIconsBold.magnifyingGlass)
              : Icon(PhosphorIcons.magnifyingGlass()),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: index == 2
              ? Icon(PhosphorIconsBold.mapPinLine)
              : Icon(PhosphorIcons.mapPinLine()),
          label: '내 근처',
        ),
        BottomNavigationBarItem(
          icon: index == 3
              ? Icon(PhosphorIconsFill.heart)
              : Icon(PhosphorIcons.heart()),
          label: '찜',
        ),
        const BottomNavigationBarItem(
          icon: Icon(PhosphorIconsBold.dotsThreeOutline),
          label: '더보기',
        ),
      ],
    );
  }
}
