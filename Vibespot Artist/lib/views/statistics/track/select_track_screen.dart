import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/transissions/slide_side_route.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/song.dart';
import 'package:vsartist/views/statistics/release/release_list.dart';
import 'package:vsartist/views/statistics/track/bloc/track_bloc.dart';
import 'package:vsartist/views/upload/upload_options.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';

import 'track_list.dart';

class SelectTrackScreen extends StatefulWidget {
  final Album data;
  final Function()? reloadList;
  final Widget? navigateTo;
  final int count, position, total;

  const SelectTrackScreen({
    Key? key,
    required this.data,
    this.count = 1,
    this.position = 1,
    this.total = 1,
    this.reloadList,
    this.navigateTo,
  }) : super(key: key);

  @override
  _AlbumTrackScreenState createState() => _AlbumTrackScreenState();
}

class _AlbumTrackScreenState extends State<SelectTrackScreen> {
  late TrackBloc _bloc;
  late Map<String, dynamic> query;

  @override
  void initState() {
    query = {'id': widget.data.id};
    _bloc = TrackBloc(ApiUrls.ALBUM_TRACK);
    super.initState();
  }

  _reload() {
    _bloc.add(LoadDataEvent<Song>(loadMore: false, query: query));
  }

  // _uploadTrack() => Navigator.push(
  //         context,
  //         SlideSideRoute(
  //             settings: RouteSettings(name: 'track upload'),
  //             page: UploadOptions(album: widget.data, count: widget.count, navigateTo: widget.navigateTo,)))
  //     .then((value) => _reload());

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
        appTitle: '${widget.data.title}',
        // floatingActionButton: BlocBuilder<TrackBloc, BaseListState<Song>>(
        //   bloc: _bloc,
        //   builder: (context, state) {
        //     if (state.length < (widget.data.trackCount ?? 0))
        //       return FloatingActionButton(
        //           backgroundColor: AppColors.PRIMARY,
        //           child: Icon(CupertinoIcons.add, color: Colors.white),
        //           onPressed: _uploadTrack);
        //     // return FloatingActionButton.extended(
        //     //     backgroundColor: AppColors.PRIMARY,
        //     //     label: Text('Finalize album'),
        //     //     onPressed: () => Navigator.push(
        //     //         context,
        //     //         SlideSideRoute(
        //     //             settings: RouteSettings(name: 'Album upload'),
        //     //             page: TrackUpload(album: widget.data))));
        //     return SizedBox();
        //   },
        // ),
        bodyData: ReleaseList(
          // queryBuilder: () => query,
          album: widget.data,
          count: widget.count, position: widget.position,
          reloadList: widget.reloadList, total: widget.total,
          select: true,
        ));
  }
}
