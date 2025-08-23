import 'package:json_annotation/json_annotation.dart';

part 'camping_recommendation_model.g.dart';

@JsonSerializable()
class CampingRecommendationModel {
  final String region;
  final int order;

  CampingRecommendationModel({
    required this.region,
    required this.order,
  });

  factory CampingRecommendationModel.fromJson(Map<String, dynamic>json)
  => _$CampingRecommendationModelFromJson(json);
}
