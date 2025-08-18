import 'package:json_annotation/json_annotation.dart';
part 'pagination_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginationResponse<T> {
  final ResponseHeader header;
  final ResponseBody<T> body;

  PaginationResponse({
    required this.header,
    required this.body,
  });

  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$PaginationResponseFromJson(json, fromJsonT);
}

@JsonSerializable()
class ResponseHeader {
  final String resultCode;
  final String resultMsg;

  ResponseHeader({
    required this.resultCode,
    required this.resultMsg,
  });

  factory ResponseHeader.fromJson(Map<String, dynamic> json) =>
      _$ResponseHeaderFromJson(json);
}

@JsonSerializable(genericArgumentFactories: true)
class ResponseBody<T> {
  final int numOfRows;
  final int pageNo;
  final int totalCount;
  final BodyItem<T> items;

  ResponseBody({
    required this.numOfRows,
    required this.pageNo,
    required this.totalCount,
    required this.items,
  });

  factory ResponseBody.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ResponseBodyFromJson(json, fromJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class BodyItem<T> {
  final List<T> item;

  BodyItem({required this.item});

  factory BodyItem.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BodyItemFromJson(json, fromJsonT);
}
