import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vsartist/data/data_repository.dart';
import 'package:vsartist/data/remote/api_services/music_api_service.dart';
import 'package:vsartist/data/remote/pagination_handler.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/playlist.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';
import 'package:vsartist/views/widgets/refresh/refresher_list_bloc.dart';

part 'playlist_repository.dart';

class PlaylistBloc extends RefresherListBloc<Playlist> {
  late PlaylistRepository _repository;
  // final  RefreshController   refreshController = RefreshController();
  PlaylistBloc({this.read = false}) : super(BaseListState<Playlist>.initial()) {
    _repository = PlaylistRepository(this);
  }

  final bool read;

  @override
  Stream<BaseListState<Playlist>> mapEventToState(BaseEvent event) async* {
    if (event is LoadDataEvent<Playlist>) {
      yield state.loading();
      _repository.loadData(query: event.query, loadMore: event.loadMore);
    } else
      yield* super.mapEventToState(event);
  }

  void load() {
    this.add(LoadDataEvent<Playlist>(
      loadMore: false,
    ));
  }

  bool hasItem(String trackId) {
    // print(state.data);
    return state.data
            ?.where((a) => a.trackId.toString() == trackId)
            .toList()
            .isNotEmpty ??
        false;
  }
}
