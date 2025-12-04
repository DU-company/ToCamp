import 'package:json_annotation/json_annotation.dart';
import 'package:to_camp/core/utils/data_utils.dart';
import 'package:to_camp/data/models/recent_keyword_model.dart';
part 'recent_keyword_entity.g.dart';

@JsonSerializable()
class RecentKeywordEntity {
  final String keyword;
  @JsonKey(
    toJson: DataUtils.toJsonDateToInt,
    fromJson: DataUtils.fromJsonIntToDate,
  )
  final DateTime createdAt;

  RecentKeywordEntity({
    required this.keyword,
    required this.createdAt,
  });

  factory RecentKeywordEntity.fromJson(Map<String, dynamic> json) =>
      _$RecentKeywordEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecentKeywordEntityToJson(this);

  factory RecentKeywordEntity.fromModel(RecentKeywordModel model) {
    return RecentKeywordEntity(
      keyword: model.keyword,
      createdAt: model.createdAt,
    );
  }

  RecentKeywordModel toModel() {
    return RecentKeywordModel(keyword: keyword, createdAt: createdAt);
  }
}
