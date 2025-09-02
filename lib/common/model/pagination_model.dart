import 'package:json_annotation/json_annotation.dart';
part 'pagination_model.g.dart';

abstract class PaginationState {}

class PaginationLoading extends PaginationState {}

class PaginationError extends PaginationState {
  final String message;
  PaginationError({required this.message});
}

class PaginationErrorHasData<T> extends PaginationSuccess<T> {
  PaginationErrorHasData({
    required super.items,
    required super.totalCount,
  });
}

class PaginationFetchingMore<T> extends PaginationSuccess<T> {
  PaginationFetchingMore({
    required super.items,
    required super.totalCount,
  });
}

class PaginationReFetching<T> extends PaginationSuccess<T> {
  PaginationReFetching({
    required super.items,
    required super.totalCount,
  });
}

@JsonSerializable(genericArgumentFactories: true)
class PaginationSuccess<T> extends PaginationState {
  final List<T> items;
  final int totalCount;

  PaginationSuccess({required this.items, required this.totalCount});

  factory PaginationSuccess.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    final items = json['response']['body']['items'];
    List<T> pItems;

    /// 빈 응닶값은 "" 형태로 오기 때문
    if (items is String) {
      pItems = <T>[];
    } else {
      pItems = [...(items['item'] as List).map((e) => fromJsonT(e))];
    }
    return PaginationSuccess(
      items: pItems,
      totalCount: json['response']['body']['totalCount'],
    );
  }

  PaginationSuccess<T> copyWith({List<T>? items, int? totalCount}) {
    return PaginationSuccess(
      items: items ?? this.items,
      totalCount: totalCount ?? this.totalCount,
    );
  }
}
