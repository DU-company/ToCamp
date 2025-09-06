import 'package:json_annotation/json_annotation.dart';

part 'camping_model.g.dart';

@JsonSerializable()
class CampingModel {
  @JsonKey(name: 'contentId')
  final String id;

  @JsonKey(name: 'firstImageUrl')
  final String thumbUrl;

  @JsonKey(name: 'facltNm')
  final String name;

  final String lineIntro; // 한줄 섦명
  final String intro; // 부가 설명
  final String sbrsCl; // 편의시설
  final String posblFcltyCl; // 체험 시설
  final String doNm; // 도
  final String sigunguNm; // 시군구

  @JsonKey(name: 'addr1')
  final String address; // 상세주소

  @JsonKey(name: 'brazierCl')
  final String fire; // 화로
  @JsonKey(name: 'animalCmgCl')
  final String pet; // 애완동물
  @JsonKey(name: 'caravAcmpnyAt')
  final String caravan; // 카라반

  @JsonKey(name: 'mapX', fromJson: _stringToNumber)
  final double lng;
  @JsonKey(name: 'mapY', fromJson: _stringToNumber)
  final double lat;

  final String resveUrl;
  final String homepage;

  final String tel;
  final String siteBottomCl1; //잔디
  final String siteBottomCl2; //파쇄석
  final String siteBottomCl3; //데크
  final String siteBottomCl4; //자갈
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
    required this.homepage,
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
