import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'camping_model.g.dart';

@JsonSerializable()
class CampingModel {
  // @HiveField(0)
  @JsonKey(name: 'contentId')
  final String id;

  // @HiveField(1)
  @JsonKey(name: 'firstImageUrl')
  final String thumbUrl;

  // @HiveField(2)
  @JsonKey(name: 'facltNm')
  final String name;

  // @HiveField(3)
  final String lineIntro; // 한줄 섦명
  // @HiveField(4)
  final String intro; // 부가 설명
  // @HiveField(5)
  final String sbrsCl; // 편의시설
  // @HiveField(6)
  final String posblFcltyCl; // 체험 시설
  // @HiveField(7)
  final String doNm; // 도
  // @HiveField(8)
  final String sigunguNm; // 시군구

  // @HiveField(9)
  @JsonKey(name: 'addr1')
  final String address; // 상세주소

  // @HiveField(10)
  @JsonKey(name: 'brazierCl')
  final String fire; // 화로

  // @HiveField(11)
  @JsonKey(name: 'animalCmgCl')
  final String pet; // 애완동물

  // @HiveField(12)
  @JsonKey(name: 'caravAcmpnyAt')
  final String caravan; // 카라반

  // @HiveField(13)
  @JsonKey(name: 'mapX', fromJson: _stringToNumber)
  final double lng;

  // @HiveField(14)
  @JsonKey(name: 'mapY', fromJson: _stringToNumber)
  final double lat;

  // @HiveField(15)
  final String resveUrl;

  // @HiveField(16)
  final String tel;

  // @HiveField(17)
  final String siteBottomCl1; //잔디
  // @HiveField(18)
  final String siteBottomCl2; //파쇄석
  // @HiveField(19)
  final String siteBottomCl3; //데크
  // @HiveField(20)
  final String siteBottomCl4; //자갈
  // @HiveField(21)
  final String siteBottomCl5; //흙

  CampingModel({
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

  factory CampingModel.fromJson(Map<String, dynamic> json) =>
      _$CampingModelFromJson(json);

  static double _stringToNumber(String text) {
    if (text.isEmpty) return 0;
    return double.tryParse(text) ?? 0;
  }
}
