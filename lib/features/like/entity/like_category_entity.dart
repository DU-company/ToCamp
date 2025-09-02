import 'package:json_annotation/json_annotation.dart';
part 'like_category_entity.g.dart';

@JsonSerializable()
class LikeCategoryEntity {
  int? id;
  String name;

  LikeCategoryEntity(this.id, this.name);

  Map<String, dynamic> toJson() => _$LikeCategoryEntityToJson(this);

  factory LikeCategoryEntity.fromJson(Map<String, dynamic> json) =>
      _$LikeCategoryEntityFromJson(json);

}
