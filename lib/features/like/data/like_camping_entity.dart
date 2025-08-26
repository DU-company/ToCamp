import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';

part 'like_camping_entity.g.dart';

@JsonSerializable()
class LikeCampingEntity {
  final String id;
  final String thumbUrl;
  final String name;
  final String lineIntro;
  final String intro;
  final String sbrsCl;
  final String posblFcltyCl;
  final String doNm;
  final String sigunguNm;
  final String address;
  final String fire;
  final String pet;
  final String caravan;
  final double lng;
  final double lat;
  final String resveUrl;
  final String tel;
  final String siteBottomCl1;
  final String siteBottomCl2;
  final String siteBottomCl3;
  final String siteBottomCl4;
  final String siteBottomCl5;

  @JsonKey(toJson: _timeToInt, fromJson: _intToTime)
  final DateTime createdAt;
  final int categoryId;

  LikeCampingEntity({
    required this.id,
    required this.thumbUrl,
    required this.name,
    required this.lineIntro,
    required this.intro,
    required this.sbrsCl,
    required this.posblFcltyCl,
    required this.doNm,
    required this.sigunguNm,
    required this.address,
    required this.fire,
    required this.pet,
    required this.caravan,
    required this.lng,
    required this.lat,
    required this.resveUrl,
    required this.tel,
    required this.siteBottomCl1,
    required this.siteBottomCl2,
    required this.siteBottomCl3,
    required this.siteBottomCl4,
    required this.siteBottomCl5,
    required this.createdAt,
    required this.categoryId,
  });

  static int _timeToInt(DateTime time) {
    return time.millisecondsSinceEpoch;
  }

  static DateTime _intToTime(int number) {
    return DateTime.fromMillisecondsSinceEpoch(number);
  }

  factory LikeCampingEntity.fromJson(Map<String, dynamic> json) =>
      _$LikeCampingEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LikeCampingEntityToJson(this);

  factory LikeCampingEntity.fromCampingModel({
    required CampingModel model,
    required int categoryId,
  }) {
    return LikeCampingEntity(
      id: model.id,
      thumbUrl: model.thumbUrl,
      name: model.name,
      lineIntro: model.lineIntro,
      intro: model.intro,
      sbrsCl: model.sbrsCl,
      posblFcltyCl: model.posblFcltyCl,
      doNm: model.doNm,
      sigunguNm: model.sigunguNm,
      address: model.address,
      fire: model.fire,
      pet: model.pet,
      caravan: model.caravan,
      lng: model.lng,
      lat: model.lat,
      resveUrl: model.resveUrl,
      tel: model.tel,
      siteBottomCl1: model.siteBottomCl1,
      siteBottomCl2: model.siteBottomCl2,
      siteBottomCl3: model.siteBottomCl3,
      siteBottomCl4: model.siteBottomCl4,
      siteBottomCl5: model.siteBottomCl5,
      createdAt: DateTime.now(),
      categoryId: categoryId,
    );
  }

  CampingModel toCampingModel() {
    return CampingModel(
      id: id,
      thumbUrl: thumbUrl,
      name: name,
      lineIntro: lineIntro,
      intro: intro,
      sbrsCl: sbrsCl,
      posblFcltyCl: posblFcltyCl,
      doNm: doNm,
      sigunguNm: sigunguNm,
      address: address,
      fire: fire,
      pet: pet,
      caravan: caravan,
      lng: lng,
      lat: lat,
      resveUrl: resveUrl,
      tel: tel,
      siteBottomCl1: siteBottomCl1,
      siteBottomCl2: siteBottomCl2,
      siteBottomCl3: siteBottomCl3,
      siteBottomCl4: siteBottomCl4,
      siteBottomCl5: siteBottomCl5,
    );
  }
}
