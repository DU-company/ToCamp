import 'package:flutter/material.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/features/serach/view/search/component/camping_recommend_view.dart';
import 'package:to_camp/features/serach/view/search/component/recent_keyword_view.dart';
import 'package:to_camp/features/serach/view/search/component/search_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        /// AppBar (input_field)
        SearchAppBar(),

        /// Body(recent_serch_list)
        RecentKeywordView(),

        /// Footer(recomend)
        CampingRecommendView(),

        SliverToBoxAdapter(child: SizedBox(height: 80)),
      ],
    );
  }
}
