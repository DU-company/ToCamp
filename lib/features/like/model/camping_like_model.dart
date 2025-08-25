import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:to_camp/features/camping/model/camping_model.dart';
part 'camping_like_model.g.dart';

@HiveType(typeId: 2)
class CampingLikeModel extends HiveObject {
  @HiveField(0)
  // @JsonKey(name: 'contentId')
  final String id;

  @HiveField(1)
  // @JsonKey(name: 'firstImageUrl')
  final String thumbUrl;

  @HiveField(2)
  @JsonKey(name: 'facltNm')
  final String name;

  @HiveField(3)
  final String lineIntro; // 한줄 섦명
  @HiveField(4)
  final String intro; // 부가 설명
  @HiveField(5)
  final String sbrsCl; // 편의시설
  @HiveField(6)
  final String posblFcltyCl; // 체험 시설
  @HiveField(7)
  final String doNm; // 도
  @HiveField(8)
  final String sigunguNm; // 시군구

  @HiveField(9)
  // @JsonKey(name: 'addr1')
  final String address; // 상세주소

  @HiveField(10)
  // @JsonKey(name: 'brazierCl')
  final String fire; // 화로

  @HiveField(11)
  // @JsonKey(name: 'animalCmgCl')
  final String pet; // 애완동물

  @HiveField(12)
  // @JsonKey(name: 'caravAcmpnyAt')
  final String caravan; // 카라반

  @HiveField(13)
  // @JsonKey(name: 'mapX', fromJson: _stringToNumber)
  final double lng;

  @HiveField(14)
  // @JsonKey(name: 'mapY', fromJson: _stringToNumber)
  final double lat;

  @HiveField(15)
  final String resveUrl;

  @HiveField(16)
  final String tel;

  @HiveField(17)
  final String siteBottomCl1; //잔디
  @HiveField(18)
  final String siteBottomCl2; //파쇄석
  @HiveField(19)
  final String siteBottomCl3; //데크
  @HiveField(20)
  final String siteBottomCl4; //자갈
  @HiveField(21)
  final String siteBottomCl5; //흙

  CampingLikeModel({
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
  });

  // static double _stringToNumber(String text) {
  //   if (text.isEmpty) return 0;
  //   return double.tryParse(text) ?? 0;
  // }

  factory CampingLikeModel.fromCampingModel(CampingModel model) {
    return CampingLikeModel(
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
