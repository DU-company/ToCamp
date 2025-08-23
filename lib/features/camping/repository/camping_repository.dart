import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:to_camp/common/dio/dio.dart';
import 'package:to_camp/common/model/pagination_params.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

part 'camping_repository.g.dart';

final campingRepositoryProvider = Provider<CampingRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return CampingRepository(
    dio,
    baseUrl: 'http://apis.data.go.kr/B551011/GoCamping',
  );
});

@RestApi()
abstract class CampingRepository {
  factory CampingRepository(Dio dio, {String? baseUrl}) =
      _CampingRepository;

  @GET('/basedList')
  Future<PaginationData<CampingModel>> paginate(
    @Queries() PaginationParams params,
  );

  @GET('/locationBasedList')
  Future<PaginationData<CampingModel>> locationBasedPaginate(
    @Queries() PaginationParams params,
  );

  @GET('/searchList')
  Future<PaginationData<CampingModel>> searchPaginate(
    @Queries() PaginationParams params,
  );
}
