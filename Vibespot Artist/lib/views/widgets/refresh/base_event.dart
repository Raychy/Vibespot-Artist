part of 'base_bloc.dart';

abstract class BaseEvent extends Equatable {
  const BaseEvent();
}

// generic event to load data,
class LoadDataEvent<T> extends BaseEvent {
  final bool loadMore;
  final String? id;
  final bool useCache;
  final Map<String, dynamic>? query;
  final int? limit;
  final String? q;

  LoadDataEvent(
      {this.q, this.limit, this.useCache = false, this.query, this.loadMore = false, this.id});
  @override
  List<Object?> get props => [loadMore, id, q, query];
  @override
  String toString() => 'LoadDataEvent';
}

class DeleteDataEvent<T> extends BaseEvent {
  final String id;
  final Map<String, dynamic>? query;

  DeleteDataEvent(this.id, [this.query]);
  @override
  List<Object> get props => [id];
  @override
  String toString() => 'DeleteDataEvent/$id';
}

class UpdateDataListEvent<T> extends BaseEvent {
  final BuiltList<T> data;
  final bool isMore;
  final int? total;
  final int? pages;
  final int? page;
  final int? chunkCount;
  final int? limit;
  final String? query, order;

  UpdateDataListEvent(this.data, this.isMore,
      {this.chunkCount,
      this.limit,
      this.query,
      this.order,
      this.total,
      this.pages,
      this.page});
  @override
  List<Object?> get props =>
      [data, isMore, total, pages, page, chunkCount, limit, query, order];

  @override
  String toString() => 'UpdateDataListEvent';
}

class UpdateDataEvent<T> extends BaseEvent {
  final T data;

  UpdateDataEvent(this.data);
  @override
  List<Object?> get props => [data];

  @override
  String toString() => 'UpdateDataEvent';
}

class LoadFailed<T> extends BaseEvent {
  final String message;

  LoadFailed(this.message);

  @override
  List<Object> get props => [message];
  @override
  String toString() => 'LoadFailed';
}
