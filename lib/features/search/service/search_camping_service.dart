import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/common/exception/camping_exception.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/pagination/model/pagination_params.dart';
import 'package:to_camp/common/provider/current_camping_provider.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/repository/camping_repository.dart';
import 'package:to_camp/features/search/provider/recent_keyword_provider.dart';
import 'package:to_camp/features/search/view/search/component/search_app_bar.dart';
import 'package:to_camp/features/search/view/search_result/screen/search_result_screen.dart';

final searchCampingServiceProvider = Provider((ref) {
  final campingRepository = ref.watch(campingRepositoryProvider);
  return SearchCampingService(
    campingRepository: campingRepository,
    ref: ref,
  );
});

class SearchCampingService {
  final CampingRepository campingRepository;
  final Ref ref;

  SearchCampingService({
    required this.campingRepository,
    required this.ref,
  });
  Future<PaginationSuccess<CampingModel>> paginate(
    String keyword,
    final int take,
    final int pageNo,
  ) async {
    try {
      final params = PaginationParams(
        take: take,
        pageNo: pageNo,
        keyword: keyword,
      );
      final resp = await campingRepository.searchPaginate(params);

      final success = PaginationSuccess<CampingModel>(
        items: resp.items,
        totalCount: resp.totalCount,
      );

      /// 딥 링크로 받아온 캠핑장을 처리하기 위함
      if (success.items.isNotEmpty) {
        ref.read(currentCampingProvider.notifier).state =
            success.items.first;
      }

      return success;
    } catch (e, s) {
      print('$e $s');
      throw PaginationException();
    }
  }

  Future<void> onSearch(BuildContext context, String keyword) async {
    if (context.canPop()) {
      context.pushReplacementNamed(
        SearchResultScreen.routeName,
        queryParameters: {'keyword': keyword},
      );
    } else {
      context.pushNamed(
        SearchResultScreen.routeName,
        queryParameters: {'keyword': keyword},
      );
    }
    await ref
        .read(recentKeywordProvider.notifier)
        .addKeyword(keyword);
  }

  void onKeywordTap(
    BuildContext context,
    WidgetRef ref,
    TextEditingController controller,
    String keyword,
  ) {
    controller.text = keyword;
    ref.read(keywordProvider.notifier).state = keyword;
    ref.read(searchCampingServiceProvider).onSearch(context, keyword);
  }
}
