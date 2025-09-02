// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_ad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerAdModel _$BannerAdModelFromJson(Map<String, dynamic> json) =>
    BannerAdModel(
      id: json['id'] as String,
      priority: (json['priority'] as num).toInt(),
      imgUrl: json['imgUrl'] as String,
      link: json['link'] as String,
    );

Map<String, dynamic> _$BannerAdModelToJson(BannerAdModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'priority': instance.priority,
      'imgUrl': instance.imgUrl,
      'link': instance.link,
    };
