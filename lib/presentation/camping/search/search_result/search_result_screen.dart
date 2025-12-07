import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/presentation/common/widgets/custom_divider.dart';
import 'package:to_camp/presentation/common/widgets/loading_widget.dart';
import 'package:to_camp/presentation/common/widgets/base_custom_scroll_view.dart';
import 'package:to_camp/presentation/common/layout/default_layout.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/search/search/view/widgets/search_app_bar.dart';
import 'package:to_camp/presentation/camping/search/search_result/widgets/search_result_error_view.dart';
import 'package:to_camp/presentation/camping/search/search_result/widgets/search_result_success_view.dart';
import 'package:to_camp/presentation/camping/search/search_result/search_result_view_model.dart';
import 'package:to_camp/presentation/home/home_screen.dart';

class SearchResultScreen extends ConsumerWidget {
  static String get routeName => 'search-result';

  final String keyword;
  const SearchResultScreen({super.key, required this.keyword});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(
      searchResultViewModelProvider(keyword).notifier,
    );
    final searchState = ref.watch(
      searchResultViewModelProvider(keyword),
    );

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) viewModel.onClear();
      },
      child: DefaultLayout(
        child: BaseCustomScrollView(
          slivers: [
            /// AppBar
            const SearchAppBar(),

            /// Search Result
            SliverToBoxAdapter(child: body(searchState)),

            /// Mini Card
            const SliverToBoxAdapter(child: CustomDivider()),
            const SliverToBoxAdapter(child: BasedMiniList()),
          ],
          hasBox: false,
        ),
      ),
    );
  }

  Widget body(AsyncValue<List<CampingModel>> state) {
    if (state.isLoading) {
      return const SizedBox(height: 100, child: LoadingWidget());
    }
    if (state.hasError) {
      return SearchResultErrorView(
        keyword: keyword,
        message: state.error.toString(),
      );
    }

    /// 필터링 성공
    return SearchResultSuccessView(
      items: state.value!,
      keyword: keyword,
    );
  }
}
