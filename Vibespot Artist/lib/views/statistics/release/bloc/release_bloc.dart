import 'dart:async';

import 'package:built_collection/built_collection.dart';  
import 'package:vsartist/data/data_repository.dart';
import 'package:vsartist/data/remote/api_services/music_api_service.dart';
import 'package:vsartist/data/remote/pagination_handler.dart';
import 'package:vsartist/models/release.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';
import 'package:vsartist/views/widgets/refresh/refresher_list_bloc.dart';

part 'release_repository.dart';

class ReleaseBloc extends RefresherListBloc<Release> {
  late ReleaseRepository _repository;
  ReleaseBloc({this.read = false}) : super(BaseListState<Release>.initial()) {
    _repository = ReleaseRepository(this);
  } 

  final bool read;

  @override
  Stream<BaseListState<Release>> mapEventToState(BaseEvent event) async* {
    if (event is LoadDataEvent<Release>) {
      yield state.loading();
      _repository.loadData(query: event.query, loadMore: event.loadMore);
    } else
      yield* super.mapEventToState(event);
  }

  void load() {
    this.add(LoadDataEvent<Release>(loadMore: false, ));
  }
}
