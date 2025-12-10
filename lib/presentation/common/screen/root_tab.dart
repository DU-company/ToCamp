import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/data/models/notice_model.dart';
import 'package:to_camp/presentation/camping/wishlist/wishlist_screen.dart';
import 'package:to_camp/presentation/common/notice_view_model.dart';
import 'package:to_camp/presentation/common/widgets/dialog/base_confirm_dialog.dart';
import 'package:to_camp/core/service/toast_service.dart';
import 'package:to_camp/presentation/common/layout/default_layout.dart';
import 'package:to_camp/presentation/home/home_screen.dart';
import 'package:to_camp/presentation/common/widgets/botoom_navi.dart';
import 'package:to_camp/presentation/camping/location/screen/location_screen.dart';
import 'package:to_camp/presentation/camping/search/search/search_screen.dart';
import 'package:to_camp/presentation/settings/setting_screen.dart';

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
        bottomNavigationBar: BottomNavi(
          currentIndex: tabController.index,
          onTap: (index) {
            setState(() {
              tabController.index = index;
            });
          },
        ),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabController,
          children: [
            HomeScreen(onLocationPressed: onLocationPressed),
            const SearchScreen(),
            const LocationScreen(),
            const WishlistScreen(),
            const SettingScreen(),
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
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return BaseConfirmDialog(
          title: noticeModel.title,
          content: noticeModel.content,
          confirmMessage: '네, 확인했어요',
          onConfirm: () => context.pop(),
        );
      },
    );
  }
}
