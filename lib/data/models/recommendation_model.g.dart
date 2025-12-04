// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationModel _$RecommendationModelFromJson(Map<String, dynamic> json) =>
    RecommendationModel(
      region: json['region'] as String,
      priority: (json['priority'] as num).toInt(),
    );

Map<String, dynamic> _$RecommendationModelToJson(
        RecommendationModel instance) =>
    <String, dynamic>{
      'region': instance.region,
      'priority': instance.priority,
    };
