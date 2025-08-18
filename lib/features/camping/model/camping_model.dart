import 'package:json_annotation/json_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'camping_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class CampingModel {

  @HiveField(0)
  final String contentId;
  @HiveField(1)
  final String firstImageUrl;
  @HiveField(2)
  final String facltNm;
  @HiveField(3)
  final String lineIntro;
  @HiveField(4)
  final String sbrsCl;
  @HiveField(5)
  final String posblFcltyCl;
  @HiveField(6)
  final String doNm;
  @HiveField(7)
  final String sigunguNm;
  @HiveField(8)
  final String brazierCl;
  @HiveField(9)
  final String animalCmgCl;
  @HiveField(10)
  final String caravAcmpnyAt;
  @HiveField(11)
  final String siteBottomCl1; //잔디
  @HiveField(12)
  final String siteBottomCl2; //파쇄석
  @HiveField(13)
  final String siteBottomCl3; //데크
  @HiveField(14)
  final String siteBottomCl4; //자갈
  @HiveField(15)
  final String siteBottomCl5; //흙
  @HiveField(16)
  final String intro;
  @HiveField(17)
  final String featureNm;
  @HiveField(18)
  final String mapX;
  @HiveField(19)
  final String mapY;
  @HiveField(20)
  final String addr1;
  @HiveField(21)
  final String resveUrl;
  @HiveField(22)
  final String tel;

  CampingModel({
    required this.contentId,
    required this.firstImageUrl,
    required this.facltNm,
    required this.lineIntro,
    required this.sbrsCl,
    required this.posblFcltyCl,
    required this.doNm,
    required this.sigunguNm,
    required this.brazierCl,
    required this.animalCmgCl,
    required this.caravAcmpnyAt,
    required this.siteBottomCl1,
    required this.siteBottomCl2,
    required this.siteBottomCl3,
    required this.siteBottomCl4,
    required this.siteBottomCl5,
    required this.intro,
    required this.featureNm,
    required this.mapX,
    required this.mapY,
    required this.addr1,
    required this.resveUrl,
    required this.tel,
  });

  factory CampingModel.fromJson(Map<String, dynamic> json) =>
      _$CampingModelFromJson(json);
}