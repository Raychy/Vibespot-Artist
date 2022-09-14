import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/dimens.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/views/statistics/album/bloc/album_bloc.dart';
import 'package:vsartist/views/widgets/content_placeholder.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';
import 'package:vsartist/views/widgets/refresh/base_refresher.dart';

import 'album_tile.dart';

class AlbumList extends StatefulWidget {
  final AlbumBloc? bloc;
  const AlbumList({Key? key, this.bloc}) : super(key: key);

  @override
  _AlbumListState createState() => _AlbumListState();
}

class _AlbumListState extends BaseListRefresher<AlbumList, Album> {
  @override
  void initState() {
    bloc = widget.bloc ?? AlbumBloc();
    loadData();
    super.initState();
  }

  @override
  void dispose() {
    if (widget.bloc == null) bloc?.close();
    super.dispose();
  }

  @override
  void loadData([bool loadMore = false]) {
    bloc?.add(LoadDataEvent<Album>(loadMore: loadMore, query: {}));
  }

  static Widget _placeholder(BuildContext context) => ListView.builder(
      shrinkWrap: true,
      itemCount: 40,
      itemBuilder: (c, i) => ContentPlaceholder(
          child: AlbumTile(
              placeholderMode: true,
              album: Album((b) => b
                // ..releaseDate = DateTime.now().toString()
                ..image = ''
                ..id = 1
                ..description = ' '
                ..title = ' '))));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AlbumBloc>(
      create: (context) => bloc as AlbumBloc,
      child: BlocBuilder<AlbumBloc, BaseListState<Album>>(
          bloc: bloc as AlbumBloc,
          builder: (context, state) => buildBody(context,
              loadingIndicator: _placeholder(context),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (c, i) {
                  var album = data![i];
                  return Padding(
                    padding: EdgeInsets.only(
                        top: i == 0 ? 20.0 : 0,
                        bottom: i == (length - 1) ? 40.0 : 0),
                    child: AlbumTile(
                        reloadPage: loadData,
                        // bloc: bloc as AlbumBloc,
                        album: album),
                  );
                },
              ))),
    );
  }

  @override
  String? get message => (data == null || data!.length < 1)
      ? 'You currently have no albums'
      : super.message;
}
