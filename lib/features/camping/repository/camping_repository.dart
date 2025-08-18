import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:to_camp/common/model/pagination_response.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

part 'camping_repository.g.dart';

@RestApi()
abstract class CampingRepository {
  factory CampingRepository(Dio dio, {String? baseUrl}) =
      _CampingRepository;

  @GET('/basedList')
  Future<PaginationResponse<CampingModel>> paginate();
}
