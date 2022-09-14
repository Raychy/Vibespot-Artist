import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:vsartist/data/data_repository.dart';
import 'package:vsartist/data/remote/api_services/music_api_service.dart';
import 'package:vsartist/data/remote/pagination_handler.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/song.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';
import 'package:vsartist/views/widgets/refresh/refresher_list_bloc.dart';

part 'track_repository.dart';

class TrackBloc extends RefresherListBloc<Song> {
  final Map<String, dynamic>? query;
  final String path;
  late TrackRepository _repository;
  TrackBloc(this.path, [this.query]) : super(BaseListState<Song>.initial()) {
    _repository = TrackRepository(path, this);
  }

  @override
  Stream<BaseListState<Song>> mapEventToState(BaseEvent event) async* {
    if (event is LoadDataEvent<Song>) {
      yield state.loading();
      _repository.loadData(query: event.query, loadMore: event.loadMore);
    } else
      yield* super.mapEventToState(event);
  }

  void load() {
    this.add(LoadDataEvent<Song>(loadMore: false, query: query));
  }
}
