import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/http.dart';
import 'package:to_camp/common/dio/dio.dart';
import 'package:to_camp/common/model/pagination_model.dart';
import 'package:to_camp/common/model/pagination_params.dart';
import 'package:to_camp/features/camping_detail/model/camping_detail_model.dart';
import 'package:to_camp/features/camping_detail/model/camping_image_item.dart';
part 'camping_detail_repository.g.dart';

final campingDetailRepositoryProvider = Provider((ref) {
  final dio = ref.watch(dioProvider);
  return CampingDetailRepository(
    dio,
    baseUrl: 'http://apis.data.go.kr/B551011/GoCamping',
  );
});

@RestApi()
abstract class CampingDetailRepository {
  factory CampingDetailRepository(Dio dio, {String? baseUrl}) =
      _CampingDetailRepository;

  @GET('/imageList')
  Future<PaginationSuccess<CampingImageItem>> getImages(
    @Queries() PaginationParams params,
  );
}
