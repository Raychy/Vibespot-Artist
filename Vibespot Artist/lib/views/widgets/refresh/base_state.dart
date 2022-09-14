part of 'base_bloc.dart';

abstract class BaseState<T> extends Equatable {
  factory BaseState.initial() => BaseListState();

  bool get isLoading;
  bool get hasError => message == null;
  String? get message;
  int get length;

  BaseState<T> copyWith();
  BaseState<T> loading();

  BaseState();
}

/// default implementation of base state
class BaseDefaultState<T> extends BaseState<T> {
  int get length => 0;

  final T? data;
  final bool isLoading;
  final String? message;

  BaseDefaultState({this.data, this.isLoading = false, this.message});

  factory BaseDefaultState.initial() => BaseDefaultState();

  BaseDefaultState<T> copyWith({T? data, String? message}) =>
      BaseDefaultState(data: data ?? this.data, message: message);
  @override
  BaseDefaultState<T> loading() => BaseDefaultState<T>(data: this.data, isLoading: true);
  @override
  List<Object?> get props => [message, data, isLoading];

  @override
  String toString() => '''{
    data: $data,
    message: $message,
      isLoading: $isLoading  
  }''';
}

/// flavour of base state to be used for a case where the data is a list
class BaseListState<T> extends BaseState<T> {
  int get length => data?.length ?? 0;
  bool get hasNext => (page ?? 0) < (pages ?? 0);

  final BuiltList<T>? data;
  final bool isLoading;
  final String? message, order, query;
  final int? total, pages, page, chunkCount, limit;

  BaseListState(
      {this.order,
      this.query,
      this.limit,
      this.total,
      this.chunkCount,
      this.pages,
      this.page,
      this.message,
      this.data,
      this.isLoading = false});

  factory BaseListState.initial() => BaseListState();

  BaseListState<T> copyWith(
          {BuiltList<T>? data,
          String? message,
          String? order,
          String? query,
          int? total,
          int? pages,
          int? limit, int? chunkCount,
          int? page}) =>
      BaseListState(
          order: order ?? this.order,
          query: query ?? this.query,
          limit: limit ?? this.limit,
          data: data ?? this.data,
          message: message,
          chunkCount: chunkCount ?? this.chunkCount,
          page: page ?? this.page,
          pages: pages ?? this.pages,
          total: total ?? this.total);

  @override
  List<Object?> get props =>
      [message, data, isLoading, page, pages, total, order, query, limit, chunkCount];

  @override
  String toString() => '''{
    message: $message,
    isLoading: $isLoading  
    page: $page, 
    pages: $pages 
    total: $total, 
    order: $order,
    chunkCount: $chunkCount, 
    query: $query, 
    limit: $limit,  
    data: data,
  }''';

  @override
  BaseListState<T> loading() => BaseListState<T>(
      data: this.data,
      message: this.message,
      page: this.page,
      isLoading: true,
      pages: this.pages,
      limit: this.limit,
      query: this.query,
      order: this.order,
      total: this.total);
}
