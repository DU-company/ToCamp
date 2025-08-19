import 'package:json_annotation/json_annotation.dart';
part 'pagination_model.g.dart';

abstract class PaginationState {}

class PaginationLoading extends PaginationState {}

class PaginationError extends PaginationState {
  final String message;
  PaginationError({required this.message});
}

class PaginationErrorHasData<T> extends PaginationSuccess {
  PaginationErrorHasData({required super.response});
}

class PaginationFetchingMore<T> extends PaginationSuccess {
  PaginationFetchingMore({required super.response});
}

class PaginationReFetching<T> extends PaginationSuccess {
  PaginationReFetching({required super.response});
}

@JsonSerializable(genericArgumentFactories: true)
class PaginationSuccess<T> extends PaginationState {
  final PaginationResponse<T> response;
  PaginationSuccess({required this.response});

  factory PaginationSuccess.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginationSuccessFromJson(json, fromJsonT);
}

@JsonSerializable(genericArgumentFactories: true)
class PaginationResponse<T> {
  final ResponseHeader header;
  final ResponseBody<T> body;

  PaginationResponse({required this.header, required this.body});

  factory PaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$PaginationResponseFromJson(json, fromJsonT);
}

@JsonSerializable()
class ResponseHeader {
  final String resultCode;
  final String resultMsg;

  ResponseHeader({required this.resultCode, required this.resultMsg});

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

  // factory ResponseBody.fromJson(
  //   Map<String, dynamic> json,
  //   T Function(Object? json) fromJsonT,
  // ) => _$ResponseBodyFromJson(json, fromJsonT);

  factory ResponseBody.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    final items = json['items'];

    /// 데이터가 존재할 경우
    if (items is Map<String, dynamic>) {
      return ResponseBody(
        numOfRows: json['numOfRows'],
        pageNo: json['pageNo'],
        totalCount: json['totalCount'],
        items: BodyItem.fromJson(json['items'], fromJsonT),
      );
    }

    /// 데이터가 존재하지 않을 경우
    return ResponseBody(
      numOfRows: json['numOfRows'],
      pageNo: json['pageNo'],
      totalCount: json['totalCount'],
      items: BodyItem(item: []),
    );
  }
}

@JsonSerializable(genericArgumentFactories: true)
class BodyItem<T> {
  final List<T> item;

  BodyItem({required this.item});

  factory BodyItem.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$BodyItemFromJson(json, fromJsonT);
}
