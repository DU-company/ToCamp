import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/theme/component/custom_divider.dart';
import 'package:to_camp/common/theme/component/error_message_widget.dart';
import 'package:to_camp/common/theme/component/loading_widget.dart';
import 'package:to_camp/common/view/custom_scroll_widget.dart';
import 'package:to_camp/common/view/default_layout.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/provider/camping_provider.dart';
import 'package:to_camp/features/home/view/screen/home_screen.dart';
import 'package:to_camp/features/search/view/search/component/search_app_bar.dart';
import 'package:to_camp/features/search/view/search_result/component/search_result_success_view.dart';

class SearchResultScreen extends ConsumerWidget {
  static String get routeName => 'searchResult';

  final String keyword;
  const SearchResultScreen({super.key, required this.keyword});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    final data = ref.watch(campingProvider);
    final controller = ref.watch(searchTextEditingController);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          ref.read(keywordProvider.notifier).state = '';
          controller.clear();
        }
      },
      child: DefaultLayout(
        child: CustomScrollWidget(
          slivers: [
            const SearchAppBar(),
            body(height, data),
            const SliverToBoxAdapter(child: CustomDivider()),
            const SliverToBoxAdapter(child: CampingMiniList()),
          ],
          hasBox: false,
        ),
      ),
    );
  }

  Widget body(double height, PaginationState data) {
    if (data is PaginationLoading) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: height / 2,
          child: const LoadingWidget(),
        ),
      );
    }
    if (data is PaginationError) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: height / 2,
          child: ErrorMessageWidget(
            message: data.message,
            onTap: () {},
          ),
        ),
      );
    }

    data as PaginationSuccess<CampingModel>;

    return SearchResultSuccessView(data: data, keyword: keyword);
  }
}
