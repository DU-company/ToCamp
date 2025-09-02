// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camping_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampingModel _$CampingModelFromJson(Map<String, dynamic> json) => CampingModel(
      id: json['contentId'] as String,
      thumbUrl: json['firstImageUrl'] as String,
      name: json['facltNm'] as String,
      lineIntro: json['lineIntro'] as String,
      intro: json['intro'] as String,
      sbrsCl: json['sbrsCl'] as String,
      posblFcltyCl: json['posblFcltyCl'] as String,
      doNm: json['doNm'] as String,
      sigunguNm: json['sigunguNm'] as String,
      address: json['addr1'] as String,
      fire: json['brazierCl'] as String,
      pet: json['animalCmgCl'] as String,
      caravan: json['caravAcmpnyAt'] as String,
      lng: CampingModel._stringToNumber(json['mapX'] as String),
      lat: CampingModel._stringToNumber(json['mapY'] as String),
      resveUrl: json['resveUrl'] as String,
      homepage: json['homepage'] as String,
      tel: json['tel'] as String,
      siteBottomCl1: json['siteBottomCl1'] as String,
      siteBottomCl2: json['siteBottomCl2'] as String,
      siteBottomCl3: json['siteBottomCl3'] as String,
      siteBottomCl4: json['siteBottomCl4'] as String,
      siteBottomCl5: json['siteBottomCl5'] as String,
    );

Map<String, dynamic> _$CampingModelToJson(CampingModel instance) =>
    <String, dynamic>{
      'contentId': instance.id,
      'firstImageUrl': instance.thumbUrl,
      'facltNm': instance.name,
      'lineIntro': instance.lineIntro,
      'intro': instance.intro,
      'sbrsCl': instance.sbrsCl,
      'posblFcltyCl': instance.posblFcltyCl,
      'doNm': instance.doNm,
      'sigunguNm': instance.sigunguNm,
      'addr1': instance.address,
      'brazierCl': instance.fire,
      'animalCmgCl': instance.pet,
      'caravAcmpnyAt': instance.caravan,
      'mapX': instance.lng,
      'mapY': instance.lat,
      'resveUrl': instance.resveUrl,
      'homepage': instance.homepage,
      'tel': instance.tel,
      'siteBottomCl1': instance.siteBottomCl1,
      'siteBottomCl2': instance.siteBottomCl2,
      'siteBottomCl3': instance.siteBottomCl3,
      'siteBottomCl4': instance.siteBottomCl4,
      'siteBottomCl5': instance.siteBottomCl5,
    };
