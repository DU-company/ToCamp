// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParams _$PaginationParamsFromJson(Map<String, dynamic> json) =>
    PaginationParams(
      numOfRows: (json['numOfRows'] as num?)?.toInt(),
      pageNo: (json['pageNo'] as num?)?.toInt(),
      lat: (json['mapY'] as num?)?.toDouble(),
      lng: (json['mapX'] as num?)?.toDouble(),
      radius: (json['radius'] as num?)?.toDouble(),
      keyword: json['keyword'] as String?,
    );

Map<String, dynamic> _$PaginationParamsToJson(PaginationParams instance) =>
    <String, dynamic>{
      if (instance.numOfRows case final value?) 'numOfRows': value,
      if (instance.pageNo case final value?) 'pageNo': value,
      if (PaginationParams.numberToString(instance.lat) case final value?)
        'mapY': value,
      if (PaginationParams.numberToString(instance.lng) case final value?)
        'mapX': value,
      if (PaginationParams.numberToString(instance.radius) case final value?)
        'radius': value,
      if (instance.keyword case final value?) 'keyword': value,
    };
