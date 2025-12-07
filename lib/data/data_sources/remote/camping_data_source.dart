import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:to_camp/core/dio/dio.dart';
import 'package:to_camp/core/models/pagination_params.dart';
import 'package:to_camp/data/entities/camping_image_entity.dart';
import 'package:to_camp/data/models/api_response.dart';
import 'package:to_camp/data/models/camping_model.dart';

part 'camping_data_source.g.dart';

final campingDataSourceProvider = Provider<CampingDataSource>((ref) {
  final dio = ref.read(dioProvider);
  return CampingDataSource(
    dio,
    baseUrl: 'https://apis.data.go.kr/B551011/GoCamping',
  );
});

@RestApi()
abstract class CampingDataSource {
  factory CampingDataSource(Dio dio, {String? baseUrl}) =
      _CampingDataSource;

  @GET('/basedList')
  Future<ApiResponse<CampingModel>> fetchBasedList(
    @Queries() PaginationParams params,
  );

  @GET('/imageList')
  Future<ApiResponse<CampingImageEntity>> fetchImageList(
    @Queries() PaginationParams params,
  );

  @GET('/locationBasedList')
  Future<ApiResponse<CampingModel>> fetchLocationBasedList(
    @Queries() PaginationParams params,
  );
  //
  @GET('/searchList')
  Future<ApiResponse<CampingModel>> fetchSearchList(
    @Queries() PaginationParams params,
  );
}
