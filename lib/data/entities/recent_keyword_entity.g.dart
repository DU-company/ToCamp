// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_keyword_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentKeywordEntity _$RecentKeywordEntityFromJson(Map<String, dynamic> json) =>
    RecentKeywordEntity(
      keyword: json['keyword'] as String,
      createdAt:
          DataUtils.fromJsonIntToDate((json['createdAt'] as num).toInt()),
    );

Map<String, dynamic> _$RecentKeywordEntityToJson(
        RecentKeywordEntity instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'createdAt': DataUtils.toJsonDateToInt(instance.createdAt),
    };
