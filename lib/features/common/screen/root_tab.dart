import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/data/models/notice_model.dart';
import 'package:to_camp/features/camping/wishlist/wishlist_category_screen.dart';
import 'package:to_camp/features/common/notice_view_model.dart';
import 'package:to_camp/features/common/widgets/dialog/base_confirm_dialog.dart';
import 'package:to_camp/core/service/toast_utils.dart';
import 'package:to_camp/features/common/layout/default_layout.dart';
import 'package:to_camp/features/home/home_screen.dart';
import 'package:to_camp/features/common/widgets/botoom_navi.dart';
import 'package:to_camp/features/location/view/location_screen.dart';
import 'package:to_camp/features/camping/search/search/search_screen.dart';
import 'package:to_camp/features/settings/view/screen/setting_screen.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const RootTab({super.key});

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

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

  @override
  Widget build(BuildContext context) {
    /// Notice Dialog
    ref.listen(noticeViewModelProvider, (p, n) {
      if (n != null) {
        showNoticeDialog(n);
      }
    });

    return WillPopScope(
      onWillPop: () => ToastService.onWillPop(ref),
      child: DefaultLayout(
        child: Stack(
          children: [
            TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: [
                HomeScreen(onLocationPressed: onLocationPressed),
                const SearchScreen(),
                const LocationScreen(),
                const WishlistCategoryScreen(),
                const SettingScreen(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: BottomNavi(
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

  void onLocationPressed() {
    setState(() {
      tabController.animateTo(2);
    });
  }

  void showNoticeDialog(NoticeModel noticeModel) {
    showDialog(
      context: context,
      builder: (context) {
        return BaseConfirmDialog(
          title: noticeModel.content,
          confirmMessage: '확인',
          cancelMessage: '닫기',
          onConfirm: () {
            context.pop();
          },
        );
      },
    );
  }
}
