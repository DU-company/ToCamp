import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/banner_ad/banner_ad_view_model.dart';
import 'package:to_camp/core/theme/res/layout.dart';
import 'package:to_camp/core/theme/service/theme_service.dart';
import 'package:to_camp/presentation/banner_ad/widgets/banner_ad_card.dart';

class BannerAdView extends ConsumerStatefulWidget {
  const BannerAdView({super.key});

  @override
  ConsumerState<BannerAdView> createState() => BannerAdViewState();
}

class BannerAdViewState extends ConsumerState<BannerAdView> {
  late final PageController pageController;
  int bannerLength = 0;
  Timer? _timer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    setTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    pageController.dispose();
    super.dispose();
  }

  void setTimer() {
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
  Widget build(BuildContext context) {
    final data = ref.watch(bannerAdViewModelProvider);
    final width = MediaQuery.of(context).size.width;

    if (data.isEmpty) {
      return const SizedBox();
    }
    bannerLength = data.length;
    return SizedBox(
      width: context.layout(
        null,
        tablet: width / 1.5,
        desktop: width / 2,
      ),
      child: Column(
        children: [
          /// Image
          AspectRatio(
            aspectRatio: 3,
            child: PageView.builder(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              onPageChanged: (value) => setState(() {
                currentIndex = value;
              }),

              itemBuilder: (context, index) {
                final model = data[index];
                return BannerAdCard(model: model);
              },
            ),
          ),

          /// Index
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

  Widget renderCircle(bool isCurrentIndex) {
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
