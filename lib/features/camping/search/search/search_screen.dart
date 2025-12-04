import 'package:flutter/material.dart';
import 'package:to_camp/features/common/widgets/custom_divider.dart';
import 'package:to_camp/features/common/widgets/base_custom_scroll_view.dart';
import 'package:to_camp/features/home/home_screen.dart';
import 'package:to_camp/features/camping/search/search/view/recommend_view.dart';
import 'package:to_camp/features/camping/search/search/view/recent_keyword_view.dart';
import 'package:to_camp/features/camping/search/search/view/widgets/search_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseCustomScrollView(
      slivers: [
        /// AppBar (Input_field)
        SearchAppBar(),

        /// Recent Keyword
        RecentKeywordView(),

        /// Recent Camping List
        SliverToBoxAdapter(child: RecentMiniList()),

        /// Recommend Region
        SliverToBoxAdapter(child: CustomDivider()),
        CampingRecommendView(),

        /// Camping List
        SliverToBoxAdapter(child: CustomDivider()),
        SliverToBoxAdapter(child: BasedMiniList()),
      ],
    );
  }
}
