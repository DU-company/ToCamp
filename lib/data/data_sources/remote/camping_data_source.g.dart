// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camping_data_source.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _CampingDataSource implements CampingDataSource {
  _CampingDataSource(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<CampingModel>> fetchBasedList(
      PaginationParams params) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params.toJson());
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<CampingModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/basedList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ApiResponse<CampingModel>.fromJson(
      _result.data!,
      (json) => CampingModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<CampingImageEntity>> fetchImageList(
      PaginationParams params) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params.toJson());
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<CampingImageEntity>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/imageList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ApiResponse<CampingImageEntity>.fromJson(
      _result.data!,
      (json) => CampingImageEntity.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<CampingModel>> fetchLocationBasedList(
      PaginationParams params) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params.toJson());
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<CampingModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/locationBasedList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ApiResponse<CampingModel>.fromJson(
      _result.data!,
      (json) => CampingModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<CampingModel>> fetchSearchList(
      PaginationParams params) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(params.toJson());
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<CampingModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/searchList',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = ApiResponse<CampingModel>.fromJson(
      _result.data!,
      (json) => CampingModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
