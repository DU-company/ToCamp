// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeCategoryEntity _$LikeCategoryEntityFromJson(Map<String, dynamic> json) =>
    LikeCategoryEntity(
      (json['id'] as num?)?.toInt(),
      json['name'] as String,
    );

Map<String, dynamic> _$LikeCategoryEntityToJson(LikeCategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
