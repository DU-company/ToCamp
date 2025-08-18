import 'package:json_annotation/json_annotation.dart';

part 'pagination_params.g.dart';

@JsonSerializable(includeIfNull: false)
class PaginationParams {
  final int? numOfRows;
  final int? pageNo;
  @JsonKey(toJson: numberToString, name: 'mapY')
  final double? lat;
  @JsonKey(toJson: numberToString, name: 'mapX')
  final double? lng;
  @JsonKey(toJson: numberToString)
  final double? radius;
  final String? keyword;

  PaginationParams({
    this.numOfRows,
    this.pageNo,
    this.lat,
    this.lng,
    this.radius,
    this.keyword,
  });

  Map<String, dynamic> toJson() => _$PaginationParamsToJson(this);

  static String? numberToString(double? number) {
    return number?.toString();
  }
}
