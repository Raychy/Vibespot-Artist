import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


part 'base_event.dart';
part 'base_state.dart';


/// base class for blocs with simple routine functions
abstract class BaseBloc<T, S extends BaseState<T>>
    extends Bloc<BaseEvent, S> {
  /// must implement base repository
  // dynamic repository;
  RefreshController? refreshController;

  BaseBloc(S initialState) : super(initialState);

  // @override
  // S get initialState => BaseState<T>.initial();

}
