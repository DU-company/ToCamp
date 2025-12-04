import 'package:json_annotation/json_annotation.dart';

part 'error_state_model.g.dart';

@JsonSerializable()
class ErrorStateModel {
  final String title;
  final String content;

  ErrorStateModel({required this.title, required this.content});

  factory ErrorStateModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorStateModelFromJson(json);
}
