import 'package:flutter/material.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/view/custom_scroll_widget.dart';
import 'package:to_camp/features/home/view/screen/home_screen.dart';
import 'package:to_camp/features/search/view/search/component/camping_recommend_view.dart';
import 'package:to_camp/features/search/view/search/component/recent_keyword_view.dart';
import 'package:to_camp/features/search/view/search/component/search_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScrollWidget(
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
        SliverToBoxAdapter(child: CampingMiniList()),
      ],
    );
  }
}
