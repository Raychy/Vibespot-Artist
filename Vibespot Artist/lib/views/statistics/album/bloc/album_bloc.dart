import 'dart:async';

import 'package:built_collection/built_collection.dart'; 
import 'package:get_it/get_it.dart';
import 'package:vsartist/data/data_repository.dart';
import 'package:vsartist/data/remote/api_services/music_api_service.dart';
import 'package:vsartist/data/remote/pagination_handler.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';
import 'package:vsartist/views/widgets/refresh/refresher_list_bloc.dart';

part 'album_repository.dart';

class AlbumBloc extends RefresherListBloc<Album> {
  late AlbumRepository _repository;
  AlbumBloc({this.read = false}) : super(BaseListState<Album>.initial()) {
    _repository = AlbumRepository(this);
  } 

  final bool read;

  @override
  Stream<BaseListState<Album>> mapEventToState(BaseEvent event) async* {
    if (event is LoadDataEvent<Album>) {
      yield state.loading();
      _repository.loadData(query: event.query, loadMore: event.loadMore);
    } else
      yield* super.mapEventToState(event);
  }

  void load() {
    this.add(LoadDataEvent<Album>(loadMore: false, ));
  }
}
