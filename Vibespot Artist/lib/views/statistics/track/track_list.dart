import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/playlist.dart';
import 'package:vsartist/models/song.dart';
import 'package:vsartist/views/statistics/playlist/bloc/playlist_bloc.dart';
import 'package:vsartist/views/widgets/content_placeholder.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';
import 'package:vsartist/views/widgets/refresh/base_refresher.dart';

import 'bloc/track_bloc.dart';
import 'track_tile.dart';

enum TrackListMode { none, select, search }

class TrackList extends StatefulWidget {
  final TrackBloc? bloc;
  final TrackListMode mode;
  final Map<String, dynamic> Function()? queryBuilder;
  final Function()? reloadList;
  final int count;

  final Album? album;
  const TrackList(
      {Key? key,
      this.bloc,
      this.queryBuilder,
      this.mode = TrackListMode.none,
      this.album,
      this.count = 1,
      this.reloadList})
      : super(key: key);
  // final String? id;
  @override
  _TrackListState createState() => _TrackListState();
}

class _TrackListState extends BaseListRefresher<TrackList, Song> {
  var query = <String, dynamic>{};
  @override
  void initState() {
    
    // if (widget.id != null) query.addAll({'id': widget.id});
    bloc = widget.bloc ?? TrackBloc(ApiUrls.TRACKS);
    if (widget.mode != TrackListMode.search) loadData();
    super.initState();
    BlocProvider.of<PlaylistBloc>(context).load();
  }

  // RefreshController get refreshController =>
  //     BlocProvider.of<PlaylistBloc>(context).refreshController;

  @override
  void dispose() {
    if (widget.bloc == null) bloc?.close();
    super.dispose();
  }

  @override
  void loadData([bool loadMore = false]) {
    bloc?.add(LoadDataEvent<Song>(
        loadMore: loadMore,
        query: widget.queryBuilder != null ? widget.queryBuilder!() : query));
  }

  static Widget _placeholder(BuildContext context) => ListView.builder(
      shrinkWrap: true,
      itemCount: 40,
      itemBuilder: (c, i) => ContentPlaceholder(
          child: TrackTile(
              placeholderMode: true,
              data: Song((b) => b
                ..title = ''
                ..id = 1))));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, BaseListState<Playlist>>(
      builder: (context, state) {
        return BlocBuilder<TrackBloc, BaseListState<Song>>(
            bloc: bloc as TrackBloc,
            builder: (context, state) => buildBody(context,
                loadingIndicator: _placeholder(context),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (c, i) {
                    var release = data![i];
                    return Padding(
                      padding: EdgeInsets.only(
                          top: i == 0 ? 20.0 : 0,
                          bottom: i == (length - 1) ? 40.0 : 0),
                      child: TrackTile(
                        reloadList: widget.reloadList,
                        album: widget.album, count: widget.count,
                        selectMode: widget.mode == TrackListMode.select,
                        // bloc: bloc as TrackBloc,
                        data: release,
                      ),
                    );
                  },
                )));
      },
    );
  }

  @override
  String? get message => (data == null || data!.length < 1)
      ? 'You currently have no tracks'
      : super.message;
}
