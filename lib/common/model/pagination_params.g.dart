// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pagination_params.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginationParams _$PaginationParamsFromJson(Map<String, dynamic> json) =>
    PaginationParams(
      take: (json['numOfRows'] as num).toInt(),
      pageNo: (json['pageNo'] as num).toInt(),
      id: json['contentId'] as String?,
      lat: (json['mapY'] as num?)?.toDouble(),
      lng: (json['mapX'] as num?)?.toDouble(),
      radius: (json['radius'] as num?)?.toDouble(),
      keyword: json['keyword'] as String?,
    );

Map<String, dynamic> _$PaginationParamsToJson(PaginationParams instance) {
  final val = <String, dynamic>{
    'pageNo': instance.pageNo,
    'numOfRows': instance.take,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('contentId', instance.id);
  writeNotNull('mapY', PaginationParams.numberToString(instance.lat));
  writeNotNull('mapX', PaginationParams.numberToString(instance.lng));
  writeNotNull('radius', PaginationParams.numberToString(instance.radius));
  writeNotNull('keyword', instance.keyword);
  return val;
}
