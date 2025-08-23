import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/model/pagination_params.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping/repository/camping_repository.dart';
import 'package:to_camp/features/serach/provider/recent_keyword_provider.dart';
import 'package:to_camp/features/serach/service/recent_keyword_service.dart';
import 'package:to_camp/features/serach/view/search_result/screen/search_result_screen.dart';

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
      return PaginationSuccess<CampingModel>(
        items: resp.response.body.items.item,
        hasMore: true,
      );
    } catch (e, s) {
      print('$e $s');
      rethrow;
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
}
