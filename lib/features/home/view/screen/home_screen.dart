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
import 'package:to_camp/common/view/base_custom_scroll_view.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/provider/camping_provider.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/camping_recent/provider/camping_recent_provider.dart';
import 'package:to_camp/features/home/view/component/app_info.dart';
import 'package:to_camp/features/home/view/component/baner/banner_ad_card.dart';
import 'package:to_camp/features/home/view/component/baner/banner_ad_list_view.dart';
import 'package:to_camp/features/home/view/component/home_app_bar.dart';
import 'package:to_camp/features/home/view/component/mini_card/mini_card_list_view.dart';
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
    return BaseCustomScrollView(
      slivers: [
        HomeAppBar(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              _CategoryMiniList(
                category: '카라반',
                label: '이색 캠핑, 카라반!',
              ),
              const CustomDivider(),
              _CategoryMiniList(category: '글램핑', label: '낭만적인 글램핑!'),
              const CustomDivider(),
              _CategoryMiniList(
                category: '자연휴양림',
                label: '산 내음을 한 껏!',
              ),
              const CustomDivider(),
              CampingMiniList(),
              const CustomDivider(),

              _LocationMiniList(onLocationPressed: onLocationPressed),
              const CustomDivider(),

              RecentMiniList(),
              const CustomDivider(),

              /// 배너광고
              BannerAdListView(),
              AppInfo(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryMiniList extends ConsumerWidget {
  final String category;
  final String label;
  const _CategoryMiniList({
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

class CampingMiniList extends ConsumerWidget {
  const CampingMiniList({super.key});

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

class _LocationMiniList extends ConsumerWidget {
  final VoidCallback onLocationPressed;
  const _LocationMiniList({
    super.key,
    required this.onLocationPressed,
  });

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

class RecentMiniList extends ConsumerWidget {
  const RecentMiniList({super.key});

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
