import 'package:json_annotation/json_annotation.dart';
part 'recent_keyword_model.g.dart';

@JsonSerializable()
class RecentKeywordModel {
  final String keyword;
  final DateTime createdAt;

  RecentKeywordModel({
    required this.keyword,
    required this.createdAt,
  });

  factory RecentKeywordModel.fromJson(Map<String, dynamic> json) =>
      _$RecentKeywordModelFromJson(json);
}
