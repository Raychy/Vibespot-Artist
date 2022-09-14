import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/transissions/slide_side_route.dart';
import 'package:vsartist/models/release.dart';
import 'package:vsartist/models/song.dart';
import 'package:vsartist/views/upload/track_upload.dart';
import 'package:vsartist/views/widgets/app_dialog.dart';
import 'package:vsartist/views/widgets/common-scaffold.dart';
import 'package:vsartist/views/widgets/refresh/base_bloc.dart';

import 'bloc/track_bloc.dart';
import 'track_list.dart';

class ReleaseTrackScreen extends StatefulWidget {
  final Release data;
  final bool startMode;
  const ReleaseTrackScreen(
      {Key? key, required this.data, this.startMode = false})
      : super(key: key);

  @override
  _ReleaseTrackScreenState createState() => _ReleaseTrackScreenState();
}

class _ReleaseTrackScreenState extends State<ReleaseTrackScreen> {
  late TrackBloc _bloc;

  @override
  void initState() {
    _bloc = TrackBloc(ApiUrls.RELEASE_TRACK);
    super.initState();
    if (widget.startMode)
      Future.delayed(Duration(milliseconds: 2000), () {
        AppDialog.show(context, 'Upload Song', 'Upload track now ?', actions: [
          DialogAction(
            'Close',
          ),
          DialogAction('Continue', (c) => _uploadTrack()),
        ]);
      });
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  _uploadTrack() => Navigator.push(
      context,
      SlideSideRoute(
          settings: RouteSettings(name: 'track upload'),
          page: TrackUpload(
              release: widget.data,
              // navigateTo:  
              //   ReleaseTrackScreen(data: widget.data)
              )));

  @override
  Widget build(BuildContext context) {
    return ScaffoldCommon(
        appTitle: '${widget.data.releaseName}',
        floatingActionButton: BlocBuilder<TrackBloc, BaseListState<Song>>(
            bloc: _bloc,
            builder: (context, state) {
              if (state.length < (widget.data.trackCount ?? 0))
                return FloatingActionButton(
                    backgroundColor: AppColors.PRIMARY,
                    child: Icon(CupertinoIcons.add, color: Colors.white),
                    onPressed: _uploadTrack);

              // return FloatingActionButton.extended(
              //   backgroundColor: AppColors.PRIMARY,
              //   label: Text('Finalize release'),
              //   onPressed: () => Navigator.push(
              //       context,
              //       SlideSideRoute(
              //           settings: RouteSettings(name: 'Album upload'),
              //           page: TrackUpload(album: widget.data))));
              return SizedBox();
            }),
        bodyData:
            TrackList(queryBuilder: () => {'id': widget.data.id}, bloc: _bloc));
  }
}
