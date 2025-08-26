// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_camping_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeCampingEntity _$LikeCampingEntityFromJson(Map<String, dynamic> json) =>
    LikeCampingEntity(
      id: json['id'] as String,
      thumbUrl: json['thumbUrl'] as String,
      name: json['name'] as String,
      lineIntro: json['lineIntro'] as String,
      intro: json['intro'] as String,
      sbrsCl: json['sbrsCl'] as String,
      posblFcltyCl: json['posblFcltyCl'] as String,
      doNm: json['doNm'] as String,
      sigunguNm: json['sigunguNm'] as String,
      address: json['address'] as String,
      fire: json['fire'] as String,
      pet: json['pet'] as String,
      caravan: json['caravan'] as String,
      lng: (json['lng'] as num).toDouble(),
      lat: (json['lat'] as num).toDouble(),
      resveUrl: json['resveUrl'] as String,
      tel: json['tel'] as String,
      siteBottomCl1: json['siteBottomCl1'] as String,
      siteBottomCl2: json['siteBottomCl2'] as String,
      siteBottomCl3: json['siteBottomCl3'] as String,
      siteBottomCl4: json['siteBottomCl4'] as String,
      siteBottomCl5: json['siteBottomCl5'] as String,
      createdAt:
          LikeCampingEntity._intToTime((json['createdAt'] as num).toInt()),
      categoryId: (json['categoryId'] as num).toInt(),
    );

Map<String, dynamic> _$LikeCampingEntityToJson(LikeCampingEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'thumbUrl': instance.thumbUrl,
      'name': instance.name,
      'lineIntro': instance.lineIntro,
      'intro': instance.intro,
      'sbrsCl': instance.sbrsCl,
      'posblFcltyCl': instance.posblFcltyCl,
      'doNm': instance.doNm,
      'sigunguNm': instance.sigunguNm,
      'address': instance.address,
      'fire': instance.fire,
      'pet': instance.pet,
      'caravan': instance.caravan,
      'lng': instance.lng,
      'lat': instance.lat,
      'resveUrl': instance.resveUrl,
      'tel': instance.tel,
      'siteBottomCl1': instance.siteBottomCl1,
      'siteBottomCl2': instance.siteBottomCl2,
      'siteBottomCl3': instance.siteBottomCl3,
      'siteBottomCl4': instance.siteBottomCl4,
      'siteBottomCl5': instance.siteBottomCl5,
      'createdAt': LikeCampingEntity._timeToInt(instance.createdAt),
      'categoryId': instance.categoryId,
    };
