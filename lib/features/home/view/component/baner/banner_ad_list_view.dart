import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/supabase/provider/banner_ad_provider.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/home/view/component/baner/banner_ad_card.dart';

class BannerAdListView extends ConsumerStatefulWidget {
  const BannerAdListView({super.key});

  @override
  ConsumerState<BannerAdListView> createState() =>
      BannerAdListViewState();
}

class BannerAdListViewState extends ConsumerState<BannerAdListView> {
  late final PageController pageController;
  int bannerLength = 0;
  Timer? _timer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    _timer = Timer.periodic(const Duration(seconds: 10), (
      Timer timer,
    ) {
      // 마지막 페이지에 도달하면 첫 번째 페이지로 이동
      final isLastPage = pageController.page == bannerLength - 1;

      pageController.animateToPage(
        isLastPage ? 0 : currentIndex + 1,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 페이지를 변경하는 타이머 해제
    pageController.dispose(); // 페이지 컨트롤러 해제
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(bannerAdProvider);
    final width = MediaQuery.of(context).size.width;
    if (data.isEmpty) {
      return const SizedBox();
    } else {
      bannerLength = data.length;
      return SizedBox(
        width: context.layout(
          null,
          tablet: width / 1.3,
          desktop: width / 1.5,
        ),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3,
              child: PageView.builder(
                // scrollDirection: Axis.horizontal,
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                onPageChanged: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  final model = data[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                    ),
                    child: BannerAdCard.fromModel(model: model),
                  );
                },
              ),
            ),
            const SizedBox(height: 8.0),
            if (data.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(data.length, (index) {
                  return renderCircle(index == currentIndex);
                }),
              ),
          ],
        ),
      );
    }
  }

  renderCircle(bool isCurrentIndex) {
    final theme = ref.read(themeServiceProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isCurrentIndex
              ? theme.color.primary
              : theme.color.subtext,
        ),
      ),
    );
  }
}
