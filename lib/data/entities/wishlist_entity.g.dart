// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistEntity _$WishlistEntityFromJson(Map<String, dynamic> json) =>
    WishlistEntity(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$WishlistEntityToJson(WishlistEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
