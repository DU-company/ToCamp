abstract class PaginationStateV2 {}

class PaginationLoadingV2 extends PaginationStateV2 {}

class PaginationErrorV2 extends PaginationStateV2 {
  final String message;

  PaginationErrorV2({required this.message});
}

class PaginationSuccessV2<T> extends PaginationStateV2 {
  final List<T> items;
  final bool hasMore;

  PaginationSuccessV2({required this.items, required this.hasMore});

  PaginationSuccessV2<T> copyWith({List<T>? items, bool? hasMore}) {
    return PaginationSuccessV2<T>(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class PaginationFetchingErrorV2<T> extends PaginationSuccessV2<T> {
  PaginationFetchingErrorV2({
    required super.items,
    required super.hasMore,
  });
}

class PaginationFetchingMoreV2<T> extends PaginationSuccessV2<T> {
  PaginationFetchingMoreV2({
    required super.items,
    required super.hasMore,
  });
}
