// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camping_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CampingModelAdapter extends TypeAdapter<CampingModel> {
  @override
  final int typeId = 0;

  @override
  CampingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CampingModel(
      contentId: fields[0] as String,
      firstImageUrl: fields[1] as String,
      facltNm: fields[2] as String,
      lineIntro: fields[3] as String,
      sbrsCl: fields[4] as String,
      posblFcltyCl: fields[5] as String,
      doNm: fields[6] as String,
      sigunguNm: fields[7] as String,
      brazierCl: fields[8] as String,
      animalCmgCl: fields[9] as String,
      caravAcmpnyAt: fields[10] as String,
      siteBottomCl1: fields[11] as String,
      siteBottomCl2: fields[12] as String,
      siteBottomCl3: fields[13] as String,
      siteBottomCl4: fields[14] as String,
      siteBottomCl5: fields[15] as String,
      intro: fields[16] as String,
      featureNm: fields[17] as String,
      mapX: fields[18] as String,
      mapY: fields[19] as String,
      addr1: fields[20] as String,
      resveUrl: fields[21] as String,
      tel: fields[22] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CampingModel obj) {
    writer
      ..writeByte(23)
      ..writeByte(0)
      ..write(obj.contentId)
      ..writeByte(1)
      ..write(obj.firstImageUrl)
      ..writeByte(2)
      ..write(obj.facltNm)
      ..writeByte(3)
      ..write(obj.lineIntro)
      ..writeByte(4)
      ..write(obj.sbrsCl)
      ..writeByte(5)
      ..write(obj.posblFcltyCl)
      ..writeByte(6)
      ..write(obj.doNm)
      ..writeByte(7)
      ..write(obj.sigunguNm)
      ..writeByte(8)
      ..write(obj.brazierCl)
      ..writeByte(9)
      ..write(obj.animalCmgCl)
      ..writeByte(10)
      ..write(obj.caravAcmpnyAt)
      ..writeByte(11)
      ..write(obj.siteBottomCl1)
      ..writeByte(12)
      ..write(obj.siteBottomCl2)
      ..writeByte(13)
      ..write(obj.siteBottomCl3)
      ..writeByte(14)
      ..write(obj.siteBottomCl4)
      ..writeByte(15)
      ..write(obj.siteBottomCl5)
      ..writeByte(16)
      ..write(obj.intro)
      ..writeByte(17)
      ..write(obj.featureNm)
      ..writeByte(18)
      ..write(obj.mapX)
      ..writeByte(19)
      ..write(obj.mapY)
      ..writeByte(20)
      ..write(obj.addr1)
      ..writeByte(21)
      ..write(obj.resveUrl)
      ..writeByte(22)
      ..write(obj.tel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CampingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CampingModel _$CampingModelFromJson(Map<String, dynamic> json) => CampingModel(
      contentId: json['contentId'] as String,
      firstImageUrl: json['firstImageUrl'] as String,
      facltNm: json['facltNm'] as String,
      lineIntro: json['lineIntro'] as String,
      sbrsCl: json['sbrsCl'] as String,
      posblFcltyCl: json['posblFcltyCl'] as String,
      doNm: json['doNm'] as String,
      sigunguNm: json['sigunguNm'] as String,
      brazierCl: json['brazierCl'] as String,
      animalCmgCl: json['animalCmgCl'] as String,
      caravAcmpnyAt: json['caravAcmpnyAt'] as String,
      siteBottomCl1: json['siteBottomCl1'] as String,
      siteBottomCl2: json['siteBottomCl2'] as String,
      siteBottomCl3: json['siteBottomCl3'] as String,
      siteBottomCl4: json['siteBottomCl4'] as String,
      siteBottomCl5: json['siteBottomCl5'] as String,
      intro: json['intro'] as String,
      featureNm: json['featureNm'] as String,
      mapX: json['mapX'] as String,
      mapY: json['mapY'] as String,
      addr1: json['addr1'] as String,
      resveUrl: json['resveUrl'] as String,
      tel: json['tel'] as String,
    );

Map<String, dynamic> _$CampingModelToJson(CampingModel instance) =>
    <String, dynamic>{
      'contentId': instance.contentId,
      'firstImageUrl': instance.firstImageUrl,
      'facltNm': instance.facltNm,
      'lineIntro': instance.lineIntro,
      'sbrsCl': instance.sbrsCl,
      'posblFcltyCl': instance.posblFcltyCl,
      'doNm': instance.doNm,
      'sigunguNm': instance.sigunguNm,
      'brazierCl': instance.brazierCl,
      'animalCmgCl': instance.animalCmgCl,
      'caravAcmpnyAt': instance.caravAcmpnyAt,
      'siteBottomCl1': instance.siteBottomCl1,
      'siteBottomCl2': instance.siteBottomCl2,
      'siteBottomCl3': instance.siteBottomCl3,
      'siteBottomCl4': instance.siteBottomCl4,
      'siteBottomCl5': instance.siteBottomCl5,
      'intro': instance.intro,
      'featureNm': instance.featureNm,
      'mapX': instance.mapX,
      'mapY': instance.mapY,
      'addr1': instance.addr1,
      'resveUrl': instance.resveUrl,
      'tel': instance.tel,
    };
