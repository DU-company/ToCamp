import 'package:json_annotation/json_annotation.dart';

part 'banner_ad_model.g.dart';

@JsonSerializable()
class BannerAdModel {
  final String id;
  final int priority;
  final String imgUrl;
  final String link;

  BannerAdModel({
    required this.id,
    required this.priority,
    required this.imgUrl,
    required this.link,
  });

  factory BannerAdModel.fromJson(Map<String, dynamic> json) =>
      _$BannerAdModelFromJson(json);
}
