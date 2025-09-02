// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_keyword_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentKeywordModelAdapter extends TypeAdapter<RecentKeywordModel> {
  @override
  final int typeId = 0;

  @override
  RecentKeywordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentKeywordModel(
      keyword: fields[0] as String,
      createdAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RecentKeywordModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.keyword)
      ..writeByte(1)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentKeywordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
