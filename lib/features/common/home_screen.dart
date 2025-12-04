import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/core/theme/component/custom_divider.dart';
import 'package:to_camp/core/theme/component/error_message_widget.dart';
import 'package:to_camp/core/theme/component/loading_widget.dart';
import 'package:to_camp/core/view/base_custom_scroll_view.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/features/camping/based_list_view_model.dart';
import 'package:to_camp/features/camping/location/location_camping_view_model.dart';
import 'package:to_camp/features/camping/recent/recent_camping_view_model.dart';
import 'package:to_camp/features/camping/search/search_view_model.dart';
import 'package:to_camp/features/camping/view/screen/camping_screen.dart';
import 'package:to_camp/features/common/widgets/app_info.dart';
import 'package:to_camp/features/banner_ad/banner_ad_view.dart';
import 'package:to_camp/features/common/widgets/home_app_bar.dart';
import 'package:to_camp/features/common/widgets/mini_card/mini_card_list_view.dart';
import 'package:to_camp/features/location/view_model/location_state.dart';
import 'package:to_camp/features/location/view_model/location_view_model.dart';
import 'package:to_camp/core/models/pagination_state.dart';

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
              const _CategoryMiniList(
                category: '카라반',
                label: '이색 캠핑, 카라반!',
              ),
              const CustomDivider(),
              const _CategoryMiniList(
                category: '글램핑',
                label: '낭만적인 글램핑!',
              ),
              const CustomDivider(),
              const _CategoryMiniList(
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
              BannerAdView(),
              AppInfo(),
            ],
          ),
        ),
      ],
    );
  }
}

/// TODO : Search 이용해서 미니카드 살리고 홈 화면 복구
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
    final state = ref.watch(searchViewModelProvider(category));
    final viewModel = ref.read(
      searchViewModelProvider(category).notifier,
    );
    return MiniCardListView(
      label1: label,
      label2: '더 보기',
      state: state,
      onTap: () {
        if (state is PaginationSuccessV2) {
          context.pushNamed(
            CampingScreen.routeName,
            extra: state.items,
            pathParameters: {'title': category},
          );
        }
      },
      onRefresh: () => viewModel.paginate(),
      emptyString: '',
    );
  }
}

class CampingMiniList extends ConsumerWidget {
  const CampingMiniList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(basedListViewModelProvider);
    final viewModel = ref.read(basedListViewModelProvider.notifier);
    return MiniCardListView(
      label1: '이런 캠핑장은 어때요?',
      label2: '더 보기',
      state: state,
      onTap: () {
        if (state is PaginationSuccessV2<CampingModel>) {
          context.pushNamed(
            CampingScreen.routeName,
            extra: state.items,
            pathParameters: {'title': '이런 캠핑장은 어때요?'},
          );
        }
      },
      onRefresh: () => viewModel.paginate(),
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
    final locationState = ref.watch(locationViewModelProvider);

    /// 위치 정보 먼저 가져오기
    if (locationState is LocationLoading) {
      return LoadingWidget();
    }
    if (locationState is LocationError) {
      return ErrorMessageWidget(
        message: locationState.message,
        onTap: () => ref
            .read(locationViewModelProvider.notifier)
            .getCurrentLocation(),
      );
    }

    /// 위치 정보가 존재할때만 paginate 가능
    locationState as LocationSuccess;
    final locationCampingState = ref.watch(
      locationCampingViewModelProvider,
    );
    return MiniCardListView(
      label1: '내 근처 캠핑장',
      label2: '지도로 보기',
      state: locationCampingState,
      onTap: onLocationPressed,
      onRefresh: () => ref
          .read(locationCampingViewModelProvider.notifier)
          .paginate(),
      emptyString: '근처 캠핑장이 없어요!',
    );
  }
}

class RecentMiniList extends ConsumerWidget {
  const RecentMiniList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(
      recentCampingViewModelProvider.notifier,
    );

    /// State
    final state = ref.watch(recentCampingViewModelProvider);
    final pState = PaginationSuccessV2(items: state, hasMore: true);

    return MiniCardListView(
      label1: '최근 본 캠핑장',
      label2: '더 보기',
      state: pState,
      onTap: () => viewModel.onRecentCampingTap(context),
      onRefresh: () => viewModel.paginate(),
      emptyString: '최근 본 캠핑장이 없어요!',
    );
  }
}
