import 'package:json_annotation/json_annotation.dart';

part 'like_category_entity.g.dart';

@JsonSerializable()
class LikeCategoryEntity {
  int? id; // AutoIncrement
  final String name;

  LikeCategoryEntity({this.id, required this.name});

  factory LikeCategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$LikeCategoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LikeCategoryEntityToJson(this);
}
