import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/transissions/slide_side_route.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/song.dart';
import 'package:vsartist/views/statistics/track/bloc/track_bloc.dart';
import 'package:vsartist/views/upload/upload_options.dart';
import 'package:vsartist/views/widgets/app_dialog.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';

import 'track_list.dart';

class AlbumTrackScreen extends StatefulWidget {
  final Album data;
  final bool startMode;
  final Function()? reloadPage;

  const AlbumTrackScreen(
      {Key? key, required this.data, this.startMode = false, this.reloadPage})
      : super(key: key);

  @override
  _AlbumTrackScreenState createState() => _AlbumTrackScreenState();
}

class _AlbumTrackScreenState extends State<AlbumTrackScreen> {
  late TrackBloc _bloc;
  late Map<String, dynamic> query;

  int instance = 0;
  int oldInstance = 0;

  @override
  void initState() {
    query = {'id': widget.data.id};
    GetIt.I.registerSingleton<TrackBloc>(TrackBloc(ApiUrls.ALBUM_TRACK, query));
    _bloc = GetIt.I<TrackBloc>();
    super.initState();
    if (widget.startMode)
      Future.delayed(Duration(milliseconds: 100), () {
        _uploadTrack();
        // AppDialog.show(context, 'Upload Tracks', 'Upload track now ?',
        //     actions: [
        //       DialogAction(
        //         'Close',
        //       ),
        //       DialogAction('Continue', (c) => _uploadTrack()),
        //     ]);
      });
  }

  _reload() {
    _bloc.add(LoadDataEvent<Song>(loadMore: false, query: query));
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
    if (oldInstance == instance) return;

    oldInstance = instance;
    _reload();
  }

  _uploadTrack() {
    Navigator.push(
        context,
        SlideSideRoute(
            settings: RouteSettings(name: 'track upload'),
            page: UploadOptions(
              album: widget.data,
              total: (widget.data.trackCount ?? 1),
              count: (widget.data.trackCount ?? 1) - (_bloc.state.data?.length ?? 0),
              position:
                  widget.startMode ? 1 : ((_bloc.state.data?.length ?? 0) + 1),
              reloadPage: _reload(),
            ))).then((value) => _reload());
    Future.delayed(Duration(milliseconds: 1000), () => instance++);
  }

  @override
  void dispose() {
    GetIt.I.unregister<TrackBloc>();
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
        appTitle: '${widget.data.title}',
        floatingActionButton: BlocBuilder<TrackBloc, BaseListState<Song>>(
          bloc: _bloc,
          builder: (context, state) {
            if (state.isLoading) return SizedBox();
            if (state.length < (widget.data.trackCount ?? 0))
              return FloatingActionButton(
                  backgroundColor: AppColors.PRIMARY,
                  child: Icon(CupertinoIcons.add, color: Colors.white),
                  onPressed: _uploadTrack);
            // return FloatingActionButton.extended(
            //     backgroundColor: AppColors.PRIMARY,
            //     label: Text('Finalize album'),
            //     onPressed: () => Navigator.push(
            //         context,
            //         SlideSideRoute(
            //             settings: RouteSettings(name: 'Album upload'),
            //             page: TrackUpload(album: widget.data))));
            return SizedBox();
          },
        ),
        bodyData: TrackList(
          bloc: _bloc,
          queryBuilder: () => query,
          reloadList: _reload(),
          album: widget.data, 
        ));
  }
}
