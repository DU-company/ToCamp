import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_camp/common/utils/platform_utils.dart';

import '../const/data.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();
  dio.interceptors.add(CustomInterceptor());

  return dio;
});

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');
    options.queryParameters.addAll({
      'mobileOS': PlatformUtils.getPlatformType(),
      'mobileApp': 'TO_CAMP',
      'serviceKey': SERVICE_KEY,
      '_type': 'json',
    });
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response response, ResponseInterceptorHandler handler) {
    // print(
    //     '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }
}
