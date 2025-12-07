import 'package:json_annotation/json_annotation.dart';
part 'camping_image_entity.g.dart';

@JsonSerializable()
class CampingImageEntity {
  final String imageUrl;

  CampingImageEntity({required this.imageUrl});

  factory CampingImageEntity.fromJson(Map<String, dynamic> json) =>
      _$CampingImageEntityFromJson(json);
}
