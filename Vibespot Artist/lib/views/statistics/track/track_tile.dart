import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/song.dart';
import 'package:vsartist/services/share_service.dart';
import 'package:vsartist/views/statistics/playlist/bloc/playlist_bloc.dart';
import 'package:vsartist/views/upload/cubit/track_cubit.dart';
import 'package:vsartist/views/widgets/cached_image.dart';

import 'bloc/track_bloc.dart';

class TrackTile extends StatelessWidget {
  final Song data;
  final Album? album;
  final bool placeholderMode;
  final Function()? reloadList;
  final bool selectMode;
  final int count;
  const TrackTile(
      {Key? key,
      required this.data,
      this.reloadList,
      this.placeholderMode = false,
      this.selectMode = false,
      this.album,
      this.count = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var inPlaylist = context
        .watch<PlaylistBloc>()
        .hasItem((data.trackId ?? data.id)?.toString() ?? '');
    return ListTile(
      onTap: placeholderMode
          ? null
          : () {
              if (selectMode)
                TrackCubit()
                    .releaseToAlbum(context, data.id?.toString() ?? '',
                        album?.id?.toString() ?? '',
                        count: count)
                    .then((value) => reloadList != null ? reloadList!() : null);
              // Navigator.of(context).push( MaterialPageRoute(builder: (context) {
              //   return  MusicList(
              //       id:data.albumId, type: 'data', title:data.title);
              // }));
            },
      leading: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Material(
            clipBehavior: Clip.antiAlias,
            shape: CircleBorder(),
            child: CachedImage(
              url: data.image ?? data.songImage ?? '',
              fit: BoxFit.cover,
            )),
      ),
      title: placeholderMode
          ? Container(width: 300, height: 6, color: Colors.white)
          : Text(data.title, style: TextStyle(color: Colors.white)),
      subtitle: placeholderMode
          ? Row(
              children: [
                SizedBox(
                    width: 200,
                    child:
                        Container(width: 100, height: 4, color: Colors.white)),
              ],
            )
          : Text(
              '${data.title} ${data.genre ?? ''} ',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 11.0),
            ),
      trailing: placeholderMode
          ? SizedBox(
              width: 20,
              height: 20,
              child: Material(shape: CircleBorder(), color: Colors.white))
          : PopupMenuButton(
              onSelected: (String v) => onSelected(context, v),
              itemBuilder: (c) => [
                    PopupMenuItem(
                      value: 'add',
                      child: Row(children: [
                        Icon(inPlaylist ? Icons.remove_circle : Icons.add),
                        SizedBox(width: 10),
                        Text(inPlaylist
                            ? 'Remove from playlist'
                            : 'Add to playlist')
                      ]),
                    ),
                    if (data.dynamicLinkUrl != null)
                      PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(Icons.share),
                            SizedBox(width: 10),
                            Text('Share'),
                          ],
                        ),
                      ),
                    if (album != null)
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            SizedBox(width: 10),
                            Text('Delete'),
                          ],
                        ),
                      ),
                  ]),
    );
  }

  onSelected(BuildContext context, String value) {
    switch (value) {
      case 'delete':
        if (album != null)
          TrackCubit()
              .delete(context,
                  albumID: album!.id.toString(),
                  trackID: data.id?.toString() ?? '')
              .then((value) => GetIt.I<TrackBloc>().load());
        break;
      case 'share':
        if (data.dynamicLinkUrl != null) {
          ShareService.text(data.dynamicLinkUrl ?? '');
        }
        break;
      case 'add':
        TrackCubit()
            .addTrackToPlaylist(context, (data.trackId ?? data.id).toString())
            .then((value) => BlocProvider.of<PlaylistBloc>(context).load());
        break;
      case 'shares':
        break;
      default:
    }
  }
}
