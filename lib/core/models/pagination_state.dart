abstract class PaginationState {}

class PaginationLoading extends PaginationState {}

class PaginationError extends PaginationState {
  final String message;

  PaginationError({required this.message});
}

class PaginationSuccess<T> extends PaginationState {
  final List<T> items;
  final bool hasMore;

  PaginationSuccess({required this.items, required this.hasMore});

  PaginationSuccess<T> copyWith({List<T>? items, bool? hasMore}) {
    return PaginationSuccess<T>(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class PaginationFetchingError<T> extends PaginationSuccess<T> {
  final String message;
  PaginationFetchingError({
    required super.items,
    required super.hasMore,
    required this.message,
  });
}

class PaginationFetchingMore<T> extends PaginationSuccess<T> {
  PaginationFetchingMore({
    required super.items,
    required super.hasMore,
  });
}
