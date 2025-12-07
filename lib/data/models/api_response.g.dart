// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiResponse<T> _$ApiResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ApiResponse<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
    );

Map<String, dynamic> _$ApiResponseModelToJson<T>(
  ApiResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items.map(toJsonT).toList(),
    };
