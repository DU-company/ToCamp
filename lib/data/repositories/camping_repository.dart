import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/exception/camping_exception.dart';
import 'package:to_camp/core/exception/location_exception.dart';
import 'package:to_camp/core/exception/search_exception.dart';
import 'package:to_camp/data/models/camping_detail_model.dart';
import 'package:to_camp/data/models/camping_model.dart';
import 'package:to_camp/core/models/pagination_state.dart';
import 'package:to_camp/core/models/pagination_params.dart';
import 'package:to_camp/data/data_sources/remote/camping_data_source.dart';

final campingRepositoryProvider = Provider((ref) {
  final campingDataSource = ref.read(campingDataSourceProvider);
  return CampingRepository(campingDataSource: campingDataSource);
});

class CampingRepository {
  final CampingDataSource campingDataSource;

  CampingRepository({required this.campingDataSource});

  Future<PaginationSuccess<CampingModel>> getBasedList(
    PaginationParams params,
  ) async {
    try {
      final resp = await campingDataSource.fetchBasedList(params);

      final items = resp.items;
      final hasMore = items.length >= params.take;

      return PaginationSuccess(items: items, hasMore: hasMore);
    } catch (e) {
      throw PaginationException();
    }
  }

  /// 상세 정보
  Future<CampingDetailModel> getCampingDetail(
    PaginationParams params,
    CampingModel campingModel,
  ) async {
    try {
      final imgUrls = await _getImageList(params);
      return CampingDetailModel(
        campingModel: campingModel,
        imgUrls: imgUrls,
      );
    } catch (e) {
      throw CampingDetailException();
    }
  }

  Future<List<String>> _getImageList(PaginationParams params) async {
    final resp = await campingDataSource.fetchImageList(params);
    final imgUrls = resp.items.map((e) => e.imageUrl).toList();
    return imgUrls;
  }

  /// 검색
  Future<PaginationSuccess<CampingModel>> getSearchList(
    PaginationParams params,
  ) async {
    try {
      final resp = await campingDataSource.fetchSearchList(params);

      final items = resp.items;
      final hasMore = items.length >= params.take;

      return PaginationSuccess(items: items, hasMore: hasMore);
    } catch (e) {
      throw SearchCampingException(params.keyword!);
    }
  }

  /// 위치 기반
  Future<PaginationSuccess<CampingModel>> getLocationBasedList(
    PaginationParams params,
  ) async {
    try {
      final resp = await campingDataSource.fetchLocationBasedList(
        params,
      );

      final items = resp.items;
      final hasMore = items.length >= params.take;

      return PaginationSuccess(items: items, hasMore: hasMore);
    } catch (e) {
      print(e);

      throw LocationBasedException();
    }
  }
}
