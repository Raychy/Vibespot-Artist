import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/release.dart';
import 'package:vsartist/views/widgets/content_placeholder.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';
import 'package:vsartist/views/widgets/refresh/base_refresher.dart';

import 'bloc/release_bloc.dart';
import 'release_tile.dart';

class ReleaseList extends StatefulWidget {
  final Album? album;
  final int? count, position, total;
  final Function()? reloadList;
  final bool select;
  const ReleaseList({Key? key, this.album, this.count, this.position, this.select = false, this.reloadList, this.total })
      : super(key: key);

  @override
  _ReleaseListState createState() => _ReleaseListState();
}

class _ReleaseListState extends BaseListRefresher<ReleaseList, Release> {
  @override
  void initState() {
    bloc = ReleaseBloc();

    super.initState();
    // bloc = context.read<ReleaseBloc>();
    loadData();
  }

  @override
  void dispose() {
    bloc?.close();
    super.dispose();
  }

  @override
  void loadData([bool loadMore = false]) {
    bloc?.add(LoadDataEvent<Release>(loadMore: loadMore, query: {}));
  }

  static Widget _placeholder(BuildContext context) => ListView.builder(
      shrinkWrap: true,
      itemCount: 40,
      itemBuilder: (c, i) => ContentPlaceholder(
          child: ReleaseTile(
              placeholderMode: true,
              release: Release((b) => b
                // ..releaseDate = DateTime.now().toString()
                // ..image = ''
                ..id = 1
                ..releaseName = ' '
                ..userId = 1))));

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReleaseBloc>(
      create: (context) => bloc as ReleaseBloc,
      child: BlocBuilder<ReleaseBloc, BaseListState<Release>>(
          bloc: bloc as ReleaseBloc,
          builder: (context, state) {
            // var list = data ?? [];
            // if(widget.select){
            //   list = list?.where((r) => r.selected).toList();
            // }
            return buildBody(context,
                loadingIndicator: _placeholder(context),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
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
                          child: ReleaseTile(
                            album: widget.album,
                            count: widget.count,
                            select: widget.select,
                            position: widget.position,
                            total: widget.total,
                            // bloc: bloc as ReleaseBloc,
                            release: release,
                            reloadList: widget.reloadList,
                          ),
                        );
                      },
                    )));
          }),
    );
  }

  @override
  String? get message => (data == null || data!.length < 1)
      ? 'You currently have no release'
      : super.message;
}
