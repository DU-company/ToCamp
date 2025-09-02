// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationSuccess<T> _$PaginationSuccessFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PaginationSuccess<T>(
      items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
      totalCount: (json['totalCount'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationSuccessToJson<T>(
  PaginationSuccess<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'items': instance.items.map(toJsonT).toList(),
      'totalCount': instance.totalCount,
    };
