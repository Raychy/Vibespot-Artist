import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'base_bloc.dart';

/// base class for blocs that the main data is not a list
abstract class RefresherBloc<T> extends BaseBloc<T, BaseDefaultState<T>> {
  final RefreshController refreshController =
      RefreshController(initialLoadStatus: LoadStatus.idle);

  RefresherBloc(BaseDefaultState<T> initialState) : super(initialState);

  // @override
  // BaseDefaultState<T> get initialState => BaseDefaultState<T>.initial();
  void loadData(String? id);
  @override
  Stream<BaseDefaultState<T>> mapEventToState(BaseEvent event) async* {
    if (event is LoadFailed) {
      yield state.copyWith(message: event.message);
      refreshController.loadComplete();
      refreshController.refreshCompleted();
    } else if (event is UpdateDataEvent) {
      yield state.copyWith(
        data: event.data,
      );
      refreshController.loadComplete();
      refreshController.refreshCompleted();
    } else if (event is LoadDataEvent) {
      yield state.loading();
      loadData(event.id);
    }
  }
}
