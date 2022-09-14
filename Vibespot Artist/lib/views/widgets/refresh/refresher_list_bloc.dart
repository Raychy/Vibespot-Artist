import 'package:built_collection/built_collection.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_bloc.dart';

/// base class for blocs that the main data is a list
abstract class RefresherListBloc<T> extends BaseBloc<T, BaseListState<T>> {
  final RefreshController refreshController =
      RefreshController(initialLoadStatus: LoadStatus.idle);

  RefresherListBloc(BaseListState<T> initialState) : super(initialState);

  // @override
  // BaseListState<T> get initialState => BaseListState<T>.initial();

  @override
  Stream<BaseListState<T>> mapEventToState(BaseEvent event) async* {
    if (event is LoadFailed) {
      yield state.copyWith(message: event.message);
      refreshController.loadComplete();
      refreshController.refreshCompleted();
    } else if (event is UpdateDataListEvent<T>) {
      // print('UpdateDataListEvent ${event.isMore}');
      BuiltList<T>? data = event.data;
      if (event.isMore)
        data = BuiltList.from([...?(state.data), ...(event.data)]);

      yield state.copyWith(
          data: data,
          page: event.page,
          pages: event.pages,
          limit: event.limit,
          query: event.query,
          order: event.order,
          chunkCount: event.chunkCount,
          total: event.total);
      refreshController.loadComplete();
      refreshController.refreshCompleted();
    }
  }
}
