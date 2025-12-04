import 'package:json_annotation/json_annotation.dart';

part 'recommendation_model.g.dart';

@JsonSerializable()
class RecommendationModel {
  final String region;
  final int priority;

  RecommendationModel({required this.region, required this.priority});

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationModelFromJson(json);
}
