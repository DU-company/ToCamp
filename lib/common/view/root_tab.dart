import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/common/utils/toast_utils.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/location/view/screen/map_screen.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const RootTab({super.key});

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int currentIndex = 0;
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
        bottomNavigationBar: _BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentIndex = index;
              tabController.animateTo(index);
            });
          },
          index: currentIndex,
        ),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            CampingScreen(),
            Center(
              child: Text('검색'),
            ),
            MapScreen(),
            Center(
              child: Text('찜'),
            ),
            Center(
              child: Text('설정'),
            )
            // const SearchScreen(),
            // MapScreen(
            //   provider: locationStateNotifierProvider,
            //   isLocationPage: true,
            // ),
            // const LikeScreen(),
            // const ProfileScreen(),
          ],
        ),
      ),
    );
  }

  likeOnPressed() {
    setState(() {
      currentIndex = 3;
      tabController.animateTo(currentIndex);
    });
  }

  locationOnPressed() {
    setState(() {
      currentIndex = 2;
      tabController.animateTo(currentIndex);
    });
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
    return BottomNavigationBar(
      // elevation: 10,
      onTap: onTap,
      currentIndex: index,
      selectedFontSize: 14.0,
      unselectedFontSize: 14.0,
      items: [
        BottomNavigationBarItem(
          icon: index == 0
              ? Icon(
                  Icons.home,
                  color: theme.color.primary,
                )
              : const Icon(Icons.home_outlined),
          label: '홈',
        ),
        const BottomNavigationBarItem(
          icon: Icon(
            Icons.search_rounded,
          ),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: index == 2
              ? Icon(
                  Icons.location_on,
                  color: theme.color.primary,
                )
              : const Icon(Icons.location_on_outlined),
          label: '내 근처',
        ),
        BottomNavigationBarItem(
          icon: index == 3
              ? Icon(
                  Icons.favorite,
                  color: theme.color.primary,
                )
              : const Icon(Icons.favorite_border),
          label: '찜',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: '더보기',
        ),
      ],
    );
  }
}
