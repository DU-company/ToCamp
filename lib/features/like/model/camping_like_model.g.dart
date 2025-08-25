// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camping_like_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CampingLikeModelAdapter extends TypeAdapter<CampingLikeModel> {
  @override
  final int typeId = 2;

  @override
  CampingLikeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CampingLikeModel(
      id: fields[0] as String,
      thumbUrl: fields[1] as String,
      name: fields[2] as String,
      lineIntro: fields[3] as String,
      intro: fields[4] as String,
      sbrsCl: fields[5] as String,
      posblFcltyCl: fields[6] as String,
      doNm: fields[7] as String,
      sigunguNm: fields[8] as String,
      address: fields[9] as String,
      fire: fields[10] as String,
      pet: fields[11] as String,
      caravan: fields[12] as String,
      lng: fields[13] as double,
      lat: fields[14] as double,
      resveUrl: fields[15] as String,
      tel: fields[16] as String,
      siteBottomCl1: fields[17] as String,
      siteBottomCl2: fields[18] as String,
      siteBottomCl3: fields[19] as String,
      siteBottomCl4: fields[20] as String,
      siteBottomCl5: fields[21] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CampingLikeModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.thumbUrl)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.lineIntro)
      ..writeByte(4)
      ..write(obj.intro)
      ..writeByte(5)
      ..write(obj.sbrsCl)
      ..writeByte(6)
      ..write(obj.posblFcltyCl)
      ..writeByte(7)
      ..write(obj.doNm)
      ..writeByte(8)
      ..write(obj.sigunguNm)
      ..writeByte(9)
      ..write(obj.address)
      ..writeByte(10)
      ..write(obj.fire)
      ..writeByte(11)
      ..write(obj.pet)
      ..writeByte(12)
      ..write(obj.caravan)
      ..writeByte(13)
      ..write(obj.lng)
      ..writeByte(14)
      ..write(obj.lat)
      ..writeByte(15)
      ..write(obj.resveUrl)
      ..writeByte(16)
      ..write(obj.tel)
      ..writeByte(17)
      ..write(obj.siteBottomCl1)
      ..writeByte(18)
      ..write(obj.siteBottomCl2)
      ..writeByte(19)
      ..write(obj.siteBottomCl3)
      ..writeByte(20)
      ..write(obj.siteBottomCl4)
      ..writeByte(21)
      ..write(obj.siteBottomCl5);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CampingLikeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
