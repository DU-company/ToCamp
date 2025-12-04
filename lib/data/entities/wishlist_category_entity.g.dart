// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_category_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistCategoryEntity _$WishlistCategoryEntityFromJson(
        Map<String, dynamic> json) =>
    WishlistCategoryEntity(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$WishlistCategoryEntityToJson(
        WishlistCategoryEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
