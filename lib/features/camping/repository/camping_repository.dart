import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:to_camp/common/dio/dio.dart';
import 'package:to_camp/common/pagination/model/pagination_model.dart';
import 'package:to_camp/common/pagination/model/pagination_params.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
import 'package:to_camp/features/camping_detail/model/camping_image_item.dart';

part 'camping_repository.g.dart';

final campingRepositoryProvider = Provider<CampingRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CampingRepository(
    dio,
    baseUrl: 'https://apis.data.go.kr/B551011/GoCamping',
  );
});

@RestApi()
abstract class CampingRepository {
  factory CampingRepository(Dio dio, {String? baseUrl}) =
      _CampingRepository;

  @GET('/basedList')
  Future<PaginationSuccess<CampingModel>> paginate(
    @Queries() PaginationParams params,
  );

  @GET('/imageList')
  Future<PaginationSuccess<CampingImageItem>> getImages(
    @Queries() PaginationParams params,
  );

  @GET('/locationBasedList')
  Future<PaginationSuccess<CampingModel>> locationBasedPaginate(
    @Queries() PaginationParams params,
  );

  @GET('/searchList')
  Future<PaginationSuccess<CampingModel>> searchPaginate(
    @Queries() PaginationParams params,
  );
}
