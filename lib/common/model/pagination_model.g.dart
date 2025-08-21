// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationData<T> _$PaginationDataFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationData<T>(
      response: PaginationResponse<T>.fromJson(
          json['response'] as Map<String, dynamic>,
          (value) => fromJsonT(value)),
    );

Map<String, dynamic> _$PaginationDataToJson<T>(
  PaginationData<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'response': instance.response,
    };

PaginationResponse<T> _$PaginationResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationResponse<T>(
      header: ResponseHeader.fromJson(json['header'] as Map<String, dynamic>),
      body: ResponseBody<T>.fromJson(
          json['body'] as Map<String, dynamic>, (value) => fromJsonT(value)),
    );

Map<String, dynamic> _$PaginationResponseToJson<T>(
  PaginationResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'header': instance.header,
      'body': instance.body,
    };

ResponseHeader _$ResponseHeaderFromJson(Map<String, dynamic> json) =>
    ResponseHeader(
      resultCode: json['resultCode'] as String,
      resultMsg: json['resultMsg'] as String,
    );

Map<String, dynamic> _$ResponseHeaderToJson(ResponseHeader instance) =>
    <String, dynamic>{
      'resultCode': instance.resultCode,
      'resultMsg': instance.resultMsg,
    };

ResponseBody<T> _$ResponseBodyFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ResponseBody<T>(
      numOfRows: (json['numOfRows'] as num).toInt(),
      pageNo: (json['pageNo'] as num).toInt(),
      totalCount: (json['totalCount'] as num).toInt(),
      items: BodyItem<T>.fromJson(
          json['items'] as Map<String, dynamic>, (value) => fromJsonT(value)),
    );

Map<String, dynamic> _$ResponseBodyToJson<T>(
  ResponseBody<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'numOfRows': instance.numOfRows,
      'pageNo': instance.pageNo,
      'totalCount': instance.totalCount,
      'items': instance.items,
    };

BodyItem<T> _$BodyItemFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BodyItem<T>(
      item: (json['item'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$BodyItemToJson<T>(
  BodyItem<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'item': instance.item.map(toJsonT).toList(),
    };
