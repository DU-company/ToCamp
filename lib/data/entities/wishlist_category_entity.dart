import 'package:json_annotation/json_annotation.dart';

part 'wishlist_category_entity.g.dart';

@JsonSerializable()
class WishlistCategoryEntity {
  int? id; // AutoIncrement
  final String name;

  WishlistCategoryEntity({this.id, required this.name});

  factory WishlistCategoryEntity.fromJson(
    Map<String, dynamic> json,
  ) => _$WishlistCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$WishlistCategoryEntityToJson(this);
}
