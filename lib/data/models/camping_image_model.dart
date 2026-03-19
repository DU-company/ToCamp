import 'package:json_annotation/json_annotation.dart';
part 'camping_image_model.g.dart';

@JsonSerializable()
class CampingImageModel {
  final String imageUrl;

  CampingImageModel({required this.imageUrl});

  factory CampingImageModel.fromJson(Map<String, dynamic> json) =>
      _$CampingImageModelFromJson(json);
}
