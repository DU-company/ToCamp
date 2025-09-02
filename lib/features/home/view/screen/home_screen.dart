import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/common/const/data.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/supabase/provider/banner_ad_provider.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/common/theme/res/layout.dart';
import 'package:to_camp/common/theme/service/theme_service.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/provider/camping_provider.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/camping_recent/provider/camping_recent_provider.dart';
import 'package:to_camp/features/home/view/component/banner_ad_card.dart';
import 'package:to_camp/features/home/view/component/mini_card_list_view.dart';
import 'package:to_camp/features/location/model/location_model.dart';
import 'package:to_camp/features/location/provider/location_camping_provider.dart';
import 'package:to_camp/features/location/provider/location_provider.dart';
import 'package:to_camp/features/search/provider/search_camping_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onLocationPressed;
  const HomeScreen({super.key, required this.onLocationPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            physics: ClampingScrollPhysics(),
            slivers: [
              SliverAppBar(
                expandedHeight: context.layout(
                  350,
                  tablet: 400,
                  desktop: 500,
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    CAMPING_BANNER,
                    alignment: AlignmentGeometry.bottomLeft,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    /// 배너광고
                    _Category(category: '카라반', label: '이색 캠핑, 카라반!'),
                    const CustomDivider(),
                    _Category(category: '글램핑', label: '낭만적인 글램핑!'),
                    const CustomDivider(),
                    _Category(category: '자연휴양림', label: '산 내음을 한 껏!'),
                    const CustomDivider(),
                    _Camping(),
                    const CustomDivider(),

                    _Location(onLocationPressed: onLocationPressed),
                    const CustomDivider(),

                    _Recent(),
                    const CustomDivider(),

                    _BannerAd(),
                    AppInfo(),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

class _Category extends ConsumerWidget {
  final String category;
  final String label;
  const _Category({
    super.key,
    required this.category,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(searchCampingProvider(category));
    return MiniCardListView(
      label1: label,
      label2: '더 보기',
      provider: null,
      familyProvider: searchCampingProvider,
      family: category,
      onTap: () {
        if (data is PaginationSuccess<CampingModel>) {
          context.pushNamed(
            CampingScreen.routeName,
            extra: data.items,
            pathParameters: {'title': category},
          );
        }
      },
      onRefresh: () {
        ref.read(searchCampingProvider(category).notifier).paginate();
      },
      emptyString: '',
    );
  }
}

class _Camping extends ConsumerWidget {
  const _Camping({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(campingProvider);
    return MiniCardListView(
      label1: '이런 캠핑장은 어때요?',
      label2: '더 보기',
      provider: campingProvider,
      familyProvider: null,
      family: null,
      onTap: () {
        if (data is PaginationSuccess<CampingModel>) {
          context.pushNamed(
            CampingScreen.routeName,
            extra: data.items,
            pathParameters: {'title': '이런 캠핑장은 어때요?'},
          );
        }
      },
      onRefresh: () {
        ref.read(campingProvider.notifier).paginate();
      },
      emptyString: '',
    );
  }
}

class _Location extends ConsumerWidget {
  final VoidCallback onLocationPressed;
  const _Location({super.key, required this.onLocationPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// 위치 정보 먼저 가져오기
    final locationState = ref.watch(locationProvider);
    if (locationState is LocationLoading) {
      return LoadingWidget();
    }
    if (locationState is LocationError) {
      return ErrorMessageWidget(
        message: locationState.message,
        onTap: () {
          ref.read(locationProvider.notifier).getCurrentLocation();
        },
      );
    }

    /// 위치 정보가 존재할때만 paginate 가능
    locationState as LocationSuccess;
    return MiniCardListView(
      label1: '내 근처 캠핑장',
      label2: '지도로 보기',
      provider: locationCampingProvider,
      familyProvider: null,
      family: null,
      onTap: onLocationPressed,
      onRefresh: () {
        ref.read(locationCampingProvider.notifier).paginate();
      },
      emptyString: '근처 캠핑장이 없어요!',
    );
  }
}

class _Recent extends ConsumerWidget {
  const _Recent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(campingRecentProvider);

    return MiniCardListView(
      label1: '최근 본 캠핑장',
      label2: '더 보기',
      provider: campingRecentProvider,
      familyProvider: null,
      family: null,
      onTap: () {
        if (data is PaginationSuccess<CampingModel>) {
          context.pushNamed(
            CampingScreen.routeName,
            extra: data.items,
            pathParameters: {'title': '최근 본 캠핑장'},
          );
        }
      },
      onRefresh: () {
        ref.read(campingRecentProvider.notifier).getAll();
      },
      emptyString: '최근 본 캠핑장이 없어요!',
    );
  }
}

class _BannerAd extends ConsumerStatefulWidget {
  const _BannerAd({super.key});

  @override
  ConsumerState<_BannerAd> createState() => _BannerAdState();
}

class _BannerAdState extends ConsumerState<_BannerAd> {
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
      return SizedBox();
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
    final theme = ref.watch(themeServiceProvider);

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
