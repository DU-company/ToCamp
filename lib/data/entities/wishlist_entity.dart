import 'package:json_annotation/json_annotation.dart';

part 'wishlist_entity.g.dart';

@JsonSerializable()
class WishlistEntity {
  int? id; // AutoIncrement
  final String name;

  WishlistEntity({this.id, required this.name});

  factory WishlistEntity.fromJson(Map<String, dynamic> json) =>
      _$WishlistEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistEntityToJson(this);
}
