import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/core/service/toast_service.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/presentation/camping/base/based_list_view_model.dart';
import 'package:to_camp/presentation/camping/search/search/view/widgets/search_app_bar.dart';
import 'package:to_camp/presentation/camping/search/search/view_model/recent_keyword_view_model.dart';
import 'package:to_camp/presentation/camping/search/search_result/search_result_screen.dart';
import 'package:to_camp/presentation/camping/search/utils/search_utils.dart';
import 'package:to_camp/core/models/pagination_state.dart';

/// BasedList의 상태값에 따라 내부적 필터링 (실제 검색창에 사용)
final searchResultViewModelProvider = NotifierProvider.family(
  (String keyword) => SearchResultViewModel(keyword),
);

class SearchResultViewModel
    extends Notifier<AsyncValue<List<CampingModel>>> {
  final String keyword;
  SearchResultViewModel(this.keyword);

  TextEditingController get controller =>
      ref.read(keywordTextEditingController);
  StateController get currentKeyword =>
      ref.read(keywordProvider.notifier);

  @override
  AsyncValue<List<CampingModel>> build() {
    final data = ref.watch(basedListViewModelProvider);
    return filterList(data);
  }

  /// based의 상태를 가져와서 필터링 후 상태에 반영
  AsyncValue<List<CampingModel>> filterList(PaginationState data) {
    if (data is PaginationLoading) {
      return AsyncLoading();
    }
    if (data is PaginationError) {
      return AsyncError(data.message, StackTrace.empty);
    }
    data is PaginationSuccess;
    final pData = data as PaginationSuccess<CampingModel>;
    final filteredList = SearchUtils.filterByKeyword(
      keyword,
      pData.items,
    );

    return AsyncData(filteredList);
  }

  /// 검색했을떄
  void onSearch(BuildContext context) {
    try {
      _validate();
      context.pushNamed(
        SearchResultScreen.routeName,
        pathParameters: {'keyword': keyword},
      );
      ref
          .read(recentKeywordViewModelProvider.notifier)
          .addKeyword(keyword);
    } catch (e) {
      ToastService.show(text: e.toString(), isError: true);
    }
  }

  /// 키워드 카드 눌렀을때 = Recommend 눌렀을 때
  void onKeywordTap(BuildContext context) {
    onSearch(context);
    controller.text = keyword;
    currentKeyword.state = keyword;
    //     ref.read(keywordTextEditingController).text = keyword;
    // ref.read(keywordProvider.notifier).state = keyword;
  }

  void onClear() {
    controller.clear();
    currentKeyword.state = '';
    // ref.read(keywordProvider.notifier).state = '';
    // ref.read(keywordTextEditingController).clear();
  }

  void _validate() {
    if (keyword.trim().isEmpty) {
      throw '올바른 검색어를 입력해 주세요.';
    }
    if (keyword.trim().length < 2) {
      throw '최소 두 글자 이상의 검색어를 입력해 주세요.';
    }
    if (keyword.trim().length > 20) {
      throw '20자 이하의 검색어를 입력해 주세요.';
    }
  }
}
