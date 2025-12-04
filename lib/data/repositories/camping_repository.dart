import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/core/exception/camping_exception.dart';
import 'package:to_camp/core/exception/location_exception.dart';
import 'package:to_camp/core/exception/search_exception.dart';
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

  Future<PaginationSuccessV2<CampingModel>> getBasedList(
    PaginationParams params,
  ) async {
    try {
      final resp = await campingDataSource.fetchBasedList(params);

      final items = resp.items;
      final hasMore = items.length >= params.take;

      return PaginationSuccessV2(items: items, hasMore: hasMore);
    } catch (e) {
      throw PaginationException();
    }
  }

  Future<PaginationSuccessV2<CampingModel>> getSearchList(
    PaginationParams params,
  ) async {
    try {
      final resp = await campingDataSource.fetchSearchList(params);

      final items = resp.items;
      final hasMore = items.length >= params.take;

      return PaginationSuccessV2(items: items, hasMore: hasMore);
    } catch (e) {
      throw SearchCampingException(params.keyword!);
    }
  }

  Future<PaginationSuccessV2<CampingModel>> getLocationBasedList(
    PaginationParams params,
  ) async {
    try {
      final resp = await campingDataSource.fetchLocationBasedList(
        params,
      );

      final items = resp.items;
      final hasMore = items.length >= params.take;

      return PaginationSuccessV2(items: items, hasMore: hasMore);
    } catch (e) {
      print(e);

      throw LocationBasedException();
    }
  }
}
