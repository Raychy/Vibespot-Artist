import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/dimens.dart';
import 'package:vsartist/models/playlist.dart';
import 'package:vsartist/views/widgets/content_placeholder.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';
import 'package:vsartist/views/widgets/refresh/base_refresher.dart';

import 'bloc/playlist_bloc.dart';
import 'playlist_tile.dart';

class PlaylistList extends StatefulWidget {
  const PlaylistList({Key? key}) : super(key: key);

  @override
  _PlaylistListState createState() => _PlaylistListState();
}

class _PlaylistListState extends BaseListRefresher<PlaylistList, Playlist> {
  @override
  void initState() {
    // bloc = PlaylistBloc();
    Future.delayed(Duration(milliseconds: 100), loadData);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<PlaylistBloc>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // bloc?.close();
    super.dispose();
  }

  @override
  void loadData([bool loadMore = false]) {
    bloc?.add(LoadDataEvent<Playlist>(loadMore: loadMore, query: {}));
  }

  static Widget _placeholder(BuildContext context) => ListView.builder(
      shrinkWrap: true,
      itemCount: 40,
      itemBuilder: (c, i) => ContentPlaceholder(
          child: PlaylistTile(
              reloadPage: () {},
              placeholderMode: true,
              data: Playlist((b) => b
                ..title = ''
                ..id = 1))));

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistBloc, BaseListState<Playlist>>(
        bloc: bloc as PlaylistBloc,
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
                  child: PlaylistTile(
                    reloadPage: loadData,
                    // bloc: bloc as PlaylistBloc,
                    data: release,
                  ),
                );
              },
            )));
  }

  @override
  String? get message => (data == null || data!.length < 1)
      ? 'You currently have no playlists'
      : super.message;
}
