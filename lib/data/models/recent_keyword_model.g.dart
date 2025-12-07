// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_keyword_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentKeywordModel _$RecentKeywordModelFromJson(Map<String, dynamic> json) =>
    RecentKeywordModel(
      keyword: json['keyword'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$RecentKeywordModelToJson(RecentKeywordModel instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'createdAt': instance.createdAt.toIso8601String(),
    };
