import 'package:json_annotation/json_annotation.dart';

part 'camping_image_item.g.dart';

@JsonSerializable()
class CampingImageItem {
  final String imageUrl;

  CampingImageItem({required this.imageUrl});

  factory CampingImageItem.fromJson(Map<String, dynamic> json) =>
      _$CampingImageItemFromJson(json);
}
