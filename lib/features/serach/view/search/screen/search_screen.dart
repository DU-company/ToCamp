import 'package:flutter/material.dart';
import 'package:to_camp/features/serach/view/search/component/search_app_bar.dart';
import 'package:to_camp/features/serach/view/search/component/search_body.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      keyboardDismissBehavior:
          ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        /// AppBar (input_field)
        SearchAppBar(),

        /// Body(recent_serch_list)
        SearchBody(),

        /// Footer(recomend)
      ],
    );
  }
}
