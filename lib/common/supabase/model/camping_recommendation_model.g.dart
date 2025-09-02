// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camping_recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampingRecommendationModel _$CampingRecommendationModelFromJson(
        Map<String, dynamic> json) =>
    CampingRecommendationModel(
      region: json['region'] as String,
      priority: (json['priority'] as num).toInt(),
    );

Map<String, dynamic> _$CampingRecommendationModelToJson(
        CampingRecommendationModel instance) =>
    <String, dynamic>{
      'region': instance.region,
      'priority': instance.priority,
    };
